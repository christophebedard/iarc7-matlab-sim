classdef Quad < Robot
    properties (SetAccess = protected, GetAccess = protected)
        
    end
    methods
        function obj = Quad(simul,initial_posx,initial_posy,name,image_name,image_scale)
            obj = obj @ Robot(simul,initial_posx,initial_posy,name,image_name,image_scale);
        end
        function initialize(obj)
            %implement

            initialize @ Robot(obj);
        end
        function update(obj,simul)
            %implement

            update @ Robot(obj,simul);
        end
        function draw(obj,simul)
            %implement

            draw @ Robot(obj,simul);
        end
    end
end