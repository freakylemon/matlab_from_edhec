% clean up
clear all % delete all variables
close all % close any charts
clc % take command window cursor to top

% change currrent folder (use your own one!)
%cd('C:\111_files\TEACHING\2016_MATLAB\code_repository\M1')
cd('C:\Users\Chaire.403-001\Documents\MATLAB\example1')



% addpath to see functions and data folders etc (use your own one!)
%addpath('C:\111_files\TEACHING\2016_MATLAB\code_repository\data')
%addpath('C:\111_files\TEACHING\2016_MATLAB\code_repository\functions')

addpath('C:\Users\Chaire.403-001\Documents\MATLAB\example1\data')


%% SECTION 1 - data upload

% download and save data files to an added path
[prices,~,pricesALL] = xlsread('pricesM1.xlsx','prices');
[~,~,assetsALL] = xlsread('pricesM1.xlsx','assets');

% cut and paste from notes here:

%% SECTION 2 - returns

ret=prices(2:end,:)./prices(1:(end-1),:)-1;
logret=log(prices(2:end,:)./prices(1:(end-1),:));



%% SECTION 3 Summary Stats

retmean=nanmean(ret,1)';
retstd=nanstd(ret,0,1)';

retN=[size(ret,1)-sum(isnan(ret),1)]';
negPRO=[sum(ret<0,1)./retN']';

output=[retmean retstd retN negPRO];

xlswrite ('test1.xlsx',output)

%% Useful Charts
figure;
hist(negPRO)
title('Negative Daily Returns (French Stocks)')


logref=negPRO<quantile(negPRO,.05);
illiquid=assetsALL([true;logref],:);

xlswrite ('test2.xlsx',illiquid)









