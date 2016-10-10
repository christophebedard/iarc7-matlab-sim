%% IARC mission 7 MATLAB simulator
% Elikos
%
% Main file for launch

%% Initialisation: parameters setup
clc; clear all; close all;

sim = Simulation(1000,10);

sim.initialize();

% sim.update();
% 
% sim.draw();