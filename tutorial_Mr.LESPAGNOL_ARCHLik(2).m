%Maximum likelihood ARCH

function[likeliArch] = ARCHLik(param, data)
%setup
%-------------------------------
T = size(data,1);
%Avoid negative values
param(find(param <= 0)) = realmin;
% Correspondance between the vector and the parameters
omega=param(1);
alpha_1=param(2);                                                   
sigmasquarred=zeros(size(data));

%algo
%-------------------------------   
%initial sigma squarred -> sigmasquarred(1)
sigmasquarred(1)=omega+alpha_1;
%loop to fulfil the sigmasquarred vector
for i=2:T
sigmasquarred(i)=omega+alpha_1*data(i-1)^2;
end

% t = an array of size t-1, from 2 to T with increment 1.
t=2:T;
%formula given during the lecture
likeliArch = sum(-0.5*log(2*pi*sigmasquarred(t))-(data(t).^2)./(2 * sigmasquarred(t)));
%Return negative log likelihood
likeliArch = -likeliArch;









