function State = initial_tumour()
    load('THE TUMOUR') 
    State = thetumour;

    % initialise one PSC cell on the edge of the tumour
    State(1249,5) = 51;

    %make healthy cell edge roughly circular (remove any unneccessary cells)
    healthycell_locs = find(State(:,5)==4);
    outside_rim = find(sqrt((State(healthycell_locs,1)-20).^2+(State(healthycell_locs,2)-20).^2)>40);
    State(healthycell_locs(outside_rim),:)=[];
end