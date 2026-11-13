function K = rk_hogg(x)
%RK_HOGG Hogg kurtosis based on lower and upper sample tail means.
xs = sort(x(:));
n = numel(xs);
n05 = max(1, floor(0.05*n));
n50 = max(1, floor(0.50*n));
L05 = mean(xs(1:n05));
U05 = mean(xs((n-n05+1):n));
L50 = mean(xs(1:n50));
U50 = mean(xs((n-n50+1):n));
K = (U05 - L05) / (U50 - L50);
end
