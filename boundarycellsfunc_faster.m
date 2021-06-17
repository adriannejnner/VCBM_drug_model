function [flag new51] = boundarycellsfunc_faster(points,TRI,num,typeofcell,neightypecell,prob_newPSCcellforms)

TRI = delaunay(points(:,1),points(:,2));
col1 = find(TRI(:,1)==num);
col2 = find(TRI(:,2)==num);
col3 = find(TRI(:,3)==num);

col = [col1; col2; col3];

NEWmat = [];
NEWmat = reshape(TRI(col,:)',1,size(TRI(col,:),1)*size(TRI(col,:),2));
NEWmat = unique(NEWmat);
NEWmat = NEWmat(NEWmat~=num);

neighboursto_pointtomove = points(NEWmat,:);
neighs = find(neighboursto_pointtomove(:,5)==neightypecell);

if isempty(neighs)==0
    if points(num,5)~=typeofcell
        flag = 0;
        if rand>prob_newPSCcellforms %make new PSC cell
            chosenneigh =round(rand*(length(neighs)-1))+1;
            new51 = NEWmat(neighs(chosenneigh));
        else 
            new51 = [];
        end
    else
        flag = 1;
        new51 = [];
    end
else 
    flag = 1;
    new51 = [];
end

end