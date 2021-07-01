function new_drug_grid = Drug_diffusion_solver(old_drug_grid,p)

sol = ode45(@modelsolver,0:1/60:60,old_drug_grid);
new_drug_grid = reshape(sol.y(:,end),p.grid_size,p.grid_size);

%------------------------------------------------------------------------
function dydt = modelsolver(t,y,Z)

    
    
    y_mat = reshape(y,p.grid_size,p.grid_size);
    dy = y_mat;
    
    %evaluating domain boundary
    for jj = 2:p.grid_size-1
        dy(1,jj) =( p.delta/4*y_mat(2,jj)+p.delta/4*y_mat(1,jj-1)+p.delta/4*y_mat(1,jj+1))-3*p.delta/4*y_mat(1,jj)-p.clearance*y_mat(1,jj);
    end
    for jj = 2:p.grid_size-1
        dy(p.grid_size,jj) =( p.delta/4*y_mat(p.grid_size-1,jj)+p.delta/4*y_mat(p.grid_size,jj-1)+p.delta/4*y_mat(p.grid_size,jj+1))-3*p.delta/4*y_mat(p.grid_size,jj)-p.clearance*y_mat(p.grid_size,jj);
    end
    for ii = 2:p.grid_size-1
            dy(ii,1) =( p.delta/4*y_mat(ii+1,1)+p.delta/4*y_mat(ii-1,1)+p.delta/4*y_mat(ii,2))-p.delta*y_mat(ii,1)-p.clearance*y_mat(ii,1);
    end
     for ii = 2:p.grid_size-1
            dy(ii,p.grid_size) =( p.delta/4*y_mat(ii+1,p.grid_size)+p.delta/4*y_mat(ii-1,p.grid_size)+p.delta/4*y_mat(ii,p.grid_size-1))-p.delta*y_mat(ii,p.grid_size)-p.clearance*y_mat(ii,p.grid_size);
    end   
    
    %evaluating remaining domain
    for ii = 2:p.grid_size-1
        for jj = 2:p.grid_size-1
            dy(ii,jj) =( p.delta/4*y_mat(ii+1,jj)+p.delta/4*y_mat(ii-1,jj)+p.delta/4*y_mat(ii,jj-1)+p.delta/4*y_mat(ii,jj+1))-p.delta*y_mat(ii,jj)-p.clearance*y_mat(ii,jj);
        end
    end

dydt = dy(:);
end
%-------------------------------------------------------------------------
end