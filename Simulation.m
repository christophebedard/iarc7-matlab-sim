% Instance of the simulation
% takes care of the initialize(), update(), draw(), etc.
classdef Simulation < UpdateableObject
    properties %(SetAccess = protected, GetAccess = public)
        windowSize
        arenaDimension
        sim_name = 'IARC mission 7 sim';
        windowPos_x = 100;
        windowPos_y = 100;
        image_name = 'images/floor_1.jpg';
        % -------
        arn
        fig
    end
    methods
        function obj = Simulation(windowSize,arenaDimension)
            obj.windowSize = windowSize;
            obj.arenaDimension = arenaDimension;
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
            obj.arn = Arena(obj,obj.windowSize,obj.arenaDimension,obj.image_name);
            obj.arn.initialize();
            obj.arn.update();
            obj.arn.draw();
        end
        function update(obj)
            % implement

        end
        function draw(obj)
            % implement correct draw order

        end
    end
    
end