function outvar = getTemplate(obj)
    % This is a structure with certain fields. In order to get the
    % fields, we get the Children.
    if isa(obj.BaseType, "coderPrimitive")
        outvar = cast(zeros(obj.Dimension), obj.DataType.BaseType.MATLABType);
    else
        for j=1:obj.NumEl
            outvar(j) = obj.DataType.BaseType.getTemplate();
        end
        if numel(obj.Dimension) == 1
            outvar = reshape(outvar, 1, []);
        else
            outvar = reshape(outvar, obj.Dimension);
        end
    end
end