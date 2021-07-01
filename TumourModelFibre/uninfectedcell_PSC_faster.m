function [oldpoint newpoint] = uninfectedcell_PSC_faster(pointsmat,imat,boundarycells,TRI,params)

%global rmin eps mu Delta_t eta p_0 s page dMAX mumage p_i
% 
p_0 = params.p_0;
s = params.s;
page = params.page;
rmin = params.rmin;
eps = params.eps; 
mu = params.mu;
Delta_t = params.Delta_t;
eta = params.eta;
dMAX = params.dMAX;
mumage = params.mumage;
                    
                    
                    dvect =  sqrt((pointsmat(imat,1)-boundarycells(:,1)').^2+(pointsmat(imat,2)-boundarycells(:,2)').^2);%Calculating distance to all cells on the outside boundary. 
                    
                    [d, B] = min(dvect');
                                     
                    p = p_0*(1-d./dMAX);%calculating probability of proliferating
                    for icount = 1:length(imat)
                        ddd = disttoneighbours_v02(pointsmat,imat(icount),TRI);%calculating distance to nearest neighbours
                        distmin(icount) = sum(ddd<rmin);
                    end
                    %randmat = rand(1,length(imat));
                   %locs_half =  find(distmin<=1);
                   %probarray = randmat<p;
                   %locs_may_prolif = find(d(locs_half)<dMAX&probarray(locs_half)==1);
                   %ll = locs_half(locs_may_prolif)                
                   
                   %are the cells old enough to proliferate
                   %aged = find(pointsmat(imat(ll),6)>mumage)
                
                   locs_not_too_crowded =  find(distmin<=1);
                   randmat = rand(1,length(imat));
                   probarray = randmat<p;
                   locs_prob_good = find(probarray==1);
                   locs_not_necrotic_core = find(d<dMAX);
                   locs_not_too_young = find(pointsmat(imat,6)>mumage);
                                      
                   locs_prolif = intersect(intersect(locs_not_too_crowded,locs_prob_good),intersect(locs_not_necrotic_core,locs_not_too_young));
                   [oldpoint, newpoint] = proliferate_faster(pointsmat,eps,s,page,imat(locs_prolif));
                   
                   
                  TRI = delaunay(pointsmat(:,1),pointsmat(:,2));
                  posie = ismember(imat,imat(locs_prolif));

                  moving = imat(~posie);
                  for moving_count = 1:length(moving)
                    pointsmat(moving(moving_count),1:2) = wheredoimove_new_parloop(pointsmat,TRI,pointsmat(moving(moving_count),1:2),moving(moving_count),pointsmat(:,3:4),params);
                   oldpoint = [oldpoint; pointsmat(moving(moving_count),:)];
                  end
                    
end