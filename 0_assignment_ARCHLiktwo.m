function[likeliArch] = ARCHLik(param,Returns_vodafone)
%setup
%-------------------------------
T = size(Returns_vodafone,1);
%Avoid negative values
param(find(param <= 0)) = realmin;
% Correspondance between the vector and the parameters
omega=param(1);
alpha_1=param(2);
alpha_2=param(3);
sigmasquarred=zeros(size(Returns_vodafone));

%algo
%-------------------------------   
%initial sigma squarred -> sigmasquarred(2)
sigmasquarred(2)=omega+alpha_1+alpha_2;
%loop to fulfil the sigmasquarred vector
for i=3:T
sigmasquarred(i)=omega+alpha_1*Returns_vodafone(i-1)^2+alpha_2*Returns_vodafone(i-2);
end

% t = an array of size t-1, from 2 to T with increment 1.
t=3:T;
%formula given during the lecture
likeliArch = sum(-0.5*log(2*pi*sigmasquarred(t))-(Returns_vodafone(t).^2)./(2 * sigmasquarred(t)));
%Return negative log likelihood
likeliArch = -likeliArch;