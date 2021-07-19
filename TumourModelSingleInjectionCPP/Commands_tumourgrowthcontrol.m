
addpath('Model','-end') % adds the path of the C++ code

% initialise parameters 
p0 = 0.2;
psc = 1e-5;
dmax = 20;
gage = 170;
page = 201;

tumour_volume_initial = 201; %this is the size of the tumour we want to grow before we simulate treatment (or in this case no treatment)
p = clib.Model.SeedAndGrowToStartVolume(p0, psc, dmax, gage, page, tumour_volume_initial); % simulates the growth of a tumour starting at 1 cell and then stopping when the tumour volume reaches tumour_volume_initial

% timeSteps = 30;
% volumes = linspace(0,1,30);
% clib.Model.SimulateWholeExperiment(p0,psc,dmax,gage,page,tumour_volume_initial,timeSteps,[]);

for jj = 1:2 % does 10 different simulations of tumour growth
    psim = p;
    % psim = clib.Model.CreateNewParticle(p0, psc, dmax, gage, page, p); %sets the initial tumour size for the simulation as the size of the tumour "p", i.e. tumour_volume_initial
    
    for ii = 1:33 %simulates 33 days of tumour growth one day at a time - if possible can you also simulate for 50 and 100 days so we can see the difference between the three

        Tvol(ii) = psim.SimulateOneDay(1); %simulates the growth of the tumour for one day and returns its volume

    end  
    
    Tvol_mat(jj,:) = Tvol; %record the volume of the tumour over 33 days in a matrix for all the tumour growths of the 10 particles
  jj
end

% plots the tumour volume of 10 simulations of the model for the same parameter values
figure
hold on 
plot(Tvol_mat',':','Color',[0.5 0.5 0.5], 'LineWidth',1)
xlabel('Time (days)')
ylabel('Tumour volume (mm^3)')
set(gca,'FontSize',18)

%plots the mean and std of the 10 simulations of tumour volume
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
