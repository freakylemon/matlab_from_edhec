%%% Tutoriel 2:

%% 1 - Minimize a simple non-linear function with fmin unconstrainte: fminunc
% Go to help so as to understand how the fct works: help fminunc
%fun = @(x) x^2;
% What does @(x) mean? -> fun will be assigned the handle of a function
% (x^2), which takes one parameter (x) that is an array
% What does .^ mean ? -> array power -> array vs. matrix, matlab initialy
% works with matrix.
fun = @(x) x^2
%plot the function over interval -10,10
fplot(fun, [-10 10])
%Compute the min
fminbnd(fun, -10, 10) % find the value that minimise the functin fun in the interval [-10,10]

%% 2 - The maximum likelihood estimates of omega and alpha(1) of ARCH1
%Import llog returns by yoursel and name it "Return"


%Minimising the negative loglikelihood is equivalent to maximing the
 %loglikelihood: use "fmin"-type fct
 
 % Initial guess
a0=7.9778E-7;
a1=0.0896;
%b1=0.9098

% fminsearch
fminsearch('ARCHLik', [a0 a1], [], Return )


%% 3 - Plot generated arch 1

%Estimated parameters of ARCH(1) by function "fminsearch('ARCHLik', [a0
%a1], [], Return )"

omega = 0.000328;
alpha = 0.35620;

%Initialise vector
RetArch = zeros(length(Return) - 1,1);

%1st value
RetArch(1) = sqrt(omega + alpha) * normrnd(0,1);
% normrnd(0,1) = generate a random value based on a normal distribution of
% mean 0 and variance 1.
for i = 2:(length(Return) -1)
RetArch(i) = sqrt(omega + alpha * (RetArch(i-1))^2) * normrnd(0,1);
end

figure
subplot(4,1,1)
plot(Return)
set(gca,'YLim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0 0.15])
ylabel('Vodafone')
subplot(4,1,2)
plot(RetArch)
set(gca,'YLim',[-0.15 0.15])
set(gca,'YTick',[-0.15 0 0.15])
ylabel('Gen.Arch(1)')