function K = rk_moors(x, qmethod)
%RK_MOORS Moors quantile kurtosis.
if nargin < 2
    qmethod = 'ecdf';
end
xs = sort(x(:));
q = rk_quantile_sorted(xs, [1/8 2/8 3/8 5/8 6/8 7/8], qmethod);
K = ((q(3)-q(1)) + (q(6)-q(4))) / (q(5)-q(2));
end
