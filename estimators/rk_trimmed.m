function K = rk_trimmed(x, alpha)
%RK_TRIMMED Classical kurtosis after symmetric trimming.
x = sort(x(:));
n = numel(x);
k = floor(alpha*n);
if alpha < 0 || alpha >= 0.5 || (n - 2*k) < 2
    error('Invalid trimming fraction alpha.');
end
y = x((k+1):(n-k));
K = rk_classical(y);
end
