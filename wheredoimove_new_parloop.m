function  ri_new = wheredoimove_new_parloop(points,TRI,pointtomove,k,sarray,params)

s          = params.s;
mu         = params.mu;
Delta_t    = params.Delta_t;
eta        = params.eta;


%global s mu Delta_t eta

%Find location of this point in the points array
num = k;
col1 = find(TRI(:,1)==num);
col2 = find(TRI(:,2)==num);
col3 = find(TRI(:,3)==num);

col = [col1; col2; col3];

NEWmat = [];
NEWmat = reshape(TRI(col,:)',1,size(TRI(col,:),1)*size(TRI(col,:),2));
NEWmat = unique(NEWmat);
NEWmat = NEWmat(NEWmat~=num);
neighboursto_pointtomove = points(NEWmat,1:2);

ri = pointtomove;
rj = neighboursto_pointtomove;

uij = (rj-ri)./sqrt((rj(:,1)-ri(1)).^2+(rj(:,2)-ri(2)).^2);

svalspercell = sarray(NEWmat,:);

for g = 1:length(svalspercell)
   if svalspercell(g,1)<s&svalspercell(g,2)==num
      svect(g) = svalspercell(g,1);
   else
      svect(g) = s;
   end
end

dif = (sqrt((ri(1)-rj(:,1)).^2+(ri(2)-rj(:,2)).^2)-svect');

al = 0.05;
dif(find(dif>al))=0;

Fij = dif.*uij;



muvec = [];

for muveccount = 1:size(Fij,1)
   
    if svalspercell(muveccount,1)>50
        muvec(muveccount) = 5*1e-4;
    else
        muvec(muveccount) = mu;
    end
end


Fi = sum([muvec'.*Fij]);

ri_new = ri+Fi*Delta_t/eta;


end
