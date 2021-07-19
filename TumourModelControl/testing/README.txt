README

---------------------------------------------------------------------------------------------------------------------------
To just run the model (no particle filtering) run work with "TumourModel."

First run: 

clibgen.generateLibraryDefinition("TumourModel\Model.cpp");

That will generate defineModel.m (and defineModel.mlx)

Delete defineModel.mlx and edit defineModel.m to uncomment the code at the bottom related to SeedAndGrowToStartVolume and 
CreateNewParticle and change the <SHAPE> to 1.

then in the command window run just:

build(defineModel)

and it should generate ModelInterface.dll in the Model subfolder.

Then you just need to add that to your MATLAB path (by clicking on the hyperlink)

then should be able to run:

p1 = clib.Model.SeedAndGrowToStartVolume(0.2, 0, 20, 170, 2, 201)
p1.TumourVolume()
p2 = clib.Model.CreateNewParticle(0.3, 0, 30, 160, 2, p1)
p2.SimulateOneDay(1)

---------------------------------------------------------------------------------------------------------------------------
To run the particle filtering with "TumourModel_ParticleFiltering."