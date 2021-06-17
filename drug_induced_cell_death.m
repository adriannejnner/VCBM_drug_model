function [pointsmat,drug_grid] =  drug_induced_cell_death(pointsmat,drug_grid,grid_vec)

    grid_size = size(drug_grid,1);
    % find points in the drug grid that have a large enough concentration
    % above some tolerance
    locs_grid_enough = find(drug_grid>0.001);
        
    % for each grid point, find cells close by and determine whether they
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
           prob_cell_dies = drug_grid(ii,jj)/(drug_grid(ii,jj)+25)

            rand_prob = rand(1,length(cells_that_could_die));
            cells_to_die = find(prob_cell_dies<rand_prob);

            if isempty(cells_to_die) ==0
                size(cells_to_die)
                pointsmat(cells_that_could_die(cells_to_die),5) = 3;
            end
        end
        % XXXX still need to add cell uptake from drug grid
        % XXXX still need death model for once cell dies
    end
end