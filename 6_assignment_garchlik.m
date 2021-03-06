function[likeliGarch] = GARCHLik(param,Returns_vodafone)
%setup
%-------------------------------
T = size(Returns_vodafone,1);
%Avoid negative values
param(find(param <= 0)) = realmin;
% Correspondance between the vector and the parameters
omega=param(1);
alpha_1=param(2);
beta_1=param(3);
sigmasquarred=zeros(size(Returns_vodafone));

%algo
%-------------------------------   
%initial sigma squarred -> sigmasquarred(2)
sigmasquarred(1)=omega/(alpha_1+beta_1);
%loop to fulfil the sigmasquarred vector
for i=2:T
sigmasquarred(i)=omega+alpha_1*Returns_vodafone(i-1)^2+beta_1*sigmasquarred(i-1);
end

% t = an array of size t-1, from 2 to T with increment 1.
t=3:T;
%formula given during the lecture
likeliGarch = sum(-0.5*log(2*pi*sigmasquarred(t))-(Returns_vodafone(t).^2)./(2 * sigmasquarred(t)));
%Return negative log likelihood
likeliGarch = -likeliGarch;