% clean up
clear all % delete all variables
close all % close any charts
clc % take command window cursor to top

% change currrent folder (use your own one!)
cd('C:\111_files\TEACHING\2016_MATLAB\code_repository\M1')

% addpath to see functions and data folders etc (use your own one!)
addpath('C:\111_files\TEACHING\2016_MATLAB\code_repository\data')
addpath('C:\111_files\TEACHING\2016_MATLAB\code_repository\functions')



%% SECTION 1 - data upload

% download and save data files to an added path
[prices,~,pricesALL] = xlsread('pricesM1.xlsx','prices');
[~,~,assetsALL] = xlsread('pricesM1.xlsx','assets');

% cut and paste from notes here:

