classdef Arena < UpdateableObject % & Manager
    properties (SetAccess = protected, GetAccess = protected)
        simul
        windowSize
        arenaDimension
        image_name
        % internal
        arenaSquaresList
    end
    methods
        function obj = Arena(simul,windowSize,arenaDimension,image_name)
            obj.simul = simul;
            obj.windowSize = windowSize;
            obj.arenaDimension = arenaDimension;
            obj.image_name = image_name;
        end
        function initialize(obj)
            % assuming: ^ (y)
            %           |      [square]
            %           0 –—> (x)

            % calculate image scale
            squareSize = floor(obj.windowSize/obj.arenaDimension);
            [x,~,~] = size(imread(obj.image_name));
            image_scale = squareSize / x;

            % create list of ArenaSquare
            for i = 1:obj.arenaDimension % y
                posy = (i-1)*squareSize;
                for j = 1:obj.arenaDimension % x
                    disp(strcat('i: ',i));
                    disp(strcat('j: ',j));
                    posx = (j-1)*squareSize;
                    id = (i+j)-1;
                    obj.arenaSquaresList{i,j} = ArenaSquare(obj.simul,id,posx,posy,obj.image_name,image_scale);
                end
            end

            % initialize list of ArenaSquare
            for i = 1:size(obj.arenaSquaresList,1)
                for j = 1:size(obj.arenaSquaresList,2)
                    sq = obj.arenaSquaresList{i,j};
                    sq.initialize();
                end
            end
        end
        function update(obj)
            %nothing
            % update all the arena squares
            for i = 1:size(obj.arenaSquaresList,1)
                for j = 1:size(obj.arenaSquaresList,2)
                    sq = obj.arenaSquaresList{i,j};
                    sq.update(obj.simul);
                end
            end

        end
        function draw(obj)
            % draw all the arena squares
            for i = 1:size(obj.arenaSquaresList,1)
                for j = 1:size(obj.arenaSquaresList,2)
                    sq = obj.arenaSquaresList{i,j};
                    sq.draw(obj.simul);
                end
            end
        end

    end
end