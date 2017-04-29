%% IARC mission 7 MATLAB simulator
%  Using elikos_roomba as "behaviour server" through ROS
% Main file for launch with ROS
% 
% assuming: ^(y)
%           |
%           + –—>(x)
%% Initialisation: parameters setup
rosshutdown;
clc; clear all; close all;
addpath(pwd);
%% Set environment variables
setenv('ROS_MASTER_URI','http://192.168.0.105:11311');
setenv('ROS_IP','192.168.0.160');
%% Start ROS
rosinit
%% Simulation
loopRate = 10;
windowSize = 720;
arenaDimension = 5;
numberOfRobots = 1;
sim = Simulation(windowSize,arenaDimension,numberOfRobots);

sim.initialize();
startTime = now();

minLoopInterval = 1/loopRate;
lastUpdate = startTime;
while ~sim.quitSim
    %if ((now() - lastUpdate)*86400) >= minLoopInterval
        %disp('update');
        elapsedTime = (now() - lastUpdate)*86400;
        lastUpdate = now();
        sim.update(elapsedTime);
        sim.draw();
    %end
    pause(0.1); % because it makes it work for some reason
end


%% test
bumper_pub = rospublisher('/bumper', 'ca_msgs/Bumper');
msg_ = rosmessage(bumper_pub);
msg_.IsLeftPressed = 1;
msg_.IsRightPressed = 0;
bumper_msg = msg_;
send(bumper_pub, bumper_msg);
%% test2
cmdvel_sub = rossubscriber('/cmd_vel', 'geometry_msgs/Twist', @cmdVelCallback_test);