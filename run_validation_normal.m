clear; clc;

addpath(fullfile(fileparts(mfilename('fullpath')),'estimators'));

rng(20260919);

N = 10000;         % sample size in each Monte Carlo replication
M = 1000;          % number of Monte Carlo replications
alpha = 0.05;      % trimming/winsorization
qmethod = 'ecdf';  % 'ecdf' method for calculating quantiles

names = {
    'Classical';
    'Trimmed';
    'Winsorized';
    'Moors';
    'Hogg';
    'Crow-Siddiqui';
    'L-kurtosis';
    'TL-kurtosis';
    'LQ-median';
    'LQ-trimean';
    'LQ-Gastwirth'};

% Theoretical values for N(0,1).
% Trimmed and winsorized values depend on alpha, so we have NaN
reference = [3; NaN; NaN; 1.233; 2.585; 2.906; 0.123; 0.062; 0.116; 0.118; 0.117];

K = zeros(M,numel(names));

fprintf('Running %d Monte Carlo replications, N = %d\n',M,N);
for m = 1:M
    x = randn(N,1);

    K(m,1)  = rk_classical(x);
    K(m,2)  = rk_trimmed(x,alpha);
    K(m,3)  = rk_winsorized(x,alpha);
    K(m,4)  = rk_moors(x,qmethod);
    K(m,5)  = rk_hogg(x);
    K(m,6)  = rk_crow_siddiqui(x,qmethod);
    K(m,7)  = rk_lmoment(x);
    K(m,8)  = rk_tlmoment(x,1,1);
    K(m,9)  = rk_lq_median(x,qmethod);
    K(m,10) = rk_lq_trimean(x,qmethod);
    K(m,11) = rk_lq_gastwirth(x,qmethod);
end

meanEstimate = mean(K,1)';
stdEstimate = std(K,0,1)';
biasToReference = meanEstimate-reference;

results = table(names,reference,meanEstimate,stdEstimate,biasToReference, ...
    'VariableNames',{'Estimator','NormalReference','MonteCarloMean', ...
    'MonteCarloSTD','BiasToReference'});

disp(results);