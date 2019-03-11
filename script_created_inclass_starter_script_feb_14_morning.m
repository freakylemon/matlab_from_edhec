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


%% Section 2 - calculate returns

rets=prices(2:end,:)./prices(1:(end-1),:)-1;
logrets=log(prices(2:end,:)./prices(1:(end-1),:));

%% Section 3 - summary statistics


rmean=nanmean(rets,1);
rsd=sqrt(nanvar(rets,[],1)); % could have used .^.5 instead of sqrt
rN=size(rets,1)-sum(isnan(rets),1); % could be sum(~isnan(rets),1)


out=[rmean' , rsd' ,  rN' ] % could be [rmean ; rsd ;   rN  ]'

%add negative return proportion
negret=rets<0;
negpro=sum(negret,1)./rN;


%% Section 4 - some charts

figure;
hist(negpro)
title('proportion of negative return days for french stocks, last 10 years')



%% Section 5 illiquid stocks?

illiquid=negpro<=quantile(negpro,.05);
out2=assetsALL([true,illiquid],:);
xlswrite('illiquid.xlsx',out2)  %written into current folder - go and look


%% For loops
for i=1:10
[i , i/10] % or whatever code ...
end







