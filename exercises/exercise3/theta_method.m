function v = theta_method(M, A, v0, r, T, K, theta)
dt = T/K;
n = size(v0,1);
v = zeros(n,K+1);
v(:,1) = v0;
r_new = r(0);
for k = 1:K
    %Helper
    r_old = r_new;
    r_new = r(k*dt);
    r_theta = dt*((1-theta)*r_old + theta * r_new);
    
    %Time Step
    v(:,k+1) = (M + theta * dt * A)\...
        ((M - (1-theta)*dt * A)*v(:,k) + r_theta);
end

end