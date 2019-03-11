% clean up
clear all % delete all variables
close all % close any charts
clc % take command window cursor to top

% change currrent folder (use your own one!)
cd('C:\Users\Chaire.403-001\Documents\MATLAB\example1')
 
% addpath to see functions and data folders etc (use your own one!)
addpath('C:\Users\Chaire.403-001\Documents\MATLAB\example1\data')
%addpath('C:\111_files\TEACHING\2016_MATLAB\code_repository\functions')



%% SECTION 1 - data upload

% download and save data files to an added path
[prices,~,pricesALL] = xlsread('pricesM1.xlsx','prices');
[~,~,assetsALL] = xlsread('pricesM1.xlsx','assets');



%% SECTION 2 - returns
rets=prices(2:end,:)./prices(1:(end-1),:)-1;

%% SECTION 3 - summarise data

rmean=nanmean(rets,1);
rsd=nanvar(rets,0,1).^.5;
rn=size(rets,1)-sum(isnan(rets),1);
rneg=sum(rets<0,1);
rnegpct=rneg./rn;

out1=[rmean',rsd',rn',rneg'];

xlswrite('test1.xlsx',out1)

%% SECTION 4 - charts

figure
hist(rnegpct)
title('% of negative daily returns for french stocks over last 10 years')

%%  SECTION 5 - no negative returns?
id=rnegpct<=quantile(rnegpct,.1);

idret=rets(:,id);
figure
hist(nanmean(idret,1))
title('returns for assets with low number of negative returns')

idret2=rets(:,~id);
figure
hist(nanmean(idret2,1))
title('returns for assets with normal number of negative returns')


% NOT VERY USEFUL ...  due to illiquid stocks and extreme outliers









    













