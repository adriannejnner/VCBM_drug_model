function [new_drug_grid new_fibre_grid] = Drug_diffusion_solver_fibre(old_drug_grid,old_fibre_grid,p,fibreposition)

%fibre parameters
sol = ode45(@modelsolver,0:60,[reshape(old_drug_grid,1,size(old_drug_grid,1)*size(old_drug_grid,2)),old_fibre_grid]);
new_drug_grid = reshape(sol.y(1:end-p.N,end),p.grid_size,p.grid_size);
new_fibre_grid = sol.y(end-p.N+1:end);

%------------------------------------------------------------------------
function dydt = modelsolver(t,y,Z)
   
    C_mat = reshape(y(1:end-p.N),p.grid_size,p.grid_size); %extract the drug concentration from the vector y and convert to matrix
    dC = C_mat;
    
    %evaluating domain boundary (assuming fibre isn't on boundary)
    for jj = 2:p.grid_size-1
        dC(1,jj) =( p.delta/4*C_mat(2,jj)+p.delta/4*C_mat(1,jj-1)+p.delta/4*C_mat(1,jj+1))-3*p.delta/4*C_mat(1,jj)-p.clearance*C_mat(1,jj);
    end
    for jj = 2:p.grid_size-1
        dC(p.grid_size,jj) =( p.delta/4*C_mat(p.grid_size-1,jj)+p.delta/4*C_mat(p.grid_size,jj-1)+p.delta/4*C_mat(p.grid_size,jj+1))-3*p.delta/4*C_mat(p.grid_size,jj)-p.clearance*C_mat(p.grid_size,jj);
    end
    for ii = 2:p.grid_size-1
            dC(ii,1) =( p.delta/4*C_mat(ii+1,1)+p.delta/4*C_mat(ii-1,1)+p.delta/4*C_mat(ii,2))-p.delta*C_mat(ii,1)-p.clearance*C_mat(ii,1);
    end
     for ii = 2:p.grid_size-1
            dC(ii,p.grid_size) =( p.delta/4*C_mat(ii+1,p.grid_size)+p.delta/4*C_mat(ii-1,p.grid_size)+p.delta/4*C_mat(ii,p.grid_size-1))-p.delta*C_mat(ii,p.grid_size)-p.clearance*C_mat(ii,p.grid_size);
    end   
    
    %evaluating remaining domain
    for ii = 2:p.grid_size-1
        for jj = 2:p.grid_size-1
            dC(ii,jj) =( p.delta/4*C_mat(ii+1,jj)+p.delta/4*C_mat(ii-1,jj)+p.delta/4*C_mat(ii,jj-1)+p.delta/4*C_mat(ii,jj+1))-p.delta*C_mat(ii,jj)-p.clearance*C_mat(ii,jj);
        end
    end
    
    %evaluating fibre release    
    d = p.k./(t/10+1)+p.d_const; %release rate - NOTE depends on t explicitly
        
    F_vec =  y(end-p.N+1:end);%extract the interior fibre concentrations from the vector y and convert to vec
    
    dF=[d*(F_vec(2)-F_vec(1))*(p.r0+p.Deltar/2)/p.r0]; %compartment 0

    for j = 2:p.N-2 %compartments 1 to N-2
        dF = [dF;...
            d*(F_vec(j-1)-F_vec(j))*(p.r0+j*p.Deltar-p.Deltar/2)/(p.r0+j*p.Deltar)+d*(F_vec(j+1)-F_vec(j))*(p.r0+j*p.Deltar+p.Deltar/2)/(p.r0+j*p.Deltar)];
    end

    dF = [dF;...
        d*(F_vec(p.N-2)-F_vec(p.N-1))*(p.r0+p.N*p.Deltar-p.Deltar/2)/(p.r0+p.N*p.Deltar)+d*(F_vec(p.N)-F_vec(p.N-1))*p.Aout/(p.r0+p.N*p.Deltar)];
    dF = [dF;...
        d*(F_vec(p.N-1)-F_vec(p.N))*(p.r0+p.N*p.Deltar+p.Deltar/2)/p.Aout]; 

    %add drug released from fibre to the drug concentration at fibre grid
    %points
    dC(fibreposition(:,1),fibreposition(:,2)) = dC(fibreposition(:,1),fibreposition(:,2))+dF(end); %adding the drug released out of the fibre to the fibreposition in the drug concentration grid
    
    
dydt = [dC(:); dF];

end
%-------------------------------------------------------------------------
end