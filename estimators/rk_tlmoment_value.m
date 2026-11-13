function lr = rk_tlmoment_value(x, r, s, k)
%RK_TLMOMENT_VALUE Unbiased sample TL-moment l_r^(s,k).
xs = sort(x(:));
n = numel(xs);
if any([r s k] < 0) || any(abs([r s k]-round([r s k])) > 0)
    error('r, s, and k must be nonnegative integers, with r >= 1.');
end
if r < 1 || n < (r+s+k)
    error('Sample is too short for the requested TL-moment.');
end

j = ((s+1):(n-k))';
coef = zeros(size(j));
for i = 0:(r-1)
    a = r + s - i - 1;
    b = k + i;
    coef = coef + (-1)^i * nchoosek(r-1,i) .* ...
        rk_binom_small(j-1,a) .* rk_binom_small(n-j,b);
end

den = r * rk_binom_small(n,r+s+k);
lr = sum(coef .* xs(j)) / den;
end
