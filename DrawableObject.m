classdef DrawableObject < UpdateableObject
    properties (SetAccess = protected, GetAccess = public) %GetAccess = protected)
        simul
        posx                    % x position of img center
        posy                    % y position of img center
        obj_angle               % current object angle (degrees)
        angle_initial_offset    % offset between angle and object actual angle in default image
        image_name              % image file name and path
        image_scale             % scale to apply to image initially
        % info
        initial_posx            % initial x position
        initial_posy            % initial y position
        initial_angle           % initial angle given at construction
        % internal
        image_axis              % axis on the bottom left of the image
        img                     % image generated with image_name, image_scale and img_angle (= obj_angle - angle_initial_offset)
        img_alpha               % alpha portion of image (to get png transparency) [NOT WORKING]
        deltaAngle              % rotation angle to be applied to object/image
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
            
        end
        function update(obj,simul)
            % update image
            img_angle = obj.getActualImageAngle();
            obj.img = obj.generateImg(obj.image_scale,img_angle);

            % update axis for image
            obj.image_axis = axes('Parent',obj.simul.fig,'Units','pixels','Position',[(floor(obj.posy)-(size(obj.img,1)/2)) (floor(obj.posx)-(size(obj.img,2)/2)) size(obj.img,1) size(obj.img,2)],'Visible','off');
        end
        function draw(obj,simul)
            % draw image with axis
            %imshow(obj.img,'Parent',obj.image_axis); %doesn't work with alpha channel
            set(imshow(obj.img,'Parent',obj.image_axis),'AlphaData',obj.img_alpha);
        end
        % ----------

        % Function to rotate objet by deltaAngle. Will apply next update
        function rotateObjectCCW(obj,deltaAngle)
            % counterclockwise
            obj.obj_angle = obj.obj_angle + deltaAngle;
            obj.obj_angle = mod(obj.obj_angle, 360); % apply modulo 360 degrees to stay in [0,360]
        end
    end
    methods (Access = protected)
        % Function to generate img with current object state
        function img = generateImg(obj,img_scale,rotation)
            % read image
            [img,~,obj.img_alpha] = imread(obj.image_name,'BackgroundColor',[]);
            % apply scaling
            img = imresize(img,img_scale);
            % process alpha channel (apply resize)
            obj.img_alpha = imresize(obj.img_alpha,img_scale);
            % apply rotation
            if (rotation ~= 0)
                img = imrotate(img,rotation,'bilinear','crop');
            end
        end

        % Function to get actual image angle by applying angle_initial_offset to object angle
        function img_angle =  getActualImageAngle(obj)
            img_angle = obj.obj_angle - obj.angle_initial_offset;
        end
    end
end