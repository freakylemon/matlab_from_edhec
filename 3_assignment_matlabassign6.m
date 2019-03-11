%% from 2JAN 2014 TO 3 MARCH 2017: ROW 3523-4321/897
Returns_vodafone2 = zeros(length(AdjClose)-1,1);

Returns_vodafone2(:,1)= diff(log(AdjClose(:,1))); 

Mdla2= garch('ARCHLags',1);

Mdla2_para=estimate(Mdla2,Returns_vodafone2);


Mdlb2= garch('ARCHLags',2);
Mdlb2_para=estimate(Mdlb2,Returns_vodafone2);


Mdlc2= garch(1,1);
Mdlc2_para=estimate(Mdlc2,Returns_vodafone2);


[Va2 Ya]=simulate(Mdla2_para,797);

figure
subplot(4,1,1)
plot(Returns_vodafone2)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Vodafone2')
subplot(4,1,2)
plot(Ya)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Sim,Arch(1)')


[Vb2 Yb]=simulate(Mdlb2_para,797);

figure
subplot(4,1,1)
plot(Returns_vodafone2)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Vodafone2')
subplot(4,1,2)
plot(Yb)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Sim,Arch(2)')


[Vc2 Yc]=simulate(Mdlc2_para,797);

figure
subplot(4,1,1)
plot(Returns_vodafone2)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Vodafone2')
subplot(4,1,2)
plot(Yc)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Sim,Garch(1,1)')

% arch(1)

a8=7.9778E-7;
a9=0.0896;
%b1=0.9098

% fminsearch
fminsearch('VaRone', [a8 a9], [], Ya)
%% at 0414 found that VaR could be calculated after we get omega and alpha, (beta). 
%% I have problem on plotting, and how to denote that data is smaller than VaR
%% which is ValueatRisk =-(omega+alpha_1*Returns_vodafone2(i-1)^2)^0.5*(-1.645);

