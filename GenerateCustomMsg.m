%% Generate custom messages for MATLAB
% Source: https://www.mathworks.com/help/robotics/ug/create-custom-messages-from-ros-package.html
clear all; clc; close all;
% name of ROS package which contains messages to generate (highest/meta package)
pckg_name = 'create_autonomy';
%% Execute this
% change current directory to the directory containing this .m file
% make sure the ROS package (pckg_name) is cloned into ./pckg_name
examplePackages = fullfile(pwd,pckg_name);

% path to folder in which the MATLAB messages will be generated
% make sure matlab_msg folder exists
userFolder = fullfile(pwd,'matlab_msg');

% copy the package(s) into MATLAB message generation directoy
copyfile(examplePackages, userFolder);

% generate MATLAB message
folderpath = userFolder;
rosgenmsg(folderpath)
%% Follow steps 1 to 3 given by the output of rosgenmsg()
%    1. Add given file locations to javaclasspath.txt
%    2. Execute
%          addpath(fullfile(userFolder,'matlab_gen','msggen'))
%          savepath
%    3. Restart MATLAB and verify that the custom messages are in the
%       output of
%          rosmsg list