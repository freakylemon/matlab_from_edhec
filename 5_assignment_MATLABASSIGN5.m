%%FROM JAN3 2000 TO DEC 31 2013 IN LINE 3523
AdjClose1= xlsread('Vodafone2000-2017','B1:B3523');
Returns_vodafone1 = zeros(length(AdjClose1)-1,1);

Returns_vodafone1(:,1)= diff(log(AdjClose1(:,1))); 

Mdla1= garch('ARCHLags',1);

Mdla1_para=estimate(Mdla1,Returns_vodafone1);


Mdlb1= garch('ARCHLags',2);
Mdlb1_para=estimate(Mdlb1,Returns_vodafone1);


Mdlc1= garch(1,1);
Mdlc1_para=estimate(Mdlc1,Returns_vodafone1);


[Va1 Ya]=simulate(Mdla1_para,3521);

figure
subplot(4,1,1)
plot(Returns_vodafone1)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Vodafone1')
subplot(4,1,2)
plot(Ya)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Sim,Arch(1)')


[Vb1 Yb]=simulate(Mdlb1_para,3521);

figure
subplot(4,1,1)
plot(Returns_vodafone1)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Vodafone1')
subplot(4,1,2)
plot(Yb)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Sim,Arch(2)')


[Vc1 Yc]=simulate(Mdlc1_para,3521);

figure
subplot(4,1,1)
plot(Returns_vodafone1)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Vodafone1')
subplot(4,1,2)
plot(Yc)
set(gca,'Ylim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0.15])
ylabel('Sim,Garch(1,1)')


 % original log return
a0=7.9778E-7;
a1=0.0896;
%b1=0.9098

% fminsearch
fminsearch('ARCHLik', [a0 a1], [], Returns_vodafone1 )

[0.000374724625722591]
[0.353147023739704]
ARCHLik([0.000374724625722591,0.353147023739704],Returns_vodafone1)

% arch(1)
a0=7.9778E-7;
a1=0.0896;
%b1=0.9098

% fminsearch
fminsearch('ARCHLik', [a0 a1], [], Ya )

[0.000389908183731714]
[0.364344955920160]
ARCHLik([0.000389908183731714,0.364344955920160],Ya)

% arch(2)
a0=7.9778E-7;
a1=0.0896;
a2=0.0896;
%b1=0.9098

% fminsearch
fminsearch('ARCHLiktwo', [a0 a1 a2], [], Yb )

[-3.88326801851853e-06]
[0.0703249382716064]
[0.0736849382716064]
ARCHLiktwo([-3.88326801851853e-06,0.0703249382716064,0.0736849382716064],Yb)

% garch(1,1)
a0=7.9778E-7;
a1=0.0896;
a2=0.0896;

% fminsearch
fminsearch('garchlik', [a0 a1 a2], [], Yc )

[-8.02863613851231e-06]
[0.0801620000965789]
[0.925820992342568]
garchlik([-8.02863613851231e-06,0.0801620000965789,0.925820992342568],Yc)
