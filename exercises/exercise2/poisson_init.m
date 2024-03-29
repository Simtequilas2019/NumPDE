function [A,b] = poisson_init(p,e,t)
%Computes the stiffness matrix A and the right hand side b
%The matrix A is sparse 
n = size(p,2);
num_elem = size(t,2);
A = sparse(n,n);
b = zeros(n,1);
reference = @(x,y) [1-x-y, x, y];
grad_reference = [-1, 1, 0;...
                  -1, 0, 1];

%in edge e boundaries from p1 to p2 are stored
bound_points = union(e(1,:),e(2,:)); 


%We iterate over all triangle elements and add the components 
%to the assembled matrix
%If it is a boundary we will set it to g(.) = 0
%Calculation according to NUMPDE skript p.104-106
    for t_elem = 1:num_elem
        B = [p(:,t(2,t_elem)) - p(:,t(1,t_elem)), p(:,t(3,t_elem))- p(:,t(1,t_elem))];
        det_B = abs(det(B));
        inv_B = inv(B);
        %Area of the reference element T = 1/2 and Trafo B since const.
        %functions
        A_help = 1/2 * det_B * grad_reference'*inv_B*inv_B'*grad_reference;
        
        
        
        %For each triangular element there are three corners(c1,c2,c3), so the
        %element has an influence at A_(c1,c1) ... A_(c1,c2) ... A(c1,c3)
        %                            A_(c2,c1) ... A_(c2,c2) ... A(c2,c3)
        %                            A_(c3,c1) ... A_(c3,c2) ... A(c3,c3)
        %The reference mapping g from local to global coordinates is
        %defined in t(.)
        
        for i = 1:3
            ih = t(i,t_elem);
            b(ih) = b(ih) + 1/3 * det_B * 1/2;
            %Assemble A
            for j = 1:3
                jh = t(j,t_elem);
                A(ih,jh) = A(ih,jh) + A_help(i,j);

            end
        end

%         for i = 1:3
%             ih = t(i,t_elem);
%             if ~any(ih == bound_points)
%                 %Calculate b
%                 b(ih) = b(ih) + 1/3 * det_B * 1/2;
%                 %Assemble A
%                 for j = 1:3
%                     jh = t(i,t_elem);
%                     if ~any(jh == bound_points)
%                         A(ih,jh) = A(ih,jh) + A_help(i,j);
%                     end
%                 end
%             end
%         end

       
            
    end
    
    A(:,bound_points) = [];
    A(bound_points,:) = [];
    b(bound_points) = [];


end