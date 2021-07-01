function [Framp0_,drug_grid,freecellmat] = model_evolver_drug(pointsmat,params,drug_grid,freecellmat)

global p_0 s page rmin eps mu Delta_t eta lengthtime dMAX mumage

%Colum 1 and 2 are position
%Colum 3 represents slength
%Colum 4 locates the sibling
%Colum 5 represents the type where:
        %1 represents uninfected cells
        %2 represents infected cells
        %3 represents dead cells
        %4 represents healthy cells
        %5 empty cells
 
 page = params.page;
 mumage = params.mumage;
 p_0 = params.p_0;
 lengthtime = params.lengthtime;
 mu = params.mu;
 s = params.s;
 rmin = params.rmin;
 eps = params.eps;
 Delta_t = params.Delta_t;
 eta = params.eta;
 dMAX = params.dMAX;
 
 dage = 3; % number of hours it takes for cell to completely disintegrate
 
 
 prod_PSCcelldiff = params.prob_PSCcelldiff;%0.2;
 prob_newPSCcellforms = params.prob_newPSCcellforms;%0.99;
 
 moving_rim = 10;
   %tic
    pointsmatorig = pointsmat;
    locs5 = find(pointsmatorig(:,5)~=4); %find points that aren't healthy cells
    locs4 = find(pointsmatorig(:,5)==4); %find points that are healthy cells
    
    % determine max tumour radius
    max_tumour_radius = max(sqrt((pointsmatorig(locs5,1)-20).^2+(pointsmatorig(locs5,2)-20).^2));
    % desginate ring of healthy cells near tumour that move
    moving_healthy_cells_locs = find(sqrt((pointsmatorig(locs4,1)-20).^2+(pointsmatorig(locs4,2)-20).^2)<moving_rim+max_tumour_radius);
    nonmoving_healthy_cells_locs = find(sqrt((pointsmatorig(locs4,1)-20).^2+(pointsmatorig(locs4,2)-20).^2)>=moving_rim+max_tumour_radius);
    
    if isempty(nonmoving_healthy_cells_locs)==1
        %add extra healthy cells
        disp('Edge of healthy cell area reached')
        healthy_cell_edge = max(sqrt((pointsmatorig(locs4,1)-20).^2+(pointsmatorig(locs4,2)-20).^2));
        newhealthycells = adding_more_tissue(pointsmat,healthy_cell_edge,moving_rim,s,mumage);
        pointsmat = [pointsmat;newhealthycells];
        pointsmatorig = pointsmat;
    end
    
    wallpos = NaN;
     
    TRI = delaunay(pointsmatorig(:,1),pointsmatorig(:,2));
       
     pointstoremove = [];
     boundarycells = [];
     locs5 = find(pointsmatorig(:,5)~=4); %find points that aren't healthy cells
     locs4 = find(pointsmatorig(:,5)==4); %find points that are healthy cells
     % determine max tumour radius
     max_tumour_radius = max(sqrt((pointsmatorig(locs5,1)-20).^2+(pointsmatorig(locs5,2)-20).^2));
     % desginate ring of healthy cells near tumour that move
     moving_healthy_cells_locs = find(sqrt((pointsmatorig(locs4,1)-20).^2+(pointsmatorig(locs4,2)-20).^2)<moving_rim+max_tumour_radius);
     nonmoving_healthy_cells_locs = find(sqrt((pointsmatorig(locs4,1)-20).^2+(pointsmatorig(locs4,2)-20).^2)>=moving_rim+max_tumour_radius);
    
     % determins which cells are on the boundary of the tumour and then
     % assigns new PSC cells
     for num = 1:length(locs5)%length(pointsmatorig)
       [flz new51] = boundarycellsfunc_faster(pointsmatorig,TRI,locs5(num),4,4,prob_newPSCcellforms); % Calculating list of boundary cells
        if flz == 0;
             boundarycells = [boundarycells;pointsmatorig(locs5(num),:)];
             pointsmatorig(new51,5)=51;
             pointsmat(new51,5)=51;
        end
    end  
     
    newpointsmat = [];
    newpoint = [];
        
    for i = 1:length(moving_healthy_cells_locs)%(pointsmatorig)
         if pointsmatorig(locs4(moving_healthy_cells_locs(i)),5)==4 %healthy cells can move
              TRI = delaunay(pointsmatorig(:,1),pointsmatorig(:,2));
              pointsmat(locs4(moving_healthy_cells_locs(i)),1:2) = wheredoimove_new(pointsmatorig,TRI,pointsmatorig(locs4(moving_healthy_cells_locs(i)),1:2),locs4(moving_healthy_cells_locs(i)),pointsmatorig(:,3:4));
         end
    end
   
    % probably need a better way to model the space vector
   grid_vec = linspace(min([pointsmatorig(locs5,1);pointsmatorig(locs5,2)]),max([pointsmatorig(locs5,1);pointsmatorig(locs5,2)]),size(drug_grid,1));

   % for dead cells, they slowly disintegrate and are replaced by empty
   % place holder cells
   dead_cells = find(pointsmat(:,5)==3);
   [pointsmat] = dead_cell_disintegration(pointsmat,dead_cells,dage);
   
   [pointsmat,drug_grid] =  drug_induced_cell_death(pointsmat,drug_grid,grid_vec);
   pointsmatorig = pointsmat;
    
    l_1 = find(pointsmatorig(:,5)==1);
    l_1_mp = find(pointsmatorig(:,5)==1 & pointsmatorig(:,6)>= mumage);
    l_1_mu = find(pointsmatorig(:,5)==1 & pointsmatorig(:,6)<mumage);
            
    %uninfected cells ready to proliferate
    if isempty(l_1_mp)==0
        pointsmat(l_1_mp,4)=NaN; %remove link to daughter cell
        [pointsmat(l_1_mp,:), newpoint] = uninfectedcell_DT_faster(pointsmatorig,l_1_mp,boundarycells,TRI,params);
        newpointsmat = [newpointsmat;newpoint];  
    end
    
     %uninfected cells not ready to proliferate
     if isempty(l_1_mu)==0
         l_1_mu_g = find(pointsmatorig(l_1_mu,3)<s);
         l_1_mu_ng = find(pointsmatorig(l_1_mu,3)>=s);
         
          if isempty(l_1_mu_g)==0
             %daughter cells partner is alive
             l_dpa = find(ismember(pointsmatorig(l_1_mu(l_1_mu_g),4),pointsmatorig(:,4))==1);
             pointsmat(l_1_mu(l_1_mu_g(l_dpa)),3) =  pointsmatorig(l_1_mu(l_1_mu_g(l_dpa)),3)+s/page;
             posie = ismember(l_1_mu(l_1_mu_g),l_1_mu(l_1_mu_g(l_dpa)));
             moving = l_1_mu(l_1_mu_g(~posie));
             pointsmat(moving,3) =  s;
             pointsmat(moving,4) = NaN;
            [pointsmat(l_1_mu,:), newpoint] = uninfectedcell_DT_daughter_faster(pointsmatorig,l_1_mu,boundarycells,TRI,params);
          end
         
          if isempty(l_1_mu_ng)==0
              
              pointsmat(l_1_mu_ng,4)=NaN;
          end
          
          pointsmat(l_1_mu,6) = pointsmatorig(l_1_mu,6)+1;
     end
    
    newpoint = [];   
    
    locs51 = find(pointsmatorig(:,5)==51);
    [pointsmat(locs51,:), newpoint] = uninfectedcell_PSC_faster(pointsmatorig,locs51,boundarycells,TRI,params);
    pointsmat(locs51,6) = pointsmatorig(locs51,6)+1;

    newpointsmat = [newpointsmat;newpoint];
            
    pointsmat = [pointsmat;newpointsmat];
            
    %creating matrix off "empty" cells that are just used for plotting to
    %make sure no unrealistic cell sizes are introduced
    pointstoremove = find(pointsmat(:,5)== 3 & pointsmat(:,6)==dage);
   
    freecellmat = [freecellmat;[pointsmat(pointstoremove,1:4),repmat(5,length(pointstoremove),1),NaN(length(pointstoremove),1)]];
    pointsmat(pointstoremove,:) = [];
    
    
    cellisgone = [];
    for ff = 1:length(freecellmat)
        ddd = disttoneighbours_v02_freecellmat([pointsmat;freecellmat],ff+length(pointsmat));
        if min(ddd)<=s-7*eps
            cellisgone = [cellisgone;fcc];
        end
    end
    freecellmat(cellisgone,:) = [];
    
    Framp0_ = pointsmat; 
    freecellmat_ = freecellmat;   
       
       
%toc


end