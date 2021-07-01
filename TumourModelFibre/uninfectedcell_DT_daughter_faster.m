function [oldpoint newpoint] = uninfectedcell_DT_daughter_faster(pointsmat,imat,boundarycells,TRI,params)

%global rmin eps mu Delta_t eta p_0 s page dMAX mumage p_i

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
                    oldpoint = [];
                   TRI = delaunay(pointsmat(:,1),pointsmat(:,2));
                   for icount = 1:length(imat)
                            pointsmat(icount,1:2) = wheredoimove_new_parloop(pointsmat,TRI,pointsmat(imat(icount),1:2),imat(icount),pointsmat(:,3:4),params);
                            oldpoint = [oldpoint;pointsmat(imat(icount),:)];
                            
                   end
                    newpoint = [];
                    
end