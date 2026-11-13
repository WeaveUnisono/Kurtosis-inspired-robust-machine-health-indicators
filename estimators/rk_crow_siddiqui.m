function K = rk_crow_siddiqui(x, qmethod)
%RK_CROW_SIDDIQUI Crow-Siddiqui quantile kurtosis.
if nargin < 2
    qmethod = 'ecdf';
end
xs = sort(x(:));
q = rk_quantile_sorted(xs, [0.025 0.25 0.75 0.975], qmethod);
K = (q(4)-q(1)) / (q(3)-q(2));
end
