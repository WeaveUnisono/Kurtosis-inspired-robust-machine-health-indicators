function q = rk_quantile_sorted(xs, p, method)
%RK_QUANTILE_SORTED Sample quantile for an already sorted sample.
% method = 'ecdf' : inverse empirical CDF, x_(ceil(n*p))
% method = 'mh98' : linear interpolation used by Mudholkar and Hutson (1998)
if nargin < 3
    method = 'ecdf';
end
xs = xs(:);
n = numel(xs);
pShape = size(p);
p = p(:);
q = zeros(size(p));
if any(p < 0 | p > 1)
    error('Quantile levels must lie in [0,1].');
end

switch lower(method)
    case 'ecdf'
        idx = ceil(n*p);
        idx(idx < 1) = 1;
        idx(idx > n) = n;
        q = xs(idx);

    case 'mh98'
        for a = 1:numel(p)
            z = (n + 1)*p(a);
            if z <= 1
                q(a) = xs(1);
            elseif z >= n
                q(a) = xs(n);
            else
                h = floor(z);
                e = z - h;
                q(a) = (1-e)*xs(h) + e*xs(h+1);
            end
        end

    otherwise
        error('Unknown quantile method. Use ''ecdf'' or ''mh98''.');
end
q = reshape(q, pShape);
end
