function params = paramvalues(thetumour)

params.p_0 = 0.8; % proliferation constant
params.s = 3.03; % Cell-cell spring rest length
params.page = 2; % Time between division and next possible attempt at division
params.rmin = 2;%minimum distance needed between at least one cell and the cell prolierating
params.eps = params.s/params.page; 
params.mu = 0.01;
params.Delta_t = 30;%30;
params.eta = 1;
params.dMAX = 60;
params.mumage = 4;
params.rfibrebound = 1;
params.d = 0.00000029;
params.C0 = 40000;
params.Doutside = 3;
params.prob_PSCcelldiff=0.2;
params.prob_newPSCcellforms=0.99;

params.delta = 0.01;
params.clearance = 0.02;
params.r = 30/0.8;
params.dMAX = 60;%dmax;
params.mumage = 4;%gage;
params.page = 2;%page;

params.p_0 = 0.8;%params.Delta_t/params.r;

end