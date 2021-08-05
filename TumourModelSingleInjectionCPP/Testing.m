x = rand;
y = rand; 

xcentre = 0.5;
ycentre = 0.5;

dist_to_centre = sqrt((x-0.5)^2+(y-0.5)^2);

radius = 0.5;
if dist_to_centre<radius
    disp('x,y point is in the circle')
else
    disp('x,y point is not in the circle')
end