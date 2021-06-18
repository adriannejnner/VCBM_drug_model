function [pointsmat,drug_grid] =  drug_induced_cell_death(pointsmat,drug_grid,grid_vec)

    deltat = 1;
    celluptakerate = 0.1;

    grid_size = size(drug_grid,1);
    
    % find points in the drug grid that have a large enough concentration
    % above some tolerance
    locs_grid_enough = find(drug_grid>0.001);
        
    % for each grid point, if enough drug, find cells close by and determine whether they
    % lived or died based on the concentration of drug
    for grid_loc = 1:length(locs_grid_enough)
        if locs_grid_enough(grid_loc)>grid_size
            jj = rem(locs_grid_enough(grid_loc),grid_size);
            ii = (locs_grid_enough(grid_loc)-jj)/grid_size;
        else
            jj = 1;
            ii = locs_grid_enough(grid_loc);            
        end
        grid_point = [grid_vec(ii),grid_vec(jj)];
        
        cells_that_could_die = find(sqrt((pointsmat(:,1)-grid_point(1)).^2+(pointsmat(:,2)-grid_point(2)).^2)<=grid_vec(2)-grid_vec(1));
        
        if isempty(cells_that_could_die) ==0
           prob_cell_dies = drug_grid(ii,jj)/(drug_grid(ii,jj)+25); %IC50 = 25

            rand_prob = rand(1,length(cells_that_could_die));
            cells_to_die = find(prob_cell_dies<rand_prob);
            
            if isempty(cells_to_die) ==0 
                for kk = 1:length(cells_to_die)
                    if pointsmat(cells_that_could_die(cells_to_die),5) ~=3

                        pointsmat(cells_that_could_die(cells_to_die),5) = 3; %cells become type dead
                        pointsmat(cells_that_could_die(cells_to_die),6) = 1; %age becomes 1, tracks how many hours it has spent disintegrating
                        pointsmat(cells_that_could_die(cells_to_die),3) = pointsmat(cells_that_could_die(cells_to_die),3)/8; % cell starts process of disintegration by shorting spring length
                        pointsmat(cells_that_could_die(cells_to_die),4) = NaN; % cell loses sibling                
                
                        % cells that died uptake (might make this all cells in future)
                        drug_grid(ii,jj) = drug_grid(ii,jj)-drug_grid(ii,jj)*celluptakerate*deltat;
                    end
                end
            end
        end
        
    end
end