function K = rk_winsorized(x, alpha)
%RK_WINSORIZED Classical kurtosis after symmetric winsorization.
x = sort(x(:));
n = numel(x);
k = floor(alpha*n);
if alpha < 0 || alpha >= 0.5 || (n - 2*k) < 2
    error('Invalid winsorization fraction alpha.');
end
y = x;
if k > 0
    y(1:k) = x(k+1);
    y((n-k+1):n) = x(n-k);
end
K = rk_classical(y);
end
