function c = rk_binom_small(n, k)
%RK_BINOM_SMALL Binomial coefficient for scalar/vector n and small k.
n = double(n);
c = zeros(size(n));
valid = (n >= k) & (k >= 0);
if k == 0
    c(valid) = 1;
    return;
end
if k < 0 || abs(k-round(k)) > 0
    return;
end
c(valid) = 1;
for j = 1:k
    c(valid) = c(valid) .* (n(valid) - k + j) / j;
end
end
