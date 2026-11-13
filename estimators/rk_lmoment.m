function K = rk_lmoment(x)
%RK_LMOMENT L-kurtosis l4/l2.
l = rk_lmoments(x,4);
K = l(4) / l(2);
end
