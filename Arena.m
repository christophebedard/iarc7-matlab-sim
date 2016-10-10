classdef Arena < DrawableObject
    properties (SetAccess = protected, GetAccess = protected)
        windowSize
        arenaDimension
        % internal
        arenaSquaresList
    end
    methods
        function obj = Arena(simul,windowSize,arenaDimension,image_name)
            obj = obj @ DrawableObject(simul,0,0,image_name,1);
            
            obj.windowSize = windowSize;
            obj.arenaDimension = arenaDimension;
        end
        function initialize(obj)
            % assuming: ^ (y)
            %           |      [square]
            %           0 –—> (x)

            % calculate image scale (for actual image size)
            squareSize = floor(obj.windowSize/obj.arenaDimension);
            [x,~,~] = size(imread(obj.image_name));
            image_scale = squareSize / x;

            % create actual image
            obj.img = imread(obj.image_name);

            % apply scaling
            obj.img = imresize(obj.img,obj.image_scale);

            % apply scaling
            obj.img = imresize(obj.img,image_scale);

            column = [];
            % create column
            for i = 1:obj.arenaDimension % y
                column = cat(1,column,obj.img);
            end

            new_img = [];
            % add columns
            for i = 1:obj.arenaDimension % y
                new_img = cat(2,new_img,column);
            end

            % give to obj.img
            obj.img = new_img;

            % update once
            obj.update(obj.simul);

            % draw once
            obj.draw(obj.simul);

            % OVERRIDE the 
            %initialize @ DrawableObject(obj);
        end
        function update(obj,simul)
            %nothing
            update @ DrawableObject(obj,simul);
        end
        function draw(obj,simul)

            draw @ DrawableObject(obj,simul);
        end

    end
end