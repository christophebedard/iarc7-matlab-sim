classdef Robot < DrawableObject
    properties
        initial_posx
        initial_posy
        name
    end
    methods
        function obj = Robot(simul,initial_posx,initial_posy,name,image_name,image_scale)
            obj = obj @ DrawableObject(simul,initial_posx,initial_posy,image_name,image_scale);
            obj.initial_posx = initial_posx;
            obj.initial_posy = initial_posy;
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