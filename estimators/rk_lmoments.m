function l = rk_lmoments(x, rmax)
%RK_LMOMENTS Unbiased sample L-moments following Hosking/Bastianin notation.
if nargin < 2
    rmax = 4;
end
xs = sort(x(:));
n = numel(xs);
if rmax > n
    error('rmax cannot exceed sample size.');
end

b = zeros(rmax,1);
for j = 0:(rmax-1)
    if j == 0
        w = ones(n,1);
    else
        ii = (0:(n-1))';
        w = rk_binom_small(ii,j) / rk_binom_small(n-1,j);
    end
    b(j+1) = mean(w .* xs);
end

l = zeros(rmax,1);
for r = 1:rmax
    val = 0;
    for j = 0:(r-1)
        pstar = (-1)^((r-1)-j) * nchoosek(r-1,j) * nchoosek((r-1)+j,j);
        val = val + pstar*b(j+1);
    end
    l(r) = val;
end
end
