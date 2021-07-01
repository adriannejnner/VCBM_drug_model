 function [oldpoint newpoint] = proliferate_faster(pointsmat,eps,s,page,imat)

                    %s = 1;
                    theta = 2*pi*rand(length(imat'),1);
                    Y = [pointsmat(imat,1)+s/page/2*cos(theta),pointsmat(imat,2)+s/page/2*sin(theta)];
                    pointsmat(imat,1:2) = [pointsmat(imat,1)+s/page/2*cos(pi+theta),pointsmat(imat,2)+s/page/2*sin(pi+theta)];
                    pointsmat(imat,3) = repmat([s/page],length(imat),1);
                    pointsmat(imat,4) = [size(pointsmat,1)+[1:1:length(imat')]];
                    pointsmat(imat,6) = 1;
                    oldpoint = pointsmat(imat,:);
                  %  newpoint =[Y repmat(s/page, length(imat),1) imat repmat(1,length(imat),1) repmat(randi([1 3],1),length(imat),1)];
                    newpoint =[Y repmat(s/page, length(imat),1) imat repmat(1,length(imat),1) repmat(1,length(imat),1)];
                    %pointsmat = [pointsmat;[Y repmat(s/page, length(imat),1) imat repmat(1,length(imat),1) repmat(randi([1 3],1),length(imat),1)]];
                    
 end
  