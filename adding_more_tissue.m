function newhealthycells = adding_more_tissue(pointsmat,max_tumour_radius,moving_rim,s,mumage)


[X Y] = meshgrid((-moving_rim-max_tumour_radius-20):3:(20+moving_rim+max_tumour_radius));
X = sqrt(3) / 2 * X;
if mod(size(X,1),2)==0
    Y = Y + repmat([0 1],[size(X,1),size(X,1)/2]);
else 
   X = X(1:end-1,1:end-1);
   Y = Y(1:end-1,1:end-1);
   Y = Y + repmat([0 1],[size(X,1),size(X,1)/2]);
end
points = [X(:) Y(:)]+20;

locs_non_moving_rim = intersect(find(sqrt((points(:,1)-20).^2+(points(:,2)-20).^2)>max_tumour_radius),find(sqrt((points(:,1)-20).^2+(points(:,2)-20).^2)<=max_tumour_radius+moving_rim+10));
newhealthycells = [points(locs_non_moving_rim,:),repmat(s,length(locs_non_moving_rim),1),repmat(NaN,length(locs_non_moving_rim),1),repmat(4,length(locs_non_moving_rim),1),repmat(mumage,length(locs_non_moving_rim),1)];
        
end