function u = poisson(p,e,t)
    %Solves for coefficient vector d - so u = phi*d but since for
    %evaluation points x_i only phi_i = 1 u_i = d_i
    n = size(p,2);
    [A,b] = poisson_init(p,e,t);
    interior = 1:n;
    interior(union(e(1,:),e(2,:))) = [];
    u = zeros(n,1);
    u(interior) = A\b;
end