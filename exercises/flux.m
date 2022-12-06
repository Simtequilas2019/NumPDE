function [G, Gs] = flux(spec)
    switch spec
        case "lax"
            G = @(u,n,j,dt,dx) (u(n,j).*(1-u(n,j) + u(n,j+1).*(1-u(n,j+1))/2)) - dx/(2.*dt).*(u(n,j+1)-u(n,j));
            Gs = @(u,n,dt,dx) (u(n,end).*(1-u(n,end)) + u(n,1).*(1-u(n,1)))/(2) - dx/(2.*dt).*(u(n,1)-u(n,end));
        case "up"
            G = @(u,n,j,dt,dx) u(n,j).*(1-u(n,j));
            Gs = @(u,n,dt,dx) u(n,end).*(1-u(n,end));
        case "down"
            G = @(u,n,j,dt,dx) u(n,j+1).*(1-u(n,j+1));
            Gs = @(u,n,dt,dx) u(n,1).*(1-u(n,1));            
        otherwise
            disp(spec)
             G = @(u,n,j,dt,dx) 0;
            Gs = @(u,n,dt,dx) 0; 
            disp('Zero flux')
    end
end