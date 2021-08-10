%% Normal Simulation
addpath('Model','-end') % adds the path of the C++ code

% initialise parameters 
p0 = 0.2;
psc = 1e-5;
dmax = 20;
gage = 170;
page = 2;
EC50 = 0.01;

p0 = 0.2;

tumour_volume_initial = 201; %this is the size of the tumour we want to grow before we simulate treatment (or in this case no treatment)
p = clib.Model.SeedAndGrowToStartVolume(p0, psc, dmax, gage, page, EC50, tumour_volume_initial); % simulates the growth of a tumour starting at 1 cell and then stopping when the tumour volume reaches tumour_volume_initial

% initialise drug injection location and concentration
xinj1 = 0;
yinj1 = 0;
C0 = 50; 

for jj = 1:20 % does 250 different simulations of tumour growth
    
    psim = clib.Model.CreateNewParticle(p0, psc, dmax, gage, page, EC50, p); %sets the initial tumour size for the simulation as the size of the tumour "p", i.e. tumour_volume_initial
    psim.InjectFibre(10, 10, 100*526.3875/(11))
    
    for ii = 1:33 %simulates 33 days of tumour growth one day at a time - if possible can you also simulate for 50 and 100 days so we can see the difference between the three
        
        Tvol(ii) = psim.SimulateOneDay(1); %simulates the growth of the tumour for one day and returns its volume
        NumberTcells(ii) = psim.ReturnTotalNumberTumourCells;
        NumberDeadcells(ii) = psim.ReturnTotalNumberDeadCells;
        NumberPSCcells(ii) = psim.ReturnTotalNumberPSCCells;
        NumberHealthycells(ii) = psim.ReturnTotalNumberHealthyCells;
        Totaldrugconc(ii) = psim.ReturnDrugConcentration;
    end
    
    Tvol_mat(jj,:) = Tvol; %record the volume of the tumour over 33 days in a matrix for all the tumour growths of the 10 particles
    NumberTcells_mat(jj,:) = NumberTcells;
    NumberDeadcells_mat(jj,:) = NumberDeadcells;
    TotalDeadcells_mat(jj) = sum(NumberDeadcells);
    NumberPSCcells_mat(jj,:) = NumberPSCcells;
    NumberHealthycells_mat(jj,:) = NumberHealthycells;
    Totaldrugconc_mat(jj,:) = Totaldrugconc;
    jj
end
save('Longinj.mat', 'Tvol_mat');

% % plots the tumour volume of 10 simulations of the model for the same parameter values
figure
hold on 
plot(Tvol_mat',':','Color',[0.5 0.5 0.5], 'LineWidth',1)
xlabel('Time (days)')
ylabel('Tumour volume (mm^3)')
set(gca,'FontSize',18)
ylabel('Cells')
title('Tumour cells')

% % plots the tumour volume of 10 simulations of the model for the same parameter values
figure
hold on 
yyaxis left
plot(NumberTcells_mat',':','Color',[0.5 0.5 0.5], 'LineWidth',1)
ylabel('Cells')
yyaxis right
plot(NumberHealthycells_mat',':','Color',[0.5 0.5 0.5], 'LineWidth',1)
xlabel('Time (days)')
ylabel('Cells')
set(gca,'FontSize',18)
title('Tumour vs healthy cells')

% % plots the tumour volume of 10 simulations of the model for the same parameter values
figure
hold on 
plot(NumberDeadcells_mat',':','Color',[0.5 0.5 0.5], 'LineWidth',1)
xlabel('Time (days)')
ylabel('Cells')
set(gca,'FontSize',18)

% % plots the tumour volume of 10 simulations of the model for the same parameter values
figure
hold on 
histogram(TotalDeadcells_mat)
xlabel('Cells')
ylabel('Frequency')
set(gca,'FontSize',18)
title('Dead cells')
% 

% % plots the tumour volume of 10 simulations of the model for the same parameter values
figure
hold on 
plot(NumberPSCcells_mat',':','Color',[0.5 0.5 0.5], 'LineWidth',1)
xlabel('Time (days)')
ylabel('Cells')
set(gca,'FontSize',18)
title('PSC cells')
% 

% % plots the tumour volume of 10 simulations of the model for the same parameter values
figure
hold on 
plot(Totaldrugconc_mat','Color',[0.5 0.5 0.5], 'LineWidth',1)
xlabel('Time (days)')
ylabel('Conc')
set(gca,'FontSize',18)
title('Total drug concentration')

% 
% %plots the mean and std of the 10 simulations of tumour volume
fig1 = figure
hold on
options.handle = fig1;
options.color_area = [141,160,203]/255;
options.color_line =  [141,160,203]/255;
options.alpha = 0.3;
options.error = 'std';
options.line_width = 2;
options.x_axis = 1:33;
plot_areaerrorbar(Tvol_mat,options)
xlabel('Time (days)')
ylabel('Tumour volume (mm^3)')
set(gca,'FontSize',18)
