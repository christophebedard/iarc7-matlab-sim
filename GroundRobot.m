classdef GroundRobot < Robot
    properties (SetAccess = protected, GetAccess = public) %GetAccess = protected)
        id
        color_
    end
    methods
        function obj = GroundRobot(simul,id,initial_posx,initial_posy,initial_angle,initial_angle_offset,name,image_name,color_,image_scale)
            obj = obj @ Robot(simul,initial_posx,initial_posy,initial_angle,initial_angle_offset,name,strcat(image_name,color_,'.png'),image_scale);
            obj.id = id;
            obj.color_ = color_;
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