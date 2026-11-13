function K = rk_lq_trimean(x, qmethod)
%RK_LQ_TRIMEAN Trimean-based LQ-kurtosis.
if nargin < 2
    qmethod = 'ecdf';
end
K = rk_lq_kurtosis(x,0.25,0.25,qmethod);
end
