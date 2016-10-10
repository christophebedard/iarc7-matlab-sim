% Instance of the simulation
% takes care of the initialize(), update(), draw(), etc.
classdef Simulation < UpdateableObject
    properties %(SetAccess = protected, GetAccess = public)
        windowSize
        arenaDimension
        numberOfRobots
        sim_name = 'IARC mission 7 sim';
        windowPos_x = 100;
        windowPos_y = 200;
        arenaTile_image_name = 'images/floor_1.jpg';
        groundRobot_image_name = 'images/create2.png';
        % internal
        fig % window figure
        arn % arena with tiles
        grnd_bots % ground robots manager
    end
    methods
        function obj = Simulation(windowSize,arenaDimension,numberOfRobots)
            obj.windowSize = windowSize;
            obj.arenaDimension = arenaDimension;
            obj.numberOfRobots = numberOfRobots;
        end
        function initialize(obj)
            % create figure
            obj.fig = figure('units','pixels',...
                            'name',obj.sim_name,...
                            'menubar','none',...
                            'numbertitle','off',...
                            'position',[obj.windowPos_x obj.windowPos_y obj.windowSize obj.windowSize],...
                            'busyaction','cancel',...
                            'renderer','opengl');
            
            % create arena
            obj.arn = Arena(obj,obj.windowSize,obj.arenaDimension,obj.arenaTile_image_name);
            obj.arn.initialize();

            % create ground robots
            obj.grnd_bots = GroundRobotManager(obj,obj.numberOfRobots,0,0,obj.groundRobot_image_name);
            obj.grnd_bots.initialize();
        end
        function update(obj)
            % arena
            obj.arn.update(obj);

            % ground robots
            obj.grnd_bots.update(obj);
        end
        function draw(obj)
            % implement correct draw order

            % arena
            obj.arn.draw(obj);

            % ground robots
            obj.grnd_bots.draw(obj);

        end
    end
    
end