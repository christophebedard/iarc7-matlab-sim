classdef GroundRobotManager < UpdateableObject % & Manager
    properties (SetAccess = protected, GetAccess = protected)
        id
    end
    methods
        function obj = GroundRobotManager(simul,number,centerx,centery,image_name,image_scale)
            %obj = obj @ Manager();
            obj.id = id;
        end
        function initialize(obj)
            %implement

            %initialize @ Robot(obj);
        end
        function update(obj,simul)
            %implement

            %update @ Robot(obj);
        end
        function draw(obj,simul)
            %implement

            %draw @ Robot(obj);
        end

    end
end