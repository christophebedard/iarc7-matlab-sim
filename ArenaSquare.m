classdef ArenaSquare < DrawableObject
    properties (SetAccess = protected, GetAccess = protected)
        id
    end
    methods
        function obj = ArenaSquare(simul,id,posx,posy,image_name,image_scale)
        obj = obj @ DrawableObject(simul,posx, posy, image_name, image_scale);
        obj.id = id;

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