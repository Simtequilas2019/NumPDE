function u = poisson(p,e,t)
    %Solves for coefficient vector d - so u = phi*d but since for
    %evaluation points x_i only phi_i = 1 u_i = d_i
    [A,b] = poisson_init(p,e,t);
    u = A\b;
    mypdeplot(p,e,t,'zdata',u)
end