%% IARC mission 7 MATLAB simulator
% Elikos
%
% Main file for launch

% assuming: ^(y)
%           |
%           + –—>(x)
%% Initialisation: parameters setup
clc; clear all; close all;

% simulation parameters
windowSize = 720;
arenaDimension = 5;
numberOfRobots = 10;
sim = Simulation(windowSize,arenaDimension,numberOfRobots);

sim.initialize();

for i=1:1
    sim.update();
    sim.draw();
    pause(0.1);
end

%% test
clc; clear all; close all;

img = imread('images/create2.png','BackgroundColor', [1 1 1]);

fig = figure('units','pixels',...
                'name','some test',...
                'menubar','none',...
                'numbertitle','off',...
                'position',[0 0 1000 1000],...
                'busyaction','cancel',...
                'renderer','opengl');

ax = axes('Parent',fig,'Units','pixels','Position',[0 0 size(img,1) size(img,1)],'Visible','off');

imshow(img,'Parent',ax);
