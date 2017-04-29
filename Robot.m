classdef Robot < DrawableObject
    properties (SetAccess = protected, GetAccess = public) %GetAccess = protected)
        name
        cmdvel_sub
        LinearX
        AngularZ
        bumper_pub
        bumper_msg
        newCmdVelMessage
    end
    methods
        function obj = Robot(simul,initial_posx,initial_posy,initial_angle,initial_angle_offset,name,image_name,image_scale)
            obj = obj @ DrawableObject(simul,initial_posx,initial_posy,initial_angle,initial_angle_offset,image_name,image_scale);
            obj.name = name;
        end
        function initialize(obj)
            %implement
            
            % setup subscriber and publisher
            obj.cmdvel_sub = rossubscriber('/cmd_vel', 'geometry_msgs/Twist', @obj.cmdVelCallback);
            obj.bumper_pub = rospublisher('/bumper', 'ca_msgs/Bumper');
            pause(2); % Wait to ensure publisher is registered
            
            newCmdVelMessage = 0;
            
            initialize @ DrawableObject(obj);
        end
        function update(obj,simul,elapsedTime)
            %implement
            
            moveFromCmdVel(obj,elapsedTime);
            
            updateRobotBumper(obj);
            
            update @ DrawableObject(obj,simul,elapsedTime);
        end
        function draw(obj,simul)
            %implement
            
            draw @ DrawableObject(obj,simul);
        end
        
        function updateRobotBumper(obj)
            % check if robot bumps into anything
            
            msg_ = rosmessage(obj.bumper_pub);
            msg_.IsLeftPressed = 1;
            msg_.IsRightPressed = 1;
            
            obj.bumper_msg = msg_;
            
            %publishBumperMsg(obj);
        end
        
        % Move robot given cmdvel and elapsed time
        function moveFromCmdVel(obj,elapsedTime)
            % only move robot if there was a new cmdvel msg
            if obj.newCmdVelMessage
                xvel = obj.LinearX;
                zvel = obj.AngularZ;

                deltaAngle = rad2deg(zvel*elapsedTime);
                deltaLin = xvel*elapsedTime;
                
                moveFromDeltaAngleAndDeltaLin(obj,deltaAngle,deltaLin);
                
                % clear flag
                obj.newCmdVelMessage = 0;
            end
        end
        
        % cmd_vel subscriber callback method
        function cmdVelCallback(obj,~,msg)
            obj.LinearX = msg.Linear.X;
            obj.AngularZ = msg.Angular.Z;
            obj.newCmdVelMessage = 1;
        end
        
        % Bumper message publisher
        function publishBumperMsg(obj)
            send(obj.bumper_pub, obj.bumper_msg);
        end
    end
end