function K = rk_lq_gastwirth(x, qmethod)
%RK_LQ_GASTWIRTH Gastwirth-based LQ-kurtosis.
if nargin < 2
    qmethod = 'ecdf';
end
K = rk_lq_kurtosis(x,0.3,1/3,qmethod);
end
