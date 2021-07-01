% Simulates the growth of a pancreatic tumour under the release of drug
% from a fibre injected at position (xinj,yinj), of size L and total drug concentration C0

% loads the initial tumour that treatment is started on 
State = initial_tumour();

%Initialise parameters in the model
params = paramvalues([]); %load in parameters
total_time = 24;% set total time of simulation (hours)
params.grid_size = 100; %set size of PDE grid
params.xinj = 20; %x location of fibre end
params.yinj = 15; %y location of fibre end
params.L = 30; %length of fibre
params.C0 = 526.3875; %total drug administered
params.d_const = 2.37*1e-14;
params.Aout = 8727.1;
params.N = 10;
params.k = 0.0025;
params.Deltar = 3.8;
params.r0 = params.Deltar;
initial_drug_grid = zeros(params.grid_size,params.grid_size); %initialise drug in grid
initial_fibre_grid = [repmat(2000*params.C0/(params.N+1),1,params.N-1),0];

grid_vec = linspace(-10,50,size(initial_drug_grid,1));
fibrepositionx = find(grid_vec>=params.xinj,1); 
fibrepositiony = find(grid_vec>=params.yinj,1); 
fibreposition = [fibrepositiony+[0:params.L-1]',repmat(fibrepositionx,params.L,1)];

%simulates growth of pancreatic cancer under injection for total_time hours
[State,Drug_grid,freecellmat] = model_simulator_singledruginjection(State,params,total_time,initial_drug_grid,initial_fibre_grid,fibreposition);
      
%% The following code plots the state of the model at 1hr, 12hrs and 24hrs

tcount = 1;% plotting at 1 hour
figure
hold on
subplot(1,2,1) 
gradientplota_stroma_emptyfreecells([State{tcount};freecellmat{tcount}])
xlim([-10,50])
ylim([-10 50])
xlabel('x dim.')
ylabel('y dim.')
set(gca,'FontSize',16)
title( sprintf('Cells at %d hour', tcount))
subplot(1,2,2) 
surf(Drug_grid{tcount})
xlabel('x dim.')
ylabel('y dim.')
set(gca,'FontSize',16)
title( sprintf('Drug conc at %d hour', tcount))
x0=10;
y0=10;
width=1000;
height=400;
set(gcf,'position',[x0,y0,width,height])

tcount = 12;% plotting at 12 hour
figure
hold on
subplot(1,2,1) 
gradientplota_stroma_emptyfreecells([State{tcount};freecellmat{tcount}])
xlim([-10,50])
ylim([-10 50])
xlabel('x dim.')
ylabel('y dim.')
set(gca,'FontSize',16)
title( sprintf('Cells at %d hour', tcount))
subplot(1,2,2) 
surf(Drug_grid{tcount})
xlabel('x dim.')
ylabel('y dim.')
set(gca,'FontSize',16)
title( sprintf('Drug conc at %d hour', tcount))
x0=10;
y0=10;
width=1000;
height=400;
set(gcf,'position',[x0,y0,width,height])

tcount = 24;% plotting at 24 hour
figure
hold on
subplot(1,2,1) 
gradientplota_stroma_emptyfreecells([State{tcount};freecellmat{tcount}])
xlim([-10,50])
ylim([-10 50])
xlabel('x dim.')
ylabel('y dim.')
set(gca,'FontSize',16)
title( sprintf('Cells at %d hour', tcount))
subplot(1,2,2) 
surf(Drug_grid{tcount})
xlabel('x dim.')
ylabel('y dim.')
set(gca,'FontSize',16)
title( sprintf('Drug conc at %d hour', tcount))
x0=10;
y0=10;
width=1000;
height=400;
set(gcf,'position',[x0,y0,width,height])

%% The following calculates the tumour volume for the simulation and plots it over time

%calculating the tumour volume at each hour of the simulation
for ii = 1:total_time
    tumourcells = find(State{ii}(:,5)<4);
    radius_distance = sqrt((State{ii}(tumourcells,1)-20).^2+(State{ii}(tumourcells,2)-20).^2);
    radius_scale =1/5;
    Tvol(ii) =  4/3*pi*(radius_scale*max(radius_distance)).^3;
    Number_Tcells(ii) = length(tumourcells);
end

figure
hold on 
plot(Tvol,'LineWidth',2)
xlabel('Time (hours)')
ylabel('Tumour volume')
set(gca,'FontSize',16)

figure
hold on 
plot(Number_Tcells,'LineWidth',2)
xlabel('Time (hours)')
ylabel('Number of tumour cells')
set(gca,'FontSize',16)

%% The following code dreates a video animation of the tumour evolution under treatment
v = VideoWriter('TumourInjectionVideo.avi');
v.FrameRate = 1;
open(v);
figure
hold on 
for tcount=1:total_time
    

subplot(1,2,1) 
gradientplota_stroma_emptyfreecells([State{tcount};freecellmat{tcount}])
xlim([-10,50])
ylim([-10 50])
xlabel('x dim.')
ylabel('y dim.')
set(gca,'FontSize',16)
title( sprintf('Cells at %d hour', tcount))

subplot(1,2,2) 
surf(Drug_grid{tcount})
xlabel('x dim.')
ylabel('y dim.')
set(gca,'FontSize',16)
title( sprintf('Drug conc at %d hour', tcount))

x0=10;
y0=10;
width=1000;
height=400;
set(gcf,'position',[x0,y0,width,height])

frame = getframe(gcf);
writeVideo(v,frame);
clf
end
close(v)
