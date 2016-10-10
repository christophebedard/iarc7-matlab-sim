classdef DrawableObject < UpdateableObject
    properties (SetAccess = protected, GetAccess = public) %GetAccess = protected)
        simul
        posx
        posy
        angle_ % degres
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
    end
    methods
        function obj = DrawableObject(simul,posx,posy,angle_,image_name,image_scale)
            obj.simul = simul;
            obj.posx = posx;
            obj.posy = posy;
            obj.angle_ = angle_;
            obj.image_name = image_name;
            obj.image_scale = image_scale;
            % initial
            obj.initial_posx = posx;
            obj.initial_posy = posy;
            obj.initial_angle = angle_;
        end
        function initialize(obj)

            % read image
            [obj.img,map,obj.img_alpha] = imread(obj.image_name,'BackgroundColor', [1 1 1]);

            % apply scaling
            obj.img = imresize(obj.img,obj.image_scale);

            % apply angle rotation
            obj.img = imrotate(obj.img,obj.angle_,'bilinear');

            % update once
            obj.update(obj.simul);
        end
        function update(obj,simul)
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


        
    end
end