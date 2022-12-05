function out = initial_values(x)
n = numel(x);
out = zeros(n,1);
for k = 1:n
    out(k) = 1/2;
    if abs(x(k)-2) < 1/2
        out(k) = out(k) + exp(4 + 4./((2*x(k)-3).*(2*x(k)-5)));
    end
        
        
%Vectorized Version        
% out = 1/2 + (abs(x-2)<1/2)* 1/2 * exp(4 + 4./((2*x-3).*(2*x-5)))

end