function ddd = disttoneighbours_v02_freecellmat(points,k,TRI)

           %TRI = delaunay(points(:,1),points(:,2));
           col1 = find(TRI(:,1)==k);
           col2 = find(TRI(:,2)==k);
           col3 = find(TRI(:,3)==k);
           col = [col1; col2; col3];
           d1 = [];
            d1array=[];
            for j = 1:length(col1)
                for h = 1:3
                d1(h) = pdist([points(k,1:2);points(TRI(col1(j)',h),1:2)],'euclidean');
                end
            d1array = [d1array d1];
            end
            
            d2 = [];
            d2array=[];
            for j = 1:length(col2)
                for h = 1:3
                d2(h) = pdist([points(k,1:2);points(TRI(col2(j)',h),1:2)],'euclidean');
                end
            d2array = [d2array d2];
            end
            
            d3 = [];
            d3array=[];
            for j = 1:length(col3)
                for h = 1:3
                d3(h) = pdist([points(k,1:2);points(TRI(col3(j)',h),1:2)],'euclidean');
                end
            d3array = [d3array d3];
            end
            ddd = [d1array d2array d3array];
            ddd = ddd(ddd~=0);
            
end