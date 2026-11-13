function K = rk_lq_kurtosis(x, p, alpha, qmethod)
%RK_LQ_KURTOSIS Generic LQ-kurtosis xi4/xi2.
% Uses beta quantiles of order-statistic distributions.
if nargin < 4
    qmethod = 'ecdf';
end
if p < 0 || p > 0.5 || alpha < 0 || alpha > 0.5
    error('Require 0 <= p <= 0.5 and 0 <= alpha <= 0.5.');
end
xs = sort(x(:));
xi2 = local_lqmoment(xs,2,p,alpha,qmethod);
xi4 = local_lqmoment(xs,4,p,alpha,qmethod);
K = xi4 / xi2;
end

function xi = local_lqmoment(xs, r, p, alpha, qmethod)
xi = 0;
for kk = 0:(r-1)
    j = r - kk;
    tau = local_tau(xs,j,r,p,alpha,qmethod);
    xi = xi + (-1)^kk * nchoosek(r-1,kk) * tau;
end
xi = xi / r;
end

function tau = local_tau(xs, j, r, p, alpha, qmethod)
weights = [p, 1-2*p, p];
levels = [alpha, 0.5, 1-alpha];
tau = 0;
for a = 1:3
    if weights(a) ~= 0
        u = betaincinv(levels(a), j, r-j+1);
        tau = tau + weights(a) * rk_quantile_sorted(xs,u,qmethod);
    end
end
end
