% The first function simulates the model for a given time interval 
% and an initial state the section function calculates the residual 
%(difference between the model outpu and the data) for any given state of the system

% load in data for tumour growth
load('Tumour_growth_data.mat')

% loads a state of the model system 
load('THE TUMOUR') 
State = thetumour;

% initialise one PSC cell
State(1249,5) = 51;

%make healthy cell edge roughly circular (remove any unneccessary cells)
healthycell_locs = find(State(:,5)==4);
outside_rim = find(sqrt((State(healthycell_locs,1)-20).^2+(State(healthycell_locs,2)-20).^2)>40);
State(healthycell_locs(outside_rim),:)=[];

%loads all parameters in the model
params = paramvalues([]);
    
%Sets the time interval for the system to simulate forward on
tinterval = 24;
   
params.delta = 0.01;
params.clearance = 0.02;
params.r = 30/0.8;
params.dMAX = 60;%dmax;
params.mumage = 4;%gage;
params.page = 2;%page;

params.p_0 = 0.8;%params.Delta_t/params.r;
params.lengthtime=tinterval;
        
total_time = 1*24;% total time of simulation (hours)
params.grid_size = 100;
initial_drug_grid = zeros(params.grid_size,params.grid_size);
initial_drug_grid(50,50) = 50;

%simulates the system forward by tinterval
[State,Drug_grid] = model_simulator_singledruginjection(State,tinterval,params,total_time,initial_drug_grid);
      
figure
hold on 
subplot(2,2,1)
surf(Drug_grid{1},'EdgeColor','none')
zlabel('Drug conc.')
xlabel('x dim.')
ylabel('y dim.')
title('1 hour')
subplot(2,2,2)
surf(Drug_grid{10},'EdgeColor','none')
zlabel('Drug conc.')
xlabel('x dim.')
ylabel('y dim.')
title('10 hour')
subplot(2,2,3)
surf(Drug_grid{15},'EdgeColor','none')
zlabel('Drug conc.')
xlabel('x dim.')
ylabel('y dim.')
title('15 hour')
subplot(2,2,4)
surf(Drug_grid{24},'EdgeColor','none')
zlabel('Drug conc.')
xlabel('x dim.')
ylabel('y dim.')
title('24 hour')


figure
hold on 
tcount = 1
locsfibres = find(State{tcount}(:,5)==52);
fibremat = State{tcount}(locsfibres,:);
State{tcount}(locsfibres,:)=[];
gradientplota_stroma(State{tcount},fibremat)
xlim([-10,50])
ylim([-10 50])
title('Cells at 1 hours')
xlabel('x dim.')
ylabel('y dim.')

figure
hold on 
tcount = 10
locsfibres = find(State{tcount}(:,5)==52);
fibremat = State{tcount}(locsfibres,:);
State{tcount}(locsfibres,:)=[];
gradientplota_stroma(State{tcount},fibremat)
xlim([-10,50])
ylim([-10 50])
title('Cells at 10 hours')
xlabel('x dim.')
ylabel('y dim.')


figure
hold on 
tcount = 20
locsfibres = find(State{tcount}(:,5)==52);
fibremat = State{tcount}(locsfibres,:);
State{tcount}(locsfibres,:)=[];
gradientplota_stroma(State{tcount},fibremat)
xlim([-10,50])
ylim([-10 50])
title('Cells at 20 hours')
xlabel('x dim.')
ylabel('y dim.')

%XXX code still work in progress from here

for ii = 1:total_time
    tumourcells = find(State{ii}(:,5)<4);
    radius_distance = sqrt((State(tumourcells,1)-20).^2+(State(tumourcells,2)-20).^2);
    radius_scale =1/5;
    Tvol(ii) =  4/3*pi*(radius_scale*max(radius_distance)).^3;
    Number_Tcells(ii) = length(tumourcells);
end

figure
hold on 
plot(Tvol)


% XXXXXXXXXXXXXXXX
%calculates the residual between the State and correpsonding data point
        [residual Tvol Number_Tcells] = model_comparison_to_data(NewState,data);

        Tumour_volume(particle_count,time_interval_stepping) = Tvol;
        Number_of_cells(particle_count,time_interval_stepping) = Number_Tcells;
        
        %record vector of residuals corresponding to each particles
        %simulation
        res(particle_count) = residual
        toc

    
    %records vector of residuals for the paticles and stores them in a matrix for the different data time points
    res_mat(time_interval_stepping,:) = res;
    time_interval_stepping
    OldState = NewState;


% This calculates the mean tumour volume of the 4 mice
        data = nanmean(Control_tumour_growth(time_interval_stepping,:)); 

figure
hold on 
yyaxis left
plot(data_time(1:5), Tumour_volume,'LineWidth',5)
yyaxis right
plot(data_time(1:5), Number_of_cells,'LineWidth',5)

figure
hold on 
plot(data_time(1:5), res_mat,'ko','LineWidth',5)
xlabel('Time (days)')
ylabel('Residual')
set(gca,'FontSize',18)

