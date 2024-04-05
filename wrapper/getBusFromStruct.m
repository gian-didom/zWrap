function busInfo = getBusFromStruct(prefix,sp)

name = '';
fileName = '';
format = 'cell';

scope = Simulink.data.BaseWorkspace;

  busInfo = [];
  name = createBus(sp, '', prefix, name, 0, scope);
  if isempty(name) 
    return;
  end

  busInfo.block = [];
  busInfo.busName = name;
   
  if ~isempty(fileName)
        busNames = {};
        % Created bus names corresponding to the specified blocks
        % Also save related buses (buses defined by elements)
        busNames = get_dependent_bus_names(name, busNames, scope);
        busNames = unique(busNames);
        Simulink.Bus.save(fileName, format, busNames, scope);
  end
end

% Create Bus object (recursive calls)
function [busName, idx]= createBus(sp, path, prefix, name, idx, scope)
  busName=[];
  if ~isstruct(sp)
      return;
  end
  
  if ~isempty(path)
      path = [path, '.'];
  end
  
  busObj=Simulink.Bus;
  nodeNames = fieldnames(sp);
  tmpBusObjElementsSize = size(nodeNames,1);
  tmpBusObjElements = Simulink.BusElement.empty(tmpBusObjElementsSize,0);
  for n=1:size(nodeNames,1)
    node = sp.(nodeNames{n});
    if isstruct(node)
        % Generate sub-bus
        subBusName = nodeNames{n};
        if numel(node) > 1
            checkSubStructuresForConsistency([path, nodeNames{n}], node);
        end
        [subBusName, idx] = createBus(node, [path, nodeNames{n}], prefix, subBusName, idx, scope); 
        el=Simulink.BusElement;
        el.Name =nodeNames{n};
        el.DataType =subBusName;
        % [1x1x1] => 1 (retain default dims for bus element)
        if isequal(numel(node), 1)
            el.Dimensions = 1;
        else
            el.Dimensions = size(node);
        end
        tmpBusObjElements(end+1)=el; %#ok
    elseif isnumeric(node) || ...
            islogical(node) || ...
            isa(node, 'timeseries') || ...
            isa(node, 'timetable') || ...
            isa(node, 'matlab.io.datastore.SimulationDatastore') || ...
            isa(node, 'matlab.io.datastore.MDFDatastore')
        el=Simulink.BusElement;
        el.Name =nodeNames{n};
        try
            [el.DataType, el.Dimensions, el.Complexity]=getValueAttr(node);
        catch me
            DAStudio.error('Simulink:tools:slbusCreateObjectGeneric', ...
                [path, nodeNames{n}], me.message);
        end
        tmpBusObjElements(end+1)=el; %#ok
    elseif isstring(node) || ischar(node)
        if isstring(node)
            loc_char = node.char();
        else
            loc_char = node;
        end
        
        if(~isvector(loc_char)&&~isempty(loc_char)) 
            DAStudio.error('Simulink:tools:slbusCreateObjectNonVectorStringStructField', ...
                [path, nodeNames{n}]);
        end
        
        el=Simulink.BusElement;
        el.Name =nodeNames{n};
        el.DataType = 'string';
        el.Complexity = 'real';
        el.Dimensions = 1;
        tmpBusObjElements(end+1) = el; %#ok
    else
       DAStudio.error('Simulink:tools:slbusCreateObjectNonNumericStructField', ...
                       [path, nodeNames{n}]);
   end       
  end
  
  busObj.Elements = tmpBusObjElements;

  [busName, idx] = generateBusName(prefix, path, name, idx, scope);
  scope.assignin(busName, busObj);
end

% Check substructures of an array for consistency
function checkSubStructuresForConsistency(path, node)
    assert(isstruct(node) && numel(node) > 1);    
    for idx = 1:numel(node)-1
        path1 = [path '(' num2str(idx) ')'];
        path2 = [path '(' num2str(idx+1) ')'];
        compareStructsForSimilarity(path1, path2, node(idx), node(idx+1));
    end
end

% Check two structures for compatibility
function compareStructsForSimilarity(path1, path2, s1, s2)
    
    if ~isequal(fieldnames(s1),fieldnames(s2))
        DAStudio.error('Simulink:tools:slbusCreateObjectOrderMismatch', ...
            path1, path2);
    end
    
    fnames = fieldnames(s1);
    for idx = 1:numel(fnames)
        s1field = s1.(fnames{idx});
        s2field = s2.(fnames{idx});
        
        pathloop1 = [path1 '.' fnames{idx}];
        pathloop2 = [path2 '.' fnames{idx}];
        if (isstruct(s1field) && ~isstruct(s2field))
            DAStudio.error('Simulink:tools:slbusCreateObjectStructNonStructMismatch', ...
                pathloop1, pathloop2);
        end
        
        if (isstruct(s2field) && ~isstruct(s1field))
            DAStudio.error('Simulink:tools:slbusCreateObjectStructNonStructMismatch', ...
                pathloop2, pathloop1);
        end            
        
        if ~isequal(size(s1field), size(s2field))
            DAStudio.error('Simulink:tools:slbusCreateObjectDimsMismatch', ...
                pathloop1, pathloop2);
        end
        
        if isstruct(s1field)
            appendIndex = (numel(s1field) > 1);
            p1 = pathloop1;
            p2 = pathloop2;
            for jdx = 1:numel(s1field)
                if appendIndex
                    p1 = [pathloop1 '(' num2str(jdx) ')'];
                    p2 = [pathloop2 '(' num2str(jdx) ')'];
                end
                compareStructsForSimilarity(p1, p2, s1field(jdx), s2field(jdx));
            end
        else
            if ~isequal(class(s1field), class(s2field))
                DAStudio.error('Simulink:tools:slbusCreateObjectDataTypeMismatch', ...
                    pathloop1, pathloop2);
            end
            
            if ~isequal(isreal(s1field), isreal(s2field))
                DAStudio.error('Simulink:tools:slbusCreateObjectComplexityMismatch', ...
                    pathloop1, pathloop2);
            end
            
        end
        
    end
    
end

% Get DataType, Dims and Complexity
function [dt, dims, compl] = getValueAttr(val)
  if isa(val, 'timetable')
      if numel(val.Properties.VariableNames) > 1
          throwAsCaller(MSLException(message('Simulink:tools:slbusCreateObjectMultiColumnTimetable')));
      end
      [dt, dims, compl] = getValueAttrTT(val);
      return
  elseif isa(val, 'matlab.io.datastore.SimulationDatastore') || ...
          isa(val, 'matlab.io.datastore.MDFDatastore')
      prev = val.preview;
      if numel(prev.Properties.VariableNames) > 1
          throwAsCaller(MSLException(message('Simulink:tools:slbusCreateObjectMultiChannelDatastore')));
      end
      [dt, dims, compl] = getValueAttrTT(prev);
      return
  end
  
  p = Simulink.Parameter;
  dataValue = val;
  if isa(val,'timeseries')
      dataValue = val.Data;      
  end
  p.Value = dataValue;
  compl = p.Complexity;
  dt = p.DataType;   
  if isequal(dt, 'auto')
      dt = 'double';
  end
  if isa(val,'timeseries')
      dims = Simulink.SimulationData.TimeseriesUtil.getSampleDimensions(val);
  else
      dims = p.Dimensions;
  end  
end

% Get DataType, Dims and Complexity when value is a timetable
function [dt, dims, compl] = getValueAttrTT(val)
  p = Simulink.Parameter;
  dataValue = val.Variables;
  p.Value = dataValue;
  compl = p.Complexity;
  dt = p.DataType;
  if isequal(dt, 'auto')
      dt = 'double';
  end
  dims = p.Dimensions(2:end); 
end

% Generate valid bus name
% name - is proposed name (could be empty)
function [busName, idx] = generateBusName(prefix, path, name, idx, scope)
  
  busName = prefix;
  pathNames = split(path,'.');
  for i=1:length(pathNames)
      if(~isempty(pathNames{i}))
          busName = [busName, '_' pathNames{i}];
      end
  end
  if(isvarname(busName) && scope.exist(busName))
      error(['Bus with name ' busName ' already exists'])
  end
   
%   if isvarname(name)
%     needNewName = scope.exist(name);
%     postfix = ['_' name];
%   else
%     needNewName = true;
%     postfix = '';
%   end
% 
%   while(needNewName)
%       idx = idx + 1;
%       busName = [prefix num2str(idx) postfix];
%       needNewName = scope.exist(busName);
%   end
end