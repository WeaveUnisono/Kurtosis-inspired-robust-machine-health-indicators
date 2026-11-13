function K = rk_tlmoment(x, s, k)
%RK_TLMOMENT TL-kurtosis l4^(s,k)/l2^(s,k).
if nargin < 2
    s = 1;
end
if nargin < 3
    k = 1;
end
l2 = rk_tlmoment_value(x,2,s,k);
l4 = rk_tlmoment_value(x,4,s,k);
K = l4 / l2;
end
