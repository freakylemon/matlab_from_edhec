cd('C:\Users\freak\Documents\WEI\Documents\learn\econometrics\matlab\assignment')

addpath('C:\Users\freak\Documents\WEI\Documents\learn\econometrics\matlab\assignment')

%% this is to calculate logreturns of data


%%start from here, I first import data from excel file
Returns_vodafone = zeros(length(AdjClose)-1,1);

Returns_vodafone(:,1)= diff(log(AdjClose(:,1))); 

%%here i am going to plot
figure
plot(Date(2:end,1),Returns_vodafone);
datetick %%change date number in date stream, you can see it in mathworks

%%we are going to compute the mean...
fprintf('The mean is: %d\n',mean(Returns_vodafone));
fprintf('The standard deviation is: %d\n',std(Returns_vodafone));
fprintf('The skewness is: %d\n',skewness(Returns_vodafone));
fprintf('The kurtosis is: %d\n',kurtosis(Returns_vodafone));

Mdla= garch('ARCHLags',1);%%what link between the gatch model and the arch model
%%then you build a function in the workspace
Mdla_para=estimate(Mdla,Returns_vodafone);

%%question 2b
Mdlb= garch('ARCHLags',2);
Mdlb_para=estimate(Mdlb,Returns_vodafone);

%%question 2c
Mdlc= garch(1,1);
Mdlc_para=estimate(Mdlc,Returns_vodafone);

%%Question 3.a
[Va Ya]=simulate(Mdla_para,4319);

%%Question 3.b
[Vb Yb]=simulate(Mdlb_para,4319);

%%Question 3.c
[Vc Yc]=simulate(Mdlc_para,4319);

figure
subplot(4,1,1)
plot(Date(2:end,1),Returns_vodafone)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Vodafone')

subplot(4,1,2)
plot(Date(2:end,1),Ya)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Sim,Arch(1)')

subplot(4,1,3)
plot(Date(2:end,1),Yb)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Sim,Arch(2)')

subplot(4,1,4)
plot(Date(2:end,1),Yc)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Sim,garch(1,1)')


 % Initial guess
a0=7.9778E-7;
a1=0.0896;
%b1=0.9098

% fminsearch
fminsearch('ARCHLik', [a0 a1], [], Returns_vodafone)

%arch(1)
a8=7.9778E-7;
a9=0.0896;
%b1=0.9098

% fminsearch
fminsearch('ARCHLik', [a8 a9], [], Ya)
[0.000327164685719376]
[0.348418043218367]
ARCHLik([0.000327164685719376,0.348418043218367], Ya)
%[-8339.45323682317]

% arch(2)
a2=7.9778E-7;
a3=0.0896;
a4=0.0896;

% fminsearch
fminsearch('ARCHLiktwo', [a2 a3 a4], [], Yb)

[7.97780000000000e-07,0.0940800000000000,0.0896000000000000]
ARCHLiktwo([7.97780000000000e-07,0.0940800000000000,0.0896000000000000],Yb)

% garch(1,1)
a5=7.9778E-7;
a6=0.0896;
a7=0.0896;


% fminsearch
fminsearch('garchlik', [a5 a6 a7], [], Yc)

[1.35807231049028e-05,0.0867161887807755,0.884104748724350]
garchlik([1.35807231049028e-05,0.0867161887807755,0.884104748724350],Yc)