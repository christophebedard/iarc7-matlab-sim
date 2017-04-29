classdef GroundRobotManager < UpdateableObject % & Manager
    properties (SetAccess = protected, GetAccess = public) %GetAccess = protected)
        simul
        numberOfRobots
        center_x
        center_y
        image_name
        % internal
        GroundRobotList % ground robots list
        one_meter_in_pixels
        create2_image_scale
        create2_diameter = 0.3485; % meters
        robotCircle_diameter = 2.0; % meters
        robotCircle_diameter_in_pixels
        create2_diameter_in_pixels
        initial_angle_offset = 90; % degrees, counterclockwise
    end
    methods
        function obj = GroundRobotManager(simul,numberOfRobots,center_x,center_y,image_name)
            obj.simul = simul;
            obj.numberOfRobots = numberOfRobots;
            obj.center_x = obj.simul.arn.arenaSquareSize * (obj.simul.arenaDimension / 2); %center_x;
            obj.center_y = obj.simul.arn.arenaSquareSize * (obj.simul.arenaDimension / 2); %center_y;
            obj.image_name = image_name;
        end
        function initialize(obj)
            % scaling stuff
            obj.one_meter_in_pixels = obj.simul.arn.arenaSquareSize;
            obj.robotCircle_diameter_in_pixels = obj.robotCircle_diameter * obj.one_meter_in_pixels;
            obj.create2_diameter_in_pixels = obj.one_meter_in_pixels * obj.create2_diameter;
            [x,~,~] = size(imread(strcat(obj.image_name,'red.png')));
            obj.create2_image_scale = obj.create2_diameter_in_pixels / x; % scale = (dimension in pixels we want) / (actual image size in pixels)

            % divide 360 degrees by numberOfRobots
            deltaAngle = 360/obj.numberOfRobots;

            obj.GroundRobotList = cell(1,obj.numberOfRobots);
            % for each angle value, generate initial positions with angle (clockwise) and create GroundRobots
            for i = 1:obj.numberOfRobots
                % assign color alternatively
                switch mod(i,2)
                    case 0
                        col = 'red';
                    case 1
                        col = 'green';
                    otherwise
                        col = 'red';
                end
                initial_angle = (i-1)*deltaAngle;
                initial_posx = obj.center_x + ((obj.robotCircle_diameter_in_pixels / 2) * sin(deg2rad(initial_angle)));
                initial_posy = obj.center_y + ((obj.robotCircle_diameter_in_pixels / 2) * cos(deg2rad(initial_angle)));
                obj.GroundRobotList{i} = GroundRobot(obj.simul,i,initial_posx,initial_posy,initial_angle,obj.initial_angle_offset,'beep boop',obj.image_name,col,obj.create2_image_scale);
                %disp(obj.GroundRobotList{i}); % debug
            end

            % initialize ground robots
            for i = 1:obj.numberOfRobots
                obj.GroundRobotList{i}.initialize();
            end
        end
        function update(obj,simul,elapsedTime)
            for i = 1:obj.numberOfRobots
                grndbot = obj.GroundRobotList{i};
                %grndbot.rotateObjectCCW(36); % debug
                grndbot.update(obj.simul,elapsedTime);
            end

            %update @ Robot(obj);
        end
        function draw(obj,simul)
            for i = 1:obj.numberOfRobots
                grndbot = obj.GroundRobotList{i};
                grndbot.draw(obj.simul);
            end

            %draw @ Robot(obj);
        end

    end
end