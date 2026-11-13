function K = rk_lq_median(x, qmethod)
%RK_LQ_MEDIAN Median-based LQ-kurtosis.
if nargin < 2
    qmethod = 'ecdf';
end
K = rk_lq_kurtosis(x,0,0.5,qmethod);
end
