function new_drug_grid = Drug_diffusion_solver(old_drug_grid,p)

sol = ode45(@modelsolver,0:1/60:60,old_drug_grid);
new_drug_grid = reshape(sol.y(:,end),p.grid_size,p.grid_size);

%------------------------------------------------------------------------
function dydt = modelsolver(t,y,Z)

    %XXXX still need to do no-flux on boundary and input fiber as diffusion
    %source XXXX
    y_mat = reshape(y,p.grid_size,p.grid_size);
    dy = y_mat;
    for ii = 2:p.grid_size-1
        for jj = 2:p.grid_size-1
            dy(ii,jj) = p.delta*(y_mat(ii+1,jj)+y_mat(ii-1,jj)+y_mat(ii,jj-1)+y_mat(ii,jj+1))-p.delta*y_mat(ii,jj)-p.clearance*y_mat(ii,jj);
        end
    end

dydt = dy(:);
end
%-------------------------------------------------------------------------
end