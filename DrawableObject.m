classdef DrawableObject < UpdateableObject
    properties (SetAccess = protected, GetAccess = public) %GetAccess = protected)
        simul
        posx
        posy
        obj_angle % degres
        angle_initial_offset
        image_name
        image_scale
        % info
        initial_posx
        initial_posy
        initial_angle
        % internal
        image_axis
        img
        img_alpha
        deltaAngle
    end
    methods (Access = public)
        function obj = DrawableObject(simul,posx,posy,obj_angle,angle_initial_offset,image_name,image_scale)
            obj.simul = simul;
            obj.posx = posx;
            obj.posy = posy;
            obj.obj_angle = obj_angle;
            obj.angle_initial_offset = angle_initial_offset;
            obj.image_name = image_name;
            obj.image_scale = image_scale;
            % initial
            obj.initial_posx = posx;
            obj.initial_posy = posy;
            obj.initial_angle = obj_angle;
        end
        function initialize(obj)
            % read image
            [obj.img,~,obj.img_alpha] = imread(obj.image_name,'BackgroundColor', [1 1 1]);

            % apply scaling
            obj.img = imresize(obj.img,obj.image_scale);

            % apply initial angle rotation with offset
            image_angle_offset = obj.obj_angle - obj.angle_initial_offset; % calculate initial rotation to apply because of image rotation offset
            obj.rotateImgCCW(image_angle_offset);
            obj.deltaAngle = 0;
        end
        function update(obj,simul)
            % apply rotation if needed
            if (obj.deltaAngle ~= 0)
                obj.rotateImgCCW(obj.deltaAngle);
                obj.obj_angle = obj.obj_angle + obj.deltaAngle; % update angle property
                obj.deltaAngle = 0; % set deltaAngle to 0
            end

            % update axis for image
            obj.image_axis = axes('Parent',obj.simul.fig,'Units','pixels','Position',[floor(obj.posy) floor(obj.posx) size(obj.img,1) size(obj.img,2)],'Visible','off');

        end
        function draw(obj,simul)
            %implement
            
            % draw image with axis
            imshow(obj.img,'Parent',obj.image_axis);
            %ims = imshow(obj.img,'Parent',obj.image_axis);
            %set(ims,'AlphaData',obj.img_alpha);
        end
        % ----------

        % Function to rotate robot by deltaAngle. Will apply next update
        function rotateRobotCCW(obj,deltaAngle)
            % counterclockwise
            obj.deltaAngle = deltaAngle;
        end
    end
    methods (Access = protected)
        % rotate actual image
        function rotateImgCCW(obj,deltaAngle)
            obj.img = imrotate(obj.img,deltaAngle,'bilinear');
        end
    end
end