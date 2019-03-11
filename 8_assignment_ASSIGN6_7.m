%% based on 12345
AdjClose2=xlsread("Vodafone2000-2017","B3524:B4321");

Returns_vodafone2 = zeros(length(AdjClose2)-1,1);

Returns_vodafone2(:,1)= diff(log(AdjClose2(:,1))); 

Param_arch1=[3.7e-4,0.3546];
a0=7.9778E-7;
a1=0.0896;
Param_arch1=fminsearch('ARCHLik', [a0 a1], [], Ya )

Param_arch2=[3.7e-4,0.3546,0.0896];
a0=7.9778E-7;
a1=0.0896;
a2=0.0896;
Param_arch2=fminsearch('ARCHLiktwo', [a0 a1 a2], [], Yb)

Param_garch=[3.7e-4,0.3546,0.0896];
a0=7.9778E-7;
a1=0.0896;
a2=0.0896;
Param_garch=fminsearch('garchlik', [a0 a1 a2], [], Yc )

%% calculate arch(1)
Sigmas_arch1(1)=Param_arch1(1)+Param_arch1(2)*Returns_vodafone2(1)^2;
VaR_arch1(1)= -norminv(0.05,sqrt(Sigmas_arch1(1)));

for i=2:length(Returns_vodafone2)
Sigmas_arch1(i)= Param_arch1(1)+Param_arch1(2)*Returns_vodafone2(i-1)^2;
VaR_arch1(i)= -norminv(0.05,sqrt(Sigmas_arch1(i)));
end
%% calculate arch(2)
Sigmas_ARCH2(1)=Param_arch2(1)+Param_arch2(2)*Returns_vodafone2(1)^2+Param_arch2(3)*Returns_vodafone2(1)^2;
VaR_ARCH2(1)=-norminv(0.05,0,sqrt(Sigmas_ARCH2(1)));

for i=3:length(Returns_vodafone2)
Sigmas_ARCH2(i)=Param_arch2(1)+Param_arch2(2)*Returns_vodafone2(i-1).^2+Param_arch2(3)*Returns_vodafone2(i-2).^2;
VaR_ARCH2(i)=-norminv(0.05,0,sqrt(Sigmas_ARCH2(i)));
end

%% calculate garch(1,1)---------------
sigmas_GARCH(1)=Param_garch(1)./(1-Param_garch(2)-Param_garch(3));
for i=2:length(Returns_vodafone2)
sigmas_GARCH(i)=Param_garch(1)+Param_garch(2).*Returns_vodafone2(i-1).^2+Param_garch(3)*sigmas_GARCH(i-1);
end

sigmas_GARCH(1)=Param_garch(1)+Param_garch(2).*Returns_vodafone2(1)^2+Param_garch(3)*sigmas_GARCH(end);
VaR_GARCH(1)=-norminv(0.05,0,sqrt(sigmas_GARCH(1)));
for i=2:length(Returns_vodafone2)
sigmas_GARCH(i)=Param_garch(1)+Param_garch(2).*Returns_vodafone2(i-1).^2+Param_garch(3)*sigmas_GARCH(i-1);
VaR_GARCH(i)=-norminv(0.05,0,sqrt(sigmas_GARCH(i)));
end

% Calculate Percentage----------------------------------------
per_ARCH1=sum(Returns_vodafone2-VaR_arch1'>=0)./length(Returns_vodafone2);
per_ARCH2=sum(Returns_vodafone2-VaR_ARCH2'>=0)./length(Returns_vodafone2);
per_GARCH11=sum(Returns_vodafone2-VaR_GARCH'>=0)./length(Returns_vodafone2);

% Output------------------------------------------------------
fprintf('\t\t\t\tARCH(1)\t\tARCH(2)\t\tGARCH(1,1)\n');
fprintf('proportion of data < -VaR\t%.3f%%\t\t%.3f%%\t\t%.3f%%\n',per_ARCH1*100,per_ARCH2*100,per_GARCH11*100);


%% Q7


for i=1:length((Returns_vodafone2))
 VaR_his(i)=-quantile(Returns_vodafone(3463+i:3522+i),0.05);
end
per_his=sum(Returns_vodafone2-VaR_his'>=0)./length(Returns_vodafone2);

fprintf('\t\t\t\tGARCH(1,1)\thistorical simulation\n');
fprintf('proportion of data < -VaR\t%.3f%%\t\t%.3f%%\n',per_GARCH11*100,per_his*100);

