function [State_mat,Drug_grid_mat,freecell_mat] = model_simulator_singledruginjection_(State,params,total_time,initial_drug_grid,initial_fibre_grid,fibreposition)

old_drug_grid = initial_drug_grid;
old_fibre_grid = initial_fibre_grid;
OldState = State;
Oldfreecells = [];

    for ii = 1:total_time

        %solves drug diffusion (1 hour, with 1 min time increments) 
        [new_drug_grid new_fibre_grid] = Drug_diffusion_solver_fibre(old_drug_grid,old_fibre_grid,params,fibreposition);
       
        %solves one iteration of the VCBM based on the drug grid
        [State,drug_grid,freecellmat] = model_evolver_drug(OldState,params,new_drug_grid,Oldfreecells);

        %stores state of the system
        State_mat{ii} = State;
        Drug_grid_mat{ii} = drug_grid;
        Fibre_grid_mat{ii} = new_fibre_grid;
        freecell_mat{ii} = freecellmat;
        
        %Initialise current state as the old state to restart system
        OldState = State;
        old_drug_grid = drug_grid;
        old_fibre_grid = new_fibre_grid;
        Oldfreecells = freecellmat;
        ii
    end
    
end