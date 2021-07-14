%% The below code runs the particle filtering algorithm for the VCBM model
% of pancreatic tumour growth. To run, you will first need to add the directory
% of the c++ code to your path

%% Add path of the C++ model
addpath('Model','-end') % adds the path of the C++ code

%% Load in data for tumour growth
load('Tumour_growth_data.mat')
size_data = size(Control_tumour_growth);
max_time = size_data(1)-1; %determines the length of time the experiment the data came from was run
n_mice   = size_data(2); %determines the number of mice (replicants) of the experiment the data came from

%% Load parameter dist mean, variance and minimum

%dist means mu for the parameters
p0_mu = 0.3;
psc_mu = 1e-5;
dmax_mu = 30;
gage_mu = 160;

%dist variance for the parameters
p0_sigma = 0.05;
psc_sigma = 0.05;
dmax_sigma = 0.05;
gage_sigma = 0.05;

%parameter minimum vals
p0_min = 0;
psc_min = 0;
dmax_min = 0;
gage_min = 0;

page = 2; % we are not going to fit this parameter but we need to set it

obsSigma = sqrt(2*2500);

%% Initialise particle filtering

%set the number of particles to simulate for
n = 250;
seed = 42;
rng(seed,'twister') % rng(seed) specifies the seed for the random number generator

%grow tumour from 1 cancer cell for n particles
startVolume = mean(Control_tumour_growth(1,:)); %volume to grow initial tumours to
for i = 1:n
    pf = clib.Model.SeedAndGrowToStartVolume(p0_mu, psc_mu, dmax_mu, gage_mu, page, startVolume);
    PFTumourVolume(i) = pf.TumourVolume(); %calculates tumour volume of one particle's simulation

    particle{i} = clib.Model.CreateNewParticle(0.3, 0, 30, 160, 2, pf); %stores particles start tumour pointer

    %create matrix of residuals of each particle to each mouse
    for j = 1:n_mice
        res_mat(1, j, i) =(pf.TumourVolume()- nanmean(Control_tumour_growth(1,:))).^2;
    end
end

p0_vec_pd = makedist('Normal', 'mu', 0.0, 'sigma', p0_sigma); %makes a normal dist with mean zero, variance sigma
p0_vec(1, :) = exp(log(p0_mu - p0_min) + random(p0_vec_pd, n, 1)) + p0_min;

dmax_mu_pd = makedist('Normal', 'mu', 0.0, 'sigma', dmax_sigma);
dmax_vec(1, :) = exp(log(dmax_mu - dmax_min) + random(dmax_mu_pd, n, 1)) + dmax_min;

gage_mu_pd = makedist('Normal', 'mu', 0.0, 'sigma', gage_sigma);
gage_vec(1, :) = floor(exp(log(gage_mu - gage_min) + random(gage_mu_pd, n, 1))) + gage_min;

psc_mu_pd = makedist('Normal', 'mu', 0.0, 'sigma', psc_sigma);
psc_vec(1, :) = exp(log(psc_mu - psc_min) + random(psc_mu_pd, n, 1)) + psc_min;

%% Simulate particle filtering for length of data

for t = 1:max_time-1

    for i = 1:n
        p00(i)   = p0_vec(t, i);
        dmaxx(i) = dmax_vec(t, i);
        gagee(i) = gage_vec(t, i);
        pscc(i)  = psc_vec(t, i);
    end

    m = 0.0;
    for i = 1:n
        m = m + PFTumourVolume(i);
    end
    tvol_mean_corrected(t) = m / n;


    for i = 1:n %for each particle

            %update particle's parameter values
            particle{i} = clib.Model.CreateNewParticle(p00(i), pscc(i), dmaxx(i), gagee(i), page, particle{i}); %stores particles start tumour pointer

            %simulate particle tumour growth forward one day
            PFTumourVolume(i) = particle{i}.SimulateOneDay(1); %simulates a day of tumour growth for each particle
    end

     for j = 1:n_mice
            % This calculates the mean tumour volume of the 4 mice
            data = nanmean(Control_tumour_growth(t+1, j:j));

            for i = 1:n %for each particle
                % Calculate the residual for each mouse at time t
                res(j, i) = (PFTumourVolume(i)- data);
            end
     end

    % records vector of residuals for the paticles and stores them in a
    % matrix for the different data time points
    res_mat(t+1, :, :) = res;
    tvol_mat(t+1, :)   = PFTumourVolume;
    tvol_mean_predicted(t) = mean(PFTumourVolume)
    t

    for i = 1:n
        log_weight(t, i) = 0;
        for j = 1:n_mice
            log_weight(t, i) = log_weight(t, i) - 1/(2 * obsSigma^2) * res(j, i).^2;
        end

    end
    % To avoid underflow when we move from log space
    max_log_weight = max(log_weight(t, :));
    non_norm_weight(t, :) = exp(log_weight(t, :) - max_log_weight);
    weight(t, :) = non_norm_weight(t, :) ./ sum(non_norm_weight(t, :));

    ind = resampstr(weight(t, :));
    %RESAMPSTR(P) returns a new set of indices according to the
    %probabilites P. P is an array of probabilities, which are not
    %neccessarily normalised, though they must be non-negative !! - this is
    %using stratified resampling

    G(t, :) = ind;
    for i = 1:n
        p0_vec(t + 1, i)     = exp(log(p0_vec(t, ind(i)) - p0_min)     + random(p0_vec_pd, 1, 1))    + p0_min;
        dmax_vec(t + 1, i)  = exp(log(dmax_vec(t, ind(i)) - dmax_min)  + random(dmax_mu_pd, 1, 1))  + dmax_min;
        gage_vec(t + 1, i)  = floor(exp(log(gage_vec(t, ind(i))  - gage_min)  + random(gage_mu_pd, 1, 1)))  + gage_min;
        psc_vec(t + 1, i) = exp(log(psc_vec(t, ind(i)) - psc_min) + random(psc_mu_pd, 1, 1)) + psc_min;
    end

end

%% Plot the output of the particle filtering :)

% predicted mean of particles and the mean of data
figure
hold on
errorbar(1:33, nanmean(Control_tumour_growth'),nanstd(Control_tumour_growth'),'LineWidth',2)
plot(tvol_mean_predicted,'LineWidth',2)
xlabel('Time (days)')
ylabel('Tumour volume (mm^3)')
set(gca,'FontSize',18)
xlim([0 34])


% predicted particles evoluation with individual mice data
figure
hold on
l1 = plot(tvol_mat(:,1),'Color',[0.6 0.85 0.79])
plot(tvol_mat(:,2:end),'Color',[0.6 0.85 0.79])
l2 = plot(Control_tumour_growth(:,1),'o:','Color',[0.5 0.5 0.5],'LineWidth',1)
plot(Control_tumour_growth(:,2:end),'o:','Color',[0.5 0.5 0.5],'LineWidth',1)
xlabel('Time (days)')
ylabel('Tumour volume (mm^3)')
set(gca,'FontSize',18)
xlim([0 34])
legend([l1 l2],{'Particles','Mice'})

% evolution of 50 particles with final parameter values
figure
hold on
l1 = plot(data_time(1:max_time), Control_tumour_growth(1:max_time, 1),'o:','Color','red','LineWidth',1)
plot(data_time(1:max_time), Control_tumour_growth(1:max_time, 2:n_mice),'o:','Color','red','LineWidth',1)
l3 = plot(data_time(2:max_time), tvol_mean_predicted(1 : max_time - 1),'*','Color','blue','LineWidth',5)
plot(data_time(2:max_time), tvol_mean_predicted(1 : max_time - 1),'*','Color','blue','LineWidth',5)
l4 = plot(data_time(2 : max_time), tvol_mean_corrected(1 : max_time -1),'*','Color','yellow','LineWidth',5)
plot(data_time(2 : max_time), tvol_mean_corrected(1 : max_time-1),'*','Color','yellow','LineWidth',5)
xlabel('Time (days)')
ylabel('Tumour Volume')
set(gca,'FontSize',18)
legend([l1 l3 l4], {'Data', 'Mean Pred', 'Mean Corr'})


% Plot the residuals
figure
hold on
l1 = plot(data_time(1:max_time), res_mat(:,1),'ko','LineWidth',5)
plot(data_time(1:max_time), res_mat(:,2:n),'ko','LineWidth',5)
xlabel('Time (days)')
ylabel('Residual')
set(gca,'FontSize',18)
legend([l1],{'Particles'})

% p0
figure
hold on
l1 = plot(data_time(1 : max_time), mean(p0_vec, 2),'o:','Color','red','LineWidth',1)
ylim([p0_min p0_mu + 0.5]);
xlabel('Time (days)')
ylabel('r')
set(gca,'FontSize',18)

% dmax
figure
hold on
l1 = plot(data_time(1 : max_time), mean(dmax_vec, 2),'o:','Color','red','LineWidth',1)
ylim([dmax_min dmax_mu + 50.0]);
xlabel('Time (days)')
ylabel('dmax')
set(gca,'FontSize',18)

% gage
figure
hold on
l1 = plot(data_time(1 : max_time), mean(gage_vec, 2),'o:','Color','red','LineWidth',1)
ylim([gage_min gage_mu + 50.0]);
xlabel('Time (days)')
ylabel('gage')
set(gca,'FontSize',18)

% psc
figure
hold on
l1 = plot(data_time(1 : max_time), mean(psc_vec, 2),'o:','Color','red','LineWidth',1)
ylim([psc_min psc_mu + 0.00001]);
xlabel('Time (days)')
ylabel('psc')
set(gca,'FontSize',18)
