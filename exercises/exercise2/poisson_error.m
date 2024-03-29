function err = poisson_error(p,e,t,u)
nt = size(t,2);
err = zeros(1,nt);
for k = 1:(nt-1)
       B_k = [p(:,t(2,k)) - p(:,t(1,k)), p(:,t(3,k)) - p(:,t(1,k))];
       grad_k = inv(B_k)' * [u(t(2,k)) - u(t(1,k)); u(t(3,k))- u(t(1,k))];
       
       for i = 1:3
           %Both properties should be fulfilled
           nb = find(sum((t(1:3,(k+1):nt)==t(i,k)) +...
                         (t(1:3,(k+1):nt)==t(mod(i,3)+1,k)))==2);
           l = k + nb;
           if ~isempty(l)
               B_l = [p(:,t(2,l)) - p(:,t(1,l)), p(:,t(3,l)) - p(:,t(1,l))];
               grad_l = inv(B_l') * [u(t(2,l)) - u(t(1,l)); u(t(3,l))- u(t(1,l))];
               
               
               s_kl = norm(p(1:2,t(i,k)) - p(1:2,t(mod(i,3) + 1,k)));
               err_kl = (s_kl *norm(grad_l - grad_k))^2;
               
               %Update Error
               err(k) = err(k) + err_kl;
               err(l) = err(l) + err_kl; % employ symmetry of error estimator
           end
       end
end