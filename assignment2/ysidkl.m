% Written by: Yevgeny Seldin
%
% function y = ysidkl(x, z)
%
% Calculates the maximal bias y of a Bernoulli variable such that its 
% KL-divergence from a Bernoulli variable with bias x is bounded by z.
%
% y = argmax_y Dkl(x||y) < z
function y = ysidkl(x, z)

if ((x < 0) || (x > 1))
    error('wrong argument')
end

y = (1 + x) / 2;
step = (1 - x) / 2;

if (x > 0)
    p0 = x;
else
    p0 = 1;
end

while (step > eps)
    if (y == 0)
        y = eps;
    end
    
    if ((x * log(p0/y) + (1-x) * log((1-x)/(1-y))) < z)
        y = y + step;
    else
        y = y - step;
    end
    
    step = step / 2;
end