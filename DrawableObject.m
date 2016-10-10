classdef DrawableObject < UpdateableObject
    properties (SetAccess = protected, GetAccess = protected)
        simul
        posx
        posy
        image_name
        image_scale

        image_axis
        img
    end
    methods
        function obj = DrawableObject(simul,posx,posy,image_name,image_scale)
            obj.simul = simul;
            obj.posx = posx;
            obj.posy = posy;
            obj.image_name = image_name;
            obj.image_scale = image_scale;
        end
        function initialize(obj)

            % read image
            obj.img = imread(obj.image_name);

            % apply scaling
            obj.img = imresize(obj.img,obj.image_scale);

            % update once
            obj.update(obj.simul);
        end
        function update(obj,simul)
            % update axis for image
            obj.image_axis = axes('Parent',obj.simul.fig,'Units','pixels','Position',[obj.posy obj.posx size(obj.img,1) size(obj.img,1)],'Visible','off');

        end
        function draw(obj,simul)
            %implement
            
            % draw image with axis
            imshow(obj.img,'Parent',obj.image_axis);

        end


        
    end
end