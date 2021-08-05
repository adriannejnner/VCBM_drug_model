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
% xinj2 = 0;
% xinj3 = -40;
% xinj4 = 40;
yinj1 = 0;
% yinj2 = 40;
% yinj3 = 0;
% yinj4 = 0;
C0 = 2000*50; 

for jj = 1:250 % does 10 different simulations of tumour growth
    
    psim = clib.Model.CreateNewParticle(p0, psc, dmax, gage, page, EC50, p); %sets the initial tumour size for the simulation as the size of the tumour "p", i.e. tumour_volume_initial
    
    psim.InjectDrug(xinj1,yinj1,C0);
%     psim.InjectDrug(xinj2,yinj2,C0);
%     psim.InjectDrug(xinj3,yinj3,C0);
%     psim.InjectDrug(xinj4,yinj4,C0);% inject drug at position xinj, yinj and with concentration C0, where xinj = yinj = 0 is the centre of the tumour
    
    for ii = 1:33 %simulates 33 days of tumour growth one day at a time - if possible can you also simulate for 50 and 100 days so we can see the difference between the three
        
        Tvol(ii) = psim.SimulateOneDay(1); %simulates the growth of the tumour for one day and returns its volume

    end
    
    Tvol_mat(jj,:) = Tvol; %record the volume of the tumour over 33 days in a matrix for all the tumour growths of the 10 particles
   
    jj
end
save('Longinj.mat', 'Tvol_mat');

% % plots the tumour volume of 10 simulations of the model for the same parameter values
% figure
% hold on 
% plot(Tvol_mat',':','Color',[0.5 0.5 0.5], 'LineWidth',1)
% xlabel('Time (days)')
% ylabel('Tumour volume (mm^3)')
% set(gca,'FontSize',18)
% 
% %plots the mean and std of the 10 simulations of tumour volume
% fig1 = figure
% hold on
% options.handle = fig1;
% options.color_area = [141,160,203]/255;
% options.color_line =  [141,160,203]/255;
% options.alpha = 0.3;
% options.error = 'std';
% options.line_width = 2;
% options.x_axis = 1:33;
% plot_areaerrorbar(Tvol_mat,options)
% xlabel('Time (days)')
% ylabel('Tumour volume (mm^3)')
% set(gca,'FontSize',18)
%% Parameter Sensitivity Simulation: Setup
addpath('Model','-end') % adds the path of the C++ code

% initialise parameters 
p0 = 0.2;
psc = 1e-5;
dmax = 20;
gage = 170;
page = 2;
EC50 = 0.01;

%LargeMat = NaN(30,30);
params = [p0, psc, dmax, gage, page, EC50];
weight = [0.25, 0.75, 1.25, 1.75, 2.25];
save('LargeMatInj.mat', 'LargeMat');

%% Diagonals
k = 1;

load('LargeMat_data.mat')

% initialise drug injection location and concentration
xinj1 = 0;
yinj1 = 0;
C0 = 2000*50; 

tumour_volume_initial = 201; %this is the size of the tumour we want to grow before we simulate treatment (or in this case no treatment)

for j = 1:6
    for ii = 1:5
        %set up parameters
        tempMat = params;
        tempMat(j) = weight(ii) * tempMat(j);
        p0 = tempMat(1);
        psc = tempMat(2);
        dmax = tempMat(3);
        gage = 170;%round(tempMat(4))
        page = round(tempMat(5));
        EC50 = tempMat(6);

        %grow tumour with new parameters
        Tvol = zeros(1, 33);
        Tvol_mat = zeros(10, 33);
        % p = clib.Model.SeedAndGrowToStartVolume(p0, psc, dmax, gage, page, EC50, tumour_volume_initial); % simulates the growth of a tumour starting at 1 cell and then stopping when the tumour volume reaches tumour_volume_initial

        % Run 10 simulations of 33 day growth
        for jj = 1:10 % does 10 different simulations of tumour growth

            psim = clib.Model.CreateNewParticle(p0, psc, dmax, gage, page, EC50, p); %sets the initial tumour size for the simulation as the size of the tumour "p", i.e. tumour_volume_initial
            psim.InjectDrug(xinj1,yinj1,C0);
            for kk = 1:33 %simulates 33 days of tumour growth one day at a time - if possible can you also simulate for 50 and 100 days so we can see the difference between the three
                Tvol(kk) = psim.SimulateOneDay(1); %simulates the growth of the tumour for one day and returns its volume
            end
            Tvol_mat(jj,:) = Tvol; %record the volume of the tumour over 33 days in a matrix for all the tumour growths of the 10 particles
        end
        
        %store average end tumour volume
        Av_tumour_vol{j}(ii,:) = mean(Tvol_mat, 1);
        LargeMat(k, k) = Av_tumour_vol{j}(ii,end);
        LargeMat
        
        k= k+1            
        ii
        save('LargeMat_data.mat','LargeMat','Av_tumour_vol')
    end
    j
end

%% Boxes 

load('LargeMat_data.mat')

for a = 1:5
    a
    for b = a+1:6
        tempBox = zeros(5, 5);
        for c = 1:5
            for d = 1:5
                tempMat = params;
                tempMat(a) = weight(c)*tempMat(a);
                tempMat(b) = weight(d)*tempMat(b);
                
                p0 = tempMat(1);
                psc = tempMat(2);
                dmax = tempMat(3);
                gage = 170;%round(tempMat(4))
                page = round(tempMat(5));
                EC50 = tempMat(6);

                %grow tumour with new parameters
                Tvol = zeros(1, 33);
                Tvol_mat = zeros(10, 33);
                % p = clib.Model.SeedAndGrowToStartVolume(p0, psc, dmax, gage, page, EC50, tumour_volume_initial); % simulates the growth of a tumour starting at 1 cell and then stopping when the tumour volume reaches tumour_volume_initial

                % Run 10 simulations of 33 day growth
                for jj = 1:10 % does 10 different simulations of tumour growth

                    psim = clib.Model.CreateNewParticle(p0, psc, dmax, gage, page, EC50, p); %sets the initial tumour size for the simulation as the size of the tumour "p", i.e. tumour_volume_initial
                    psim.InjectDrug(xinj1,yinj1,C0);
                    for kk = 1:33 %simulates 33 days of tumour growth one day at a time - if possible can you also simulate for 50 and 100 days so we can see the difference between the three
                        Tvol(kk) = psim.SimulateOneDay(1); %simulates the growth of the tumour for one day and returns its volume
                    end
                    Tvol_mat(jj,:) = Tvol; %record the volume of the tumour over 33 days in a matrix for all the tumour growths of the 10 particles
                end
                tempBox(c,d) = mean(Tvol_mat(:,end));
                
            end
        end
        %store average end tumour volume
                LargeMat(5*a - 4:5*a, 5*b - 4:5*b) = tempBox;
                               
                LargeMat

                save('LargeMat_data.mat','LargeMat','Av_tumour_vol')
       % load('LargeMatInj.mat')
       % LargeMat(5*a - 4:5*a, 5*b - 4:5*b) = tempBox;
       % save('LargeMatInj.mat', 'LargeMat');
       % clear LargeMat
    end
end
%% Simulation Function
%save('LargeMatInj.mat', 'LargeMat')

function val = simulation(parameters)
addpath('Model','-end')
p0 = parameters(1);
psc = parameters(2);
dmax = parameters(3);
gage = parameters(4);
page = parameters(5);
EC50 = parameters(6);

Tvol = zeros(1, 33);
Tvol_mat = zeros(10, 33);
tumour_volume_initial = 201; %this is the size of the tumour we want to grow before we simulate treatment (or in this case no treatment)
p = clib.Model.SeedAndGrowToStartVolume(p0, psc, dmax, gage, page, EC50, tumour_volume_initial); % simulates the growth of a tumour starting at 1 cell and then stopping when the tumour volume reaches tumour_volume_initial

% initialise drug injection location and concentration
xinj1 = 0;
yinj1 = 0;
C0 = 2000*50; 

for jj = 1:10 % does 10 different simulations of tumour growth
    
    psim = clib.Model.CreateNewParticle(p0, psc, dmax, gage, page, EC50, p); %sets the initial tumour size for the simulation as the size of the tumour "p", i.e. tumour_volume_initial
    
    psim.InjectDrug(xinj1,yinj1,C0);
%     psim.InjectDrug(xinj2,yinj2,C0);
%     psim.InjectDrug(xinj3,yinj3,C0);
%     psim.InjectDrug(xinj4,yinj4,C0);% inject drug at position xinj, yinj and with concentration C0, where xinj = yinj = 0 is the centre of the tumour
    
    for ii = 1:33 %simulates 33 days of tumour growth one day at a time - if possible can you also simulate for 50 and 100 days so we can see the difference between the three
        
        Tvol(ii) = psim.SimulateOneDay(1); %simulates the growth of the tumour for one day and returns its volume

    end
    
    Tvol_mat(jj,:) = Tvol; %record the volume of the tumour over 33 days in a matrix for all the tumour growths of the 10 particles
end
Tvol_av = mean(Tvol_mat, 1);
val = Tvol_av(end);

end