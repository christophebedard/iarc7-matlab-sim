classdef UpdateableObject < handle
    properties (SetAccess = protected, GetAccess = protected)
        
    end
    methods (Abstract)
        initialize(obj)
        % instance initialization
        update(obj,simul)
        % instance update
    end
end