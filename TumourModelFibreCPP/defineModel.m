%% About defineModel.mlx
% This file defines the MATLAB interface to the library |Model|.
%
% Commented sections represent C++ functionality that MATLAB cannot automatically define. To include
% functionality, uncomment a section and provide values for &lt;SHAPE&gt;, &lt;DIRECTION&gt;, etc. For more
% information, see <matlab:helpview(fullfile(docroot,'matlab','helptargets.map'),'cpp_define_interface') Define MATLAB Interface for C++ Library>.



%% Setup. Do not edit this section.
function libDef = defineModel()
libDef = clibgen.LibraryDefinition("ModelData.xml");
%% OutputFolder and Libraries 
libDef.OutputFolder = "C:\Users\jenner2\OneDrive - Queensland University of Technology\Documents\2021\Polymer\Izzy\TumourModelFibreCPP";
libDef.Libraries = "";

%% C++ enumeration |CellType| with MATLAB name |clib.Model.CellType| 
addEnumeration(libDef, "CellType", "int32",...
    [...
      "Cancer",...  % 1
      "Dead",...  % 3
      "Healthy",...  % 4
      "Empty",...  % 5
      "PSC",...  % 51
    ],...
    "MATLABName", "clib.Model.CellType", ...
    "Description", "clib.Model.CellType    Representation of C++ enumeration CellType."); % Modify help description values as needed.

%% C++ class |CellState| with MATLAB name |clib.Model.CellState| 
CellStateDefinition = addClass(libDef, "CellState", "MATLABName", "clib.Model.CellState", ...
    "Description", "clib.Model.CellState    Representation of C++ class CellState."); % Modify help description values as needed.

%% C++ class constructor for C++ class |CellState| 
% C++ Signature: CellState::CellState()
CellStateConstructor1Definition = addConstructor(CellStateDefinition, ...
    "CellState::CellState()", ...
    "Description", "clib.Model.CellState.CellState    Constructor of C++ class CellState."); % Modify help description values as needed.
validate(CellStateConstructor1Definition);

%% C++ class constructor for C++ class |CellState| 
% C++ Signature: CellState::CellState(CellState const & input1)
CellStateConstructor2Definition = addConstructor(CellStateDefinition, ...
    "CellState::CellState(CellState const & input1)", ...
    "Description", "clib.Model.CellState.CellState    Constructor of C++ class CellState."); % Modify help description values as needed.
defineArgument(CellStateConstructor2Definition, "input1", "clib.Model.CellState", "input");
validate(CellStateConstructor2Definition);

%% C++ class public data member |type| for C++ class |CellState| 
% C++ Signature: CellType CellState::type
addProperty(CellStateDefinition, "type", "clib.Model.CellType", ...
    "Description", "clib.Model.CellType    Data member of C++ class CellState."); % Modify help description values as needed.

%% C++ class public data member |age| for C++ class |CellState| 
% C++ Signature: int CellState::age
addProperty(CellStateDefinition, "age", "int32", ...
    "Description", "int32    Data member of C++ class CellState."); % Modify help description values as needed.

%% C++ class public data member |spring_length| for C++ class |CellState| 
% C++ Signature: double CellState::spring_length
addProperty(CellStateDefinition, "spring_length", "double", ...
    "Description", "double    Data member of C++ class CellState."); % Modify help description values as needed.

%% C++ class public data member |sibling| for C++ class |CellState| 
% C++ Signature: Cell * CellState::sibling
addProperty(CellStateDefinition, "sibling", "clib.Model.Cell", 1, ... % '<MLTYPE>' can be clib.Model.Cell, or clib.array.Model.Cell
   "Description", "clib.Model.Cell    Data member of C++ class CellState."); % Modify help description values as needed.

%% C++ class public data member |X| for C++ class |CellState| 
% C++ Signature: double CellState::X
addProperty(CellStateDefinition, "X", "double", ...
    "Description", "double    Data member of C++ class CellState."); % Modify help description values as needed.

%% C++ class public data member |Y| for C++ class |CellState| 
% C++ Signature: double CellState::Y
addProperty(CellStateDefinition, "Y", "double", ...
    "Description", "double    Data member of C++ class CellState."); % Modify help description values as needed.

%% C++ class |Params| with MATLAB name |clib.Model.Params| 
ParamsDefinition = addClass(libDef, "Params", "MATLABName", "clib.Model.Params", ...
    "Description", "clib.Model.Params    Representation of C++ class Params."); % Modify help description values as needed.

%% C++ class constructor for C++ class |Params| 
% C++ Signature: Params::Params(double p_0,double p_psc,double dmax,int gage,int page)
ParamsConstructor1Definition = addConstructor(ParamsDefinition, ...
    "Params::Params(double p_0,double p_psc,double dmax,int gage,int page)", ...
    "Description", "clib.Model.Params.Params    Constructor of C++ class Params."); % Modify help description values as needed.
defineArgument(ParamsConstructor1Definition, "p_0", "double");
defineArgument(ParamsConstructor1Definition, "p_psc", "double");
defineArgument(ParamsConstructor1Definition, "dmax", "double");
defineArgument(ParamsConstructor1Definition, "gage", "int32");
defineArgument(ParamsConstructor1Definition, "page", "int32");
validate(ParamsConstructor1Definition);

%% C++ class method |RandomDouble| for C++ class |Params| 
% C++ Signature: double Params::RandomDouble()
RandomDoubleDefinition = addMethod(ParamsDefinition, ...
    "double Params::RandomDouble()", ...
    "Description", "clib.Model.Params.RandomDouble    Method of C++ class Params."); % Modify help description values as needed.
defineOutput(RandomDoubleDefinition, "RetVal", "double");
validate(RandomDoubleDefinition);

%% C++ class method |WithProbability| for C++ class |Params| 
% C++ Signature: bool Params::WithProbability(double prob)
WithProbabilityDefinition = addMethod(ParamsDefinition, ...
    "bool Params::WithProbability(double prob)", ...
    "Description", "clib.Model.Params.WithProbability    Method of C++ class Params."); % Modify help description values as needed.
defineArgument(WithProbabilityDefinition, "prob", "double");
defineOutput(WithProbabilityDefinition, "RetVal", "logical");
validate(WithProbabilityDefinition);

%% C++ class public data member |gage| for C++ class |Params| 
% C++ Signature: int Params::gage
addProperty(ParamsDefinition, "gage", "int32", ...
    "Description", "int32    Data member of C++ class Params."); % Modify help description values as needed.

%% C++ class public data member |page| for C++ class |Params| 
% C++ Signature: int Params::page
addProperty(ParamsDefinition, "page", "int32", ...
    "Description", "int32    Data member of C++ class Params."); % Modify help description values as needed.

%% C++ class public data member |p_0| for C++ class |Params| 
% C++ Signature: double Params::p_0
addProperty(ParamsDefinition, "p_0", "double", ...
    "Description", "double    Data member of C++ class Params."); % Modify help description values as needed.

%% C++ class public data member |dmax| for C++ class |Params| 
% C++ Signature: double Params::dmax
addProperty(ParamsDefinition, "dmax", "double", ...
    "Description", "double    Data member of C++ class Params."); % Modify help description values as needed.

%% C++ class public data member |p_psc| for C++ class |Params| 
% C++ Signature: double Params::p_psc
addProperty(ParamsDefinition, "p_psc", "double", ...
    "Description", "double    Data member of C++ class Params."); % Modify help description values as needed.

%% C++ class |Cell| with MATLAB name |clib.Model.Cell| 
CellDefinition = addClass(libDef, "Cell", "MATLABName", "clib.Model.Cell", ...
    "Description", "clib.Model.Cell    Representation of C++ class Cell."); % Modify help description values as needed.

%% C++ class constructor for C++ class |Cell| 
% C++ Signature: Cell::Cell(double X,double Y,double spring_length,Cell * sibling,CellType type,int age)
CellConstructor1Definition = addConstructor(CellDefinition, ...
   "Cell::Cell(double X,double Y,double spring_length,Cell * sibling,CellType type,int age)", ...
   "Description", "clib.Model.Cell.Cell    Constructor of C++ class Cell."); % Modify help description values as needed.
defineArgument(CellConstructor1Definition, "X", "double");
defineArgument(CellConstructor1Definition, "Y", "double");
defineArgument(CellConstructor1Definition, "spring_length", "double");
defineArgument(CellConstructor1Definition, "sibling", "clib.Model.Cell", "input", 1); % '<MLTYPE>' can be clib.Model.Cell, or clib.array.Model.Cell
defineArgument(CellConstructor1Definition, "type", "clib.Model.CellType");
defineArgument(CellConstructor1Definition, "age", "int32");
validate(CellConstructor1Definition);

%% C++ class constructor for C++ class |Cell| 
% C++ Signature: Cell::Cell(Cell * cell)
CellConstructor2Definition = addConstructor(CellDefinition, ...
   "Cell::Cell(Cell * cell)", ...
   "Description", "clib.Model.Cell.Cell    Constructor of C++ class Cell."); % Modify help description values as needed.
defineArgument(CellConstructor2Definition, "cell", "clib.Model.Cell", "input", 1); % '<MLTYPE>' can be clib.Model.Cell, or clib.array.Model.Cell
validate(CellConstructor2Definition);

%% C++ class method |Renew| for C++ class |Cell| 
% C++ Signature: void Cell::Renew()
RenewDefinition = addMethod(CellDefinition, ...
    "void Cell::Renew()", ...
    "Description", "clib.Model.Cell.Renew    Method of C++ class Cell."); % Modify help description values as needed.
validate(RenewDefinition);

%% C++ class method |UpdateState| for C++ class |Cell| 
% C++ Signature: void Cell::UpdateState()
UpdateStateDefinition = addMethod(CellDefinition, ...
    "void Cell::UpdateState()", ...
    "Description", "clib.Model.Cell.UpdateState    Method of C++ class Cell."); % Modify help description values as needed.
validate(UpdateStateDefinition);

%% C++ class method |Infect| for C++ class |Cell| 
% C++ Signature: void Cell::Infect()
InfectDefinition = addMethod(CellDefinition, ...
    "void Cell::Infect()", ...
    "Description", "clib.Model.Cell.Infect    Method of C++ class Cell."); % Modify help description values as needed.
validate(InfectDefinition);

%% C++ class method |clearNeighbours| for C++ class |Cell| 
% C++ Signature: void Cell::clearNeighbours()
clearNeighboursDefinition = addMethod(CellDefinition, ...
    "void Cell::clearNeighbours()", ...
    "Description", "clib.Model.Cell.clearNeighbours    Method of C++ class Cell."); % Modify help description values as needed.
validate(clearNeighboursDefinition);

%% C++ class method |OnBoundary| for C++ class |Cell| 
% C++ Signature: bool Cell::OnBoundary()
OnBoundaryDefinition = addMethod(CellDefinition, ...
    "bool Cell::OnBoundary()", ...
    "Description", "clib.Model.Cell.OnBoundary    Method of C++ class Cell."); % Modify help description values as needed.
defineOutput(OnBoundaryDefinition, "RetVal", "logical");
validate(OnBoundaryDefinition);

%% C++ class method |TooCrowded| for C++ class |Cell| 
% C++ Signature: bool Cell::TooCrowded()
TooCrowdedDefinition = addMethod(CellDefinition, ...
    "bool Cell::TooCrowded()", ...
    "Description", "clib.Model.Cell.TooCrowded    Method of C++ class Cell."); % Modify help description values as needed.
defineOutput(TooCrowdedDefinition, "RetVal", "logical");
validate(TooCrowdedDefinition);

%% C++ class method |DistanceSquaredTo| for C++ class |Cell| 
% C++ Signature: double Cell::DistanceSquaredTo(Cell * cell)
DistanceSquaredToDefinition = addMethod(CellDefinition, ...
   "double Cell::DistanceSquaredTo(Cell * cell)", ...
   "Description", "clib.Model.Cell.DistanceSquaredTo    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(DistanceSquaredToDefinition, "cell", "clib.Model.Cell", "input", 1); % '<MLTYPE>' can be clib.Model.Cell, or clib.array.Model.Cell
defineOutput(DistanceSquaredToDefinition, "RetVal", "double");
validate(DistanceSquaredToDefinition);

%% C++ class method |DistanceSquaredFromCentre| for C++ class |Cell| 
% C++ Signature: double Cell::DistanceSquaredFromCentre()
DistanceSquaredFromCentreDefinition = addMethod(CellDefinition, ...
    "double Cell::DistanceSquaredFromCentre()", ...
    "Description", "clib.Model.Cell.DistanceSquaredFromCentre    Method of C++ class Cell."); % Modify help description values as needed.
defineOutput(DistanceSquaredFromCentreDefinition, "RetVal", "double");
validate(DistanceSquaredFromCentreDefinition);

%% C++ class method |Necrotic| for C++ class |Cell| 
% C++ Signature: bool Cell::Necrotic(double distanceToBoundary,Params * parameters)
NecroticDefinition = addMethod(CellDefinition, ...
   "bool Cell::Necrotic(double distanceToBoundary,Params * parameters)", ...
   "Description", "clib.Model.Cell.Necrotic    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(NecroticDefinition, "distanceToBoundary", "double");
defineArgument(NecroticDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
defineOutput(NecroticDefinition, "RetVal", "logical");
validate(NecroticDefinition);

%% C++ class method |TooYoung| for C++ class |Cell| 
% C++ Signature: bool Cell::TooYoung(Params * parameters)
TooYoungDefinition = addMethod(CellDefinition, ...
   "bool Cell::TooYoung(Params * parameters)", ...
   "Description", "clib.Model.Cell.TooYoung    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(TooYoungDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
defineOutput(TooYoungDefinition, "RetVal", "logical");
validate(TooYoungDefinition);

%% C++ class method |LengthenSpring| for C++ class |Cell| 
% C++ Signature: void Cell::LengthenSpring(Params * parameters)
LengthenSpringDefinition = addMethod(CellDefinition, ...
   "void Cell::LengthenSpring(Params * parameters)", ...
   "Description", "clib.Model.Cell.LengthenSpring    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(LengthenSpringDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
validate(LengthenSpringDefinition);

%% C++ class method |DrugInducedDeath| for C++ class |Cell| 
% C++ Signature: bool Cell::DrugInducedDeath(Params * parameters,double * drugConcentration,int gridRadius)
DrugInducedDeathDefinition = addMethod(CellDefinition, ...
   "bool Cell::DrugInducedDeath(Params * parameters,double * drugConcentration,int gridRadius)", ...
   "Description", "clib.Model.Cell.DrugInducedDeath    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(DrugInducedDeathDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
defineArgument(DrugInducedDeathDefinition, "drugConcentration", "clib.array.Model.Double", "input", 1); % '<MLTYPE>' can be clib.array.Model.Double, or double
defineArgument(DrugInducedDeathDefinition, "gridRadius", "int32");
defineOutput(DrugInducedDeathDefinition, "RetVal", "logical");
validate(DrugInducedDeathDefinition);

%% C++ class method |Die| for C++ class |Cell| 
% C++ Signature: void Cell::Die()
DieDefinition = addMethod(CellDefinition, ...
    "void Cell::Die()", ...
    "Description", "clib.Model.Cell.Die    Method of C++ class Cell."); % Modify help description values as needed.
validate(DieDefinition);

%% C++ class method |Disintegrate| for C++ class |Cell| 
% C++ Signature: void Cell::Disintegrate()
DisintegrateDefinition = addMethod(CellDefinition, ...
    "void Cell::Disintegrate()", ...
    "Description", "clib.Model.Cell.Disintegrate    Method of C++ class Cell."); % Modify help description values as needed.
validate(DisintegrateDefinition);

%% C++ class method |PossiblyPSCInfectNeighbour| for C++ class |Cell| 
% C++ Signature: void Cell::PossiblyPSCInfectNeighbour(Params * parameters)
PossiblyPSCInfectNeighbourDefinition = addMethod(CellDefinition, ...
   "void Cell::PossiblyPSCInfectNeighbour(Params * parameters)", ...
   "Description", "clib.Model.Cell.PossiblyPSCInfectNeighbour    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(PossiblyPSCInfectNeighbourDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
validate(PossiblyPSCInfectNeighbourDefinition);

%% C++ class method |Move| for C++ class |Cell| 
% C++ Signature: void Cell::Move()
MoveDefinition = addMethod(CellDefinition, ...
    "void Cell::Move()", ...
    "Description", "clib.Model.Cell.Move    Method of C++ class Cell."); % Modify help description values as needed.
validate(MoveDefinition);

%% C++ class method |Proliferate| for C++ class |Cell| 
% C++ Signature: Cell * Cell::Proliferate(Params * parameters)
ProliferateDefinition = addMethod(CellDefinition, ...
   "Cell * Cell::Proliferate(Params * parameters)", ...
   "Description", "clib.Model.Cell.Proliferate    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(ProliferateDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
defineOutput(ProliferateDefinition, "RetVal", "clib.Model.Cell", 1);
validate(ProliferateDefinition);

%% C++ class public data member |currentState| for C++ class |Cell| 
% C++ Signature: CellState Cell::currentState
addProperty(CellDefinition, "currentState", "clib.Model.CellState", ...
    "Description", "clib.Model.CellState    Data member of C++ class Cell."); % Modify help description values as needed.

%% C++ class public data member |newState| for C++ class |Cell| 
% C++ Signature: CellState Cell::newState
addProperty(CellDefinition, "newState", "clib.Model.CellState", ...
    "Description", "clib.Model.CellState    Data member of C++ class Cell."); % Modify help description values as needed.

%% C++ class |Pancreas| with MATLAB name |clib.Model.Pancreas| 
PancreasDefinition = addClass(libDef, "Pancreas", "MATLABName", "clib.Model.Pancreas", ...
    "Description", "clib.Model.Pancreas    Representation of C++ class Pancreas."); % Modify help description values as needed.

%% C++ class method |CreateNewParticle| for C++ class |Pancreas| 
% C++ Signature: Pancreas * Pancreas::CreateNewParticle(Params * parameters)
CreateNewParticleDefinition = addMethod(PancreasDefinition, ...
   "Pancreas * Pancreas::CreateNewParticle(Params * parameters)", ...
   "Description", "clib.Model.Pancreas.CreateNewParticle    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(CreateNewParticleDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
defineOutput(CreateNewParticleDefinition, "RetVal", "clib.Model.Pancreas", 1);
validate(CreateNewParticleDefinition);

%% C++ class method |InjectPoint| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::InjectPoint(int x,int y,double amount)
InjectPointDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::InjectPoint(int x,int y,double amount)", ...
    "Description", "clib.Model.Pancreas.InjectPoint    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(InjectPointDefinition, "x", "int32");
defineArgument(InjectPointDefinition, "y", "int32");
defineArgument(InjectPointDefinition, "amount", "double");
validate(InjectPointDefinition);

%% C++ class method |InjectFibre| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::InjectFibre(int x,int y,double amount)
InjectFibreDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::InjectFibre(int x,int y,double amount)", ...
    "Description", "clib.Model.Pancreas.InjectFibre    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(InjectFibreDefinition, "x", "int32");
defineArgument(InjectFibreDefinition, "y", "int32");
defineArgument(InjectFibreDefinition, "amount", "double");
validate(InjectFibreDefinition);

%% C++ class method |LoadCellsCoordinates| for C++ class |Pancreas| 
% C++ Signature: double * Pancreas::LoadCellsCoordinates()
LoadCellsCoordinatesDefinition = addMethod(PancreasDefinition, ...
   "double * Pancreas::LoadCellsCoordinates()", ...
   "Description", "clib.Model.Pancreas.LoadCellsCoordinates    Method of C++ class Pancreas."); % Modify help description values as needed.
defineOutput(LoadCellsCoordinatesDefinition, "RetVal", "double", 1);
validate(LoadCellsCoordinatesDefinition);

%% C++ class method |DetermineNeighbours| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::DetermineNeighbours()
DetermineNeighboursDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::DetermineNeighbours()", ...
    "Description", "clib.Model.Pancreas.DetermineNeighbours    Method of C++ class Pancreas."); % Modify help description values as needed.
validate(DetermineNeighboursDefinition);

%% C++ class method |HealthyCellsBeyondRadius| for C++ class |Pancreas| 
% C++ Signature: bool Pancreas::HealthyCellsBeyondRadius(double radius)
HealthyCellsBeyondRadiusDefinition = addMethod(PancreasDefinition, ...
    "bool Pancreas::HealthyCellsBeyondRadius(double radius)", ...
    "Description", "clib.Model.Pancreas.HealthyCellsBeyondRadius    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(HealthyCellsBeyondRadiusDefinition, "radius", "double");
defineOutput(HealthyCellsBeyondRadiusDefinition, "RetVal", "logical");
validate(HealthyCellsBeyondRadiusDefinition);

%% C++ class method |AddNewCell| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::AddNewCell(Cell * new_cell)
AddNewCellDefinition = addMethod(PancreasDefinition, ...
   "void Pancreas::AddNewCell(Cell * new_cell)", ...
   "Description", "clib.Model.Pancreas.AddNewCell    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(AddNewCellDefinition, "new_cell", "clib.Model.Cell", "input", 1); % '<MLTYPE>' can be clib.Model.Cell, or clib.array.Model.Cell
validate(AddNewCellDefinition);

%% C++ class method |AddMoreTissue| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::AddMoreTissue(double moving_rim,double max_tumour_radius)
AddMoreTissueDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::AddMoreTissue(double moving_rim,double max_tumour_radius)", ...
    "Description", "clib.Model.Pancreas.AddMoreTissue    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(AddMoreTissueDefinition, "moving_rim", "double");
defineArgument(AddMoreTissueDefinition, "max_tumour_radius", "double");
validate(AddMoreTissueDefinition);

%% C++ class method |MoreTissueAddedIfNecessary| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::MoreTissueAddedIfNecessary()
MoreTissueAddedIfNecessaryDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::MoreTissueAddedIfNecessary()", ...
    "Description", "clib.Model.Pancreas.MoreTissueAddedIfNecessary    Method of C++ class Pancreas."); % Modify help description values as needed.
validate(MoreTissueAddedIfNecessaryDefinition);

%% C++ class method |DetermineBoundaryCells| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::DetermineBoundaryCells()
DetermineBoundaryCellsDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::DetermineBoundaryCells()", ...
    "Description", "clib.Model.Pancreas.DetermineBoundaryCells    Method of C++ class Pancreas."); % Modify help description values as needed.
validate(DetermineBoundaryCellsDefinition);

%% C++ class method |TumourRadius| for C++ class |Pancreas| 
% C++ Signature: double Pancreas::TumourRadius()
TumourRadiusDefinition = addMethod(PancreasDefinition, ...
    "double Pancreas::TumourRadius()", ...
    "Description", "clib.Model.Pancreas.TumourRadius    Method of C++ class Pancreas."); % Modify help description values as needed.
defineOutput(TumourRadiusDefinition, "RetVal", "double");
validate(TumourRadiusDefinition);

%% C++ class method |DistanceToLine| for C++ class |Pancreas| 
% C++ Signature: double Pancreas::DistanceToLine(Cell * cell)
DistanceToLineDefinition = addMethod(PancreasDefinition, ...
   "double Pancreas::DistanceToLine(Cell * cell)", ...
   "Description", "clib.Model.Pancreas.DistanceToLine    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(DistanceToLineDefinition, "cell", "clib.Model.Cell", "input", 1); % '<MLTYPE>' can be clib.Model.Cell, or clib.array.Model.Cell
defineOutput(DistanceToLineDefinition, "RetVal", "double");
validate(DistanceToLineDefinition);

%% C++ class method |TumourVolume| for C++ class |Pancreas| 
% C++ Signature: double Pancreas::TumourVolume()
TumourVolumeDefinition = addMethod(PancreasDefinition, ...
    "double Pancreas::TumourVolume()", ...
    "Description", "clib.Model.Pancreas.TumourVolume    Method of C++ class Pancreas."); % Modify help description values as needed.
defineOutput(TumourVolumeDefinition, "RetVal", "double");
validate(TumourVolumeDefinition);

%% C++ class method |getPscRatio| for C++ class |Pancreas| 
% C++ Signature: double Pancreas::getPscRatio()
getPscRatioDefinition = addMethod(PancreasDefinition, ...
    "double Pancreas::getPscRatio()", ...
    "Description", "clib.Model.Pancreas.getPscRatio    Method of C++ class Pancreas."); % Modify help description values as needed.
defineOutput(getPscRatioDefinition, "RetVal", "double");
validate(getPscRatioDefinition);

%% C++ class method |CreateInitialTumour| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::CreateInitialTumour()
CreateInitialTumourDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::CreateInitialTumour()", ...
    "Description", "clib.Model.Pancreas.CreateInitialTumour    Method of C++ class Pancreas."); % Modify help description values as needed.
validate(CreateInitialTumourDefinition);

%% C++ class method |SimulateOneHour| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::SimulateOneHour()
SimulateOneHourDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::SimulateOneHour()", ...
    "Description", "clib.Model.Pancreas.SimulateOneHour    Method of C++ class Pancreas."); % Modify help description values as needed.
validate(SimulateOneHourDefinition);

%% C++ class method |SimulateOneDay| for C++ class |Pancreas| 
% C++ Signature: double Pancreas::SimulateOneDay(int day)
SimulateOneDayDefinition = addMethod(PancreasDefinition, ...
    "double Pancreas::SimulateOneDay(int day)", ...
    "Description", "clib.Model.Pancreas.SimulateOneDay    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(SimulateOneDayDefinition, "day", "int32");
defineOutput(SimulateOneDayDefinition, "RetVal", "double");
validate(SimulateOneDayDefinition);

%% C++ class constructor for C++ class |Pancreas| 
% C++ Signature: Pancreas::Pancreas(Pancreas const & input1)
PancreasConstructor1Definition = addConstructor(PancreasDefinition, ...
    "Pancreas::Pancreas(Pancreas const & input1)", ...
    "Description", "clib.Model.Pancreas.Pancreas    Constructor of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(PancreasConstructor1Definition, "input1", "clib.Model.Pancreas", "input");
validate(PancreasConstructor1Definition);

%% C++ class public data member |fibreX| for C++ class |Pancreas| 
% C++ Signature: int Pancreas::fibreX
addProperty(PancreasDefinition, "fibreX", "int32", ...
    "Description", "int32    Data member of C++ class Pancreas."); % Modify help description values as needed.

%% C++ class public data member |fibreY| for C++ class |Pancreas| 
% C++ Signature: int Pancreas::fibreY
addProperty(PancreasDefinition, "fibreY", "int32", ...
    "Description", "int32    Data member of C++ class Pancreas."); % Modify help description values as needed.

%% C++ class public data member |injected| for C++ class |Pancreas| 
% C++ Signature: bool Pancreas::injected
addProperty(PancreasDefinition, "injected", "logical", ...
    "Description", "logical    Data member of C++ class Pancreas."); % Modify help description values as needed.

%% C++ class public data member |drugConcentration| for C++ class |Pancreas| 
% C++ Signature: double [14651] Pancreas::drugConcentration
addProperty(PancreasDefinition, "drugConcentration", "clib.array.Model.Double", [14651], ... % '<MLTYPE>' can be clib.array.Model.Double, or double
    "Description", "clib.array.Model.Double    Data member of C++ class Pancreas."); % Modify help description values as needed.

%% C++ class public data member |fibreConcentration| for C++ class |Pancreas| 
% C++ Signature: double * Pancreas::fibreConcentration
addProperty(PancreasDefinition, "fibreConcentration", "clib.array.Model.Double", 1, ... % '<MLTYPE>' can be clib.array.Model.Double, or double
   "Description", "clib.array.Model.Double    Data member of C++ class Pancreas."); % Modify help description values as needed.

%% C++ function |SeedAndGrowToStartVolume| with MATLAB name |clib.Model.SeedAndGrowToStartVolume|
% C++ Signature: Pancreas * SeedAndGrowToStartVolume(double p0,double psc,int dmax,int gage,int page,double startVolume)
SeedAndGrowToStartVolumeDefinition = addFunction(libDef, ...
   "Pancreas * SeedAndGrowToStartVolume(double p0,double psc,int dmax,int gage,int page,double startVolume)", ...
   "MATLABName", "clib.Model.SeedAndGrowToStartVolume", ...
   "Description", "clib.Model.SeedAndGrowToStartVolume    Representation of C++ function SeedAndGrowToStartVolume."); % Modify help description values as needed.
defineArgument(SeedAndGrowToStartVolumeDefinition, "p0", "double");
defineArgument(SeedAndGrowToStartVolumeDefinition, "psc", "double");
defineArgument(SeedAndGrowToStartVolumeDefinition, "dmax", "int32");
defineArgument(SeedAndGrowToStartVolumeDefinition, "gage", "int32");
defineArgument(SeedAndGrowToStartVolumeDefinition, "page", "int32");
defineArgument(SeedAndGrowToStartVolumeDefinition, "startVolume", "double");
defineOutput(SeedAndGrowToStartVolumeDefinition, "RetVal", "clib.Model.Pancreas", 1);
validate(SeedAndGrowToStartVolumeDefinition);

%% C++ function |SimulateWholeExperiment| with MATLAB name |clib.Model.SimulateWholeExperiment|
% C++ Signature: void SimulateWholeExperiment(double p0,double psc,int dmax,int gage,int page,double startVolume,int timeSteps,double [] volumes)
SimulateWholeExperimentDefinition = addFunction(libDef, ...
   "void SimulateWholeExperiment(double p0,double psc,int dmax,int gage,int page,double startVolume,int timeSteps,double [] volumes)", ...
   "MATLABName", "clib.Model.SimulateWholeExperiment", ...
   "Description", "clib.Model.SimulateWholeExperiment    Representation of C++ function SimulateWholeExperiment."); % Modify help description values as needed.
defineArgument(SimulateWholeExperimentDefinition, "p0", "double");
defineArgument(SimulateWholeExperimentDefinition, "psc", "double");
defineArgument(SimulateWholeExperimentDefinition, "dmax", "int32");
defineArgument(SimulateWholeExperimentDefinition, "gage", "int32");
defineArgument(SimulateWholeExperimentDefinition, "page", "int32");
defineArgument(SimulateWholeExperimentDefinition, "startVolume", "double");
defineArgument(SimulateWholeExperimentDefinition, "timeSteps", "int32");
defineArgument(SimulateWholeExperimentDefinition, "volumes", "clib.array.Model.Double", "input", 1); % '<MLTYPE>' can be clib.array.Model.Double, or double
validate(SimulateWholeExperimentDefinition);

%% C++ function |PerformMultipleRuns| with MATLAB name |clib.Model.PerformMultipleRuns|
% C++ Signature: void PerformMultipleRuns(double p0,double psc,int dmax,int gage,int page,double startVolume,int timeSteps,int iterations,double [] volumes)
PerformMultipleRunsDefinition = addFunction(libDef, ...
   "void PerformMultipleRuns(double p0,double psc,int dmax,int gage,int page,double startVolume,int timeSteps,int iterations,double [] volumes)", ...
   "MATLABName", "clib.Model.PerformMultipleRuns", ...
   "Description", "clib.Model.PerformMultipleRuns    Representation of C++ function PerformMultipleRuns."); % Modify help description values as needed.
defineArgument(PerformMultipleRunsDefinition, "p0", "double");
defineArgument(PerformMultipleRunsDefinition, "psc", "double");
defineArgument(PerformMultipleRunsDefinition, "dmax", "int32");
defineArgument(PerformMultipleRunsDefinition, "gage", "int32");
defineArgument(PerformMultipleRunsDefinition, "page", "int32");
defineArgument(PerformMultipleRunsDefinition, "startVolume", "double");
defineArgument(PerformMultipleRunsDefinition, "timeSteps", "int32");
defineArgument(PerformMultipleRunsDefinition, "iterations", "int32");
defineArgument(PerformMultipleRunsDefinition, "volumes", "clib.array.Model.Double", "input", 1); % '<MLTYPE>' can be clib.array.Model.Double, or double
validate(PerformMultipleRunsDefinition);

%% Validate the library definition
validate(libDef);

end
