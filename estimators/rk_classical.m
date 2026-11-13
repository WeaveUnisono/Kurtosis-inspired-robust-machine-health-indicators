function K = rk_classical(x)
%RK_CLASSICAL Classical moment-based kurtosis m4/m2^2 (not excess kurtosis).
x = x(:);
mu = mean(x);
d = x - mu;
m2 = mean(d.^2);
m4 = mean(d.^4);
if m2 <= 0
    K = NaN;
else
    K = m4 / (m2^2);
end
end
