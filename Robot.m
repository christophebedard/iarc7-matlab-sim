classdef Robot < DrawableObject
    properties (SetAccess = protected, GetAccess = public) %GetAccess = protected)
        name
    end
    methods
        function obj = Robot(simul,initial_posx,initial_posy,initial_angle,name,image_name,image_scale)
            obj = obj @ DrawableObject(simul,initial_posx,initial_posy,initial_angle,image_name,image_scale);
            obj.name = name;
        end
        function initialize(obj)
            %implement

            initialize @ DrawableObject(obj);
        end
        function update(obj,simul)
            %implement

            update @ DrawableObject(obj,simul);
        end
        function draw(obj,simul)
            %implement
            
            draw @ DrawableObject(obj,simul);
        end
    end
end