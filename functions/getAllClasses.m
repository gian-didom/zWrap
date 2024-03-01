function [mc_list,subcls_list] = getAllClasses(includeBulkFiles,includePackages)
%% Input handling
if nargin < 2 || isempty(includePackages)
  includePackages = false;
  mp_list = meta.package.empty;
end
if nargin < 1 || isempty(includeBulkFiles)
  includeBulkFiles = false;
  mb_list = meta.class.empty; %#ok
  % `mb_list` is always overwritten by the output of meta.class.getAllClasses; 
end
%% Output checking
if nargout < 2
  warning('Second output not assigned!');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Get classes list from bulk files "laying around" the MATLAB path:
if includeBulkFiles
  % Obtain MATLAB path:
  p = strsplit(path,pathsep).';
  if ~ismember(pwd,p)
    p = [pwd;p];
  end
  nPaths = numel(p);
  s = what; s = repmat(s,nPaths+20,1); % Preallocation; +20 is to accomodate rare cases 
  s_pos = 1;                           %  where "what" returns a 2x1 struct.
  for ind1 = 1:nPaths  
    tmp = what(p{ind1});
    s(s_pos:s_pos+numel(tmp)-1) = tmp;
    s_pos = s_pos + numel(tmp);
  end
  s(s_pos:end) = []; % truncation of placeholder entries.
  clear p nPaths s_pos tmp
  %% Generate a list of classes:
  % from .m files:
  m_files = vertcat(s.m);
  % from .p files:
  p_files = vertcat(s.p);
  % get a list of potential class names:
  [~,name,~] = cellfun(@fileparts,[m_files;p_files],'uni',false);
  % get listed classes:
  listed_classes = s.classes;
  % combine all potential class lists into one:
  cls_list = vertcat(name,listed_classes);
  % test which ones are actually classes:
  isClass = cellfun(@(x)exist(x,'class')==8,cls_list); %"exist" method; takes long
  %[u,ia,ic] = unique(ext(isClass(1:numel(ext)))); %DEBUG:

  % for valid classes, get metaclasses from name; if a classdef contains errors,
  % will cause cellfun to print the reason using ErrorHandler.
  [~] = cellfun(@meta.class.fromName,cls_list(isClass),'uni',false,'ErrorHandler',...
     @(ex,in)meta.class.empty(0*fprintf(1,'The classdef for "%s" contains an error: %s\n'...
                                         , in, ex.message)));
  % The result of the last computation used to be assigned into mc_list, but this 
  % is no longer required as the same information (and more) is returned later
  % by calling "mb_list = meta.class.getAllClasses" since these classes are now cached.
  clear cls_list isClass ind1 listed_classes m_files p_files name s
end
%% Get class list from classes belonging to packages (takes long!):

if includePackages
  % Get a list of all package classes:
  mp_list = meta.package.getAllPackages; mp_list = vertcat(mp_list{:});  
  % see http://www.mathworks.com/help/matlab/ref/meta.package.getallpackages.html

  % Recursively flatten package list:
  mp_list = flatten_package_list(mp_list);

  % Extract classes out of packages:
  mp_list = vertcat(mp_list.ClassList);
end
%% Combine lists:
% Get a list of all classes that are in memory:
mb_list = meta.class.getAllClasses; 
mc_list = union(vertcat(mb_list{:}), mp_list);
%% Map relations:
try
  [subcls_list,discovered_classes] = find_superclass_relations(mc_list);
  while ~isempty(discovered_classes)
    mc_list = union(mc_list, discovered_classes);
    [subcls_list,discovered_classes] = find_superclass_relations(mc_list);
  end
catch ex % Turns out this helps....
  disp(['Getting classes failed with error: ' ex.message ' Retrying...']);
  [mc_list,subcls_list] = q37829489;
end

end

function [subcls_list,discovered_classes] = find_superclass_relations(known_metaclasses)
%% Build hierarchy:
sup_list = {known_metaclasses.SuperclassList}.';
% Count how many superclasses each class has:
n_supers = cellfun(@numel,sup_list);
% Preallocate a Subclasses container: 
subcls_list = cell(numel(known_metaclasses),1); % should be meta.MetaData
% Iterate over all classes and 
% discovered_classes = meta.class.empty(1,0); % right type, but causes segfault
discovered_classes = meta.class.empty;
for depth = max(n_supers):-1:1
  % The function of this top-most loop was initially to build a hierarchy starting 
  % from the deepest leaves, but due to lack of ideas on "how to take it from here",
  % it only serves to save some processing by skipping classes with "no parents".
  tmp = known_metaclasses(n_supers == depth);
  for ind1 = 1:numel(tmp)
    % Fortunately, SuperclassList only shows *DIRECT* supeclasses. Se we
    % only need to find the superclasses in the known classees list and add
    % the current class to that list.
    curr_cls = tmp(ind1);
    % It's a shame bsxfun only works for numeric arrays, or else we would employ: 
    % bsxfun(@eq,mc_list,tmp(ind1).SuperclassList.');
    for ind2 = 1:numel(curr_cls.SuperclassList)
      pos = find(curr_cls.SuperclassList(ind2) == known_metaclasses,1);
      % Did we find the superclass in the known classes list?
      if isempty(pos)
        discovered_classes(end+1,1) = curr_cls.SuperclassList(ind2); %#ok<AGROW>
  %       disp([curr_cls.SuperclassList(ind2).Name ' is not a previously known class.']);
        continue
      end      
      subcls_list{pos} = [subcls_list{pos} curr_cls];
    end    
  end  
end
end

% The full flattened list for MATLAB R2016a contains about 20k classes.
function flattened_list = flatten_package_list(top_level_list)
  flattened_list = top_level_list;
  for ind1 = 1:numel(top_level_list)
    flattened_list = [flattened_list;flatten_package_list(top_level_list(ind1).PackageList)];
  end
end