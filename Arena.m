classdef Arena < DrawableObject
    properties (SetAccess = protected, GetAccess = protected)
        windowSize
        arenaDimension
        % internal
        arenaSquaresList
    end
    properties (SetAccess = protected, GetAccess = public)
        arenaSquareSize
    end
    methods
        function obj = Arena(simul,windowSize,arenaDimension,image_name)
            arenaSquareSize = floor(windowSize/arenaDimension);
            arenaWidth = (arenaSquareSize * arenaDimension)/2; % x
            arenaHeight = arenaWidth; % y
            obj = obj @ DrawableObject(simul,arenaWidth,arenaHeight,0,0,image_name,1);
            
            obj.windowSize = windowSize;
            obj.arenaDimension = arenaDimension;
        end
        function initialize(obj)
            % calculate image scale (for actual image size)
            obj.arenaSquareSize = floor(obj.windowSize/obj.arenaDimension);
            [x,~,~] = size(imread(obj.image_name));
            image_scale = obj.arenaSquareSize / x;

            % create actual image
            obj.img = imread(obj.image_name);

            % apply scaling
            obj.img = imresize(obj.img,image_scale);

            % get complete arena (through 2 dimensional cat of images)
            obj.img = catimage2D(obj.img,obj.arenaDimension);

            % update axis for image
            obj.image_axis = axes('Parent',obj.simul.fig,'Units','pixels','Position',[(floor(obj.posy)-(size(obj.img,1)/2)) (floor(obj.posx)-(size(obj.img,2)/2)) size(obj.img,1) size(obj.img,2)],'Visible','off');

            % OVERRIDE:
            %initialize @ DrawableObject(obj);
        end
        function update(obj,simul,elapsedTime)
            %nothing
            % OVERRIDE
            %update @ DrawableObject(obj,simul,elapsedTime);
        end
        function draw(obj,simul)
            imshow(obj.img,'Parent',obj.image_axis);
            % OVERRIDE:
            %draw @ DrawableObject(obj,simul);
        end

    end
end

% concatenate image in 2 dimensions
function img = catimage2D(img,dim)
    column = [];
    % create column to repeat dim times
    for i = 1:dim % y
        column = cat(1,column,img);
    end

    img = [];
    % add columns
    for i = 1:dim % y
        img = cat(2,img,column);
    end
end