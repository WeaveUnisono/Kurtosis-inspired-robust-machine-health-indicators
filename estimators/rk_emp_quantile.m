function q = rk_emp_quantile(x, p, method)
%RK_EMP_QUANTILE Sample quantile wrapper.
if nargin < 3
    method = 'ecdf';
end
q = rk_quantile_sorted(sort(x(:)), p, method);
end
