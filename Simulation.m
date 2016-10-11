% Instance of the simulation
% takes care of the initialize(), update(), draw(), etc.
classdef Simulation < UpdateableObject
    properties %(SetAccess = protected, GetAccess = public)
        windowSize                                          % width or height of square window
        arenaDimension                                      % arena dimensions in number of squares
        numberOfGroundRobots                                % number of ground robots

        sim_name = 'IARC mission 7 sim';                    % simulation window title text
        windowPos_x = 500;                                  % simulation window x position
        windowPos_y = 200;                                  % simulation window y position
        arenaTile_image_name = 'images/floor_1.jpg';        % floor tile image path and name
        groundRobot_image_name = 'images/create2_top_';     % ground robot image path with partial name (without color)
        quitKey = 27;                                       % keyboard key to quit: escape
        frameRateTextPos_x = 0;                             % x position of frame rate text display
        frameRateTextPos_y = 0;                             % y position of frame rate text display

        quitSim                                             % boolean to quit simulation and close window
        fig                                                 % window figure
        arn                                                 % arena with tiles
        grnd_bots                                           % ground robots manager
        obstcl_bots                                         % obstacle robots manager %IMPLEMENT
        frameRate                                           % frame rate (1 / elapsedTime between frame)
        frameRate_axes                                      % frame rate axes for display
    end
    methods
        function obj = Simulation(windowSize,arenaDimension,numberOfGroundRobots)
            obj.windowSize = windowSize;
            obj.arenaDimension = arenaDimension;
            obj.numberOfGroundRobots = numberOfGroundRobots;
        end
        function initialize(obj)
            obj.quitSim = false;
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
            obj.grnd_bots = GroundRobotManager(obj,obj.numberOfGroundRobots,0,0,obj.groundRobot_image_name);
            obj.grnd_bots.initialize();

            % create obstacle robots
            %IMPLEMENT

            % create quad
            %IMPLEMENT
        end
        function update(obj,elapsedTime)
            % check keyboard for 'escape' key
            %key = double(get(obj.fig,'CurrentCharacter'));
            %obj.quitSim = true;% (key == obj.quitKey);

            % arena
            obj.arn.update(obj,elapsedTime);

            % ground robots
            obj.grnd_bots.update(obj,elapsedTime);

            % obstacle robots
            %IMPLEMENT

            % quad
            %IMPLEMENT

            % frame rate
            %obj.frameRate = 1/elapsedTime;
        end
        function draw(obj)
            % correct draw order

            % arena
            obj.arn.draw(obj);

            % ground robots
            obj.grnd_bots.draw(obj);

            % obstacle robots
            %IMPLEMENT

            % quad
            %IMPLEMENT

            % frame rate
            %text(obj.frameRateTextPos_x,obj.frameRateTextPos_y,num2str(obj.frameRate),'FontSize',40,'Color','red','HorizontalAlignment','left');
            %set(obj.fig,'name',strcat(obj.sim_name,' [',num2str(obj.frameRate),']'));
        end
    end
    
end