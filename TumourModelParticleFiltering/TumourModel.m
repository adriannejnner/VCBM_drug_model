
%clibgen.generateLibraryDefinition("TumourModel\Model.cpp");

%delete MLX file and then uncomment relevant functions in .m file and add
%<SHAPE> as 1

build(defineModel)

%Add path of library by clicking on "interface file folder" hyperlink

import clib.Model.*

p1 = clib.Model.SeedAndGrowToStartVolume(0.2, 0, 20,170,2, 201)
p1.TumourVolume()
p2 = clib.Model.CreateNewParticle(0.3, 0, 30, 160, 2, p1)

figure
for jj = 1:10 %simulates 10 particles (fixed parameters)

    p1 = clib.Model.SeedAndGrowToStartVolume(0.2, 0, 20,170,2, 201);
    p1.TumourVolume();
    p2 = clib.Model.CreateNewParticle(0.3, 0, 30, 160, 2, p1);

    for ii = 1:10 %simulates 10 days 

        Tvol(ii) = p2.SimulateOneDay(1);

    end  
    %plots 10 tumour growths
    hold on 
    plot(Tvol)
end
