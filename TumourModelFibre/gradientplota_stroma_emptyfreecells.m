function gradientplota_stromg_emptyfreecells(pointsmat)

[v,c] = voronoin([pointsmat(:,1:2)]); 

col1 = spring(20);
col2 = parula(18);
col3 = jet(40);
col4 = gray(20);

for ig =1:length(c)
    if pointsmat(ig,5)==1;
        if all(c{ig}~=1)% 
        patch(v(c{ig},1),v(c{ig},2),col1(1,:)) % use color i.
            for j = 1:10
            newpoints =v(c{ig},:)+1/(11-j)*(pointsmat(ig,1:2)-v(c{ig},:));
            patch(newpoints(:,1),newpoints(:,2),col1(j+1+4,:),'EdgeColor','none') % use color i.
            end
        end
  
    elseif pointsmat(ig,5)==51;
         if all(c{ig}~=1)% If at least one of the indices is 1, 
          patch(v(c{ig},1),v(c{ig},2),col2(1,:)) % use color i.
            for j = 1:10
            newpoints =v(c{ig},:)+1/(11-j)*(pointsmat(ig,1:2)-v(c{ig},:));
            patch(newpoints(:,1),newpoints(:,2),col2(j+1,:),'EdgeColor','none') % use color i.
            end
         end
     elseif pointsmat(ig,5)==3;
         if all(c{ig}~=1)% If at least one of the indices is 1, 
         patch(v(c{ig},1),v(c{ig},2),col3(1,:)) % use color i.
            for j = 1:10
            newpoints =v(c{ig},:)+1/(11-j+2)*(pointsmat(ig,1:2)-v(c{ig},:));
            patch(newpoints(:,1),newpoints(:,2),col3(j+29,:),'EdgeColor','none') % use color i.
            end
         end
     elseif pointsmat(ig,5)==4;
         if all(c{ig}~=1)% If at least one of the indices is 1, 
         patch(v(c{ig},1),v(c{ig},2),col4(1,:)); % use color i.
            for j = 1:10
            newpoints =v(c{ig},:)+1/(11-j+2)*(pointsmat(ig,1:2)-v(c{ig},:));
            patch(newpoints(:,1),newpoints(:,2),col4(j+1,:),'EdgeColor','none') % use color i.
            end
         end
         
    end
end
 findloc = find(pointsmat(:,5)<4);
 xlim([0 40])
 ylim([0 40])
hold on 

plot(pointsmat(findloc,1),pointsmat(findloc,2),'k.','LineWidth',3)
%plot(pointsmat(findloc,1),pointsmat(findloc,2),'k.','LineWidth',3)
hold on 

 
 hold off
end