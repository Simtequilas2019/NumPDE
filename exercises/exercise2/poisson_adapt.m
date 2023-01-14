function [err,p,e,t] = poisson_adapt(g,tol)
[p,e,t] = initmesh(g);

while true
    nt = size(t,2);
    
    u = poisson(p,e,t);
    err = poisson_error(p,e,t,u);


    mypdeplot(p,e,t,'zdata',u)
    title("(Number of triangles) \times err_{max} = " + nt*max(err))
    
    
    refine_indices = find(err>(tol/nt));
    if isempty(refine_indices)
        break;
    end
    [p,e,t] = bisect(g,p,e,t,refine_indices);
end
end