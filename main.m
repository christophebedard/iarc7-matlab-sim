%% IARC mission 7 MATLAB simulator
% Main file for launch
% 
% assuming: ^(y)
%           |
%           + –—>(x)
%% Initialisation: parameters setup
clc; clear all; close all;

% simulation parameters
windowSize = 720;
arenaDimension = 5;
numberOfRobots = 12;
sim = Simulation(windowSize,arenaDimension,numberOfRobots);

sim.initialize();
startTime = now();

while ~sim.quitSim
    elapsedTime = now() - startTime;
    sim.update(elapsedTime);
    sim.draw();
    
    pause(0.1); % because it makes it work for some reason
end

%% test

