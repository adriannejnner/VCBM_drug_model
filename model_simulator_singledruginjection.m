function [State_mat,Drug_grid_mat] = model_simulator_singledruginjection_(State,tinterval,params,total_time,initial_drug_grid)

old_drug_grid = initial_drug_grid;
OldState = State;

    for ii = 1:total_time

        %solves drug diffusion (1 hour, with 1 min time increments) 
        new_drug_grid = Drug_diffusion_solver(old_drug_grid,params);
       
        %solves one iteration of the VCBM based on the drug grid
        [State,drug_grid] = model_evolver_drug(OldState,params,new_drug_grid);

        %stores state of the system
        State_mat{ii} = State;
        Drug_grid_mat{ii} = drug_grid;
        
        %Initialise current state as the old state to restart system
        OldState = State;
        old_drug_grid = drug_grid;
        ii
    end
    
end