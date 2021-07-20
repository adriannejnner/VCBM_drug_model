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
libDef.OutputFolder = "C:\Users\adria\GBM_oHSV1_app\GBM_oHSV1_app\VCBM_drug_model\TumourModelSingleInjectionCPP";
libDef.Libraries = "";

%% C++ function type |void(*)(double, double)| with MATLAB name |clib.type.Model.Function1| 
addFunctionType(libDef, "void(*)(double, double)", "MATLABName", "clib.type.Model.Function1", ...
    "Description", "clib.type.Model.Function1    C++ function type mwCppAnonymousTypes::Function1."); % Modify help description values as needed.

%% C++ function type |void(*)(CellType)| with MATLAB name |clib.type.Model.Function2| 
addFunctionType(libDef, "void(*)(CellType)", "MATLABName", "clib.type.Model.Function2", ...
    "Description", "clib.type.Model.Function2    C++ function type mwCppAnonymousTypes::Function2."); % Modify help description values as needed.

%% C++ function type |void(*)()| with MATLAB name |clib.type.Model.Function3| 
addFunctionType(libDef, "void(*)()", "MATLABName", "clib.type.Model.Function3", ...
    "Description", "clib.type.Model.Function3    C++ function type mwCppAnonymousTypes::Function3."); % Modify help description values as needed.

%% C++ function type |void(*)(Cell *, Cell *)| with MATLAB name |clib.type.Model.Function4| 
addFunctionType(libDef, "void(*)(Cell *, Cell *)", "MATLABName", "clib.type.Model.Function4", ...
    "Description", "clib.type.Model.Function4    C++ function type mwCppAnonymousTypes::Function4."); % Modify help description values as needed.

%% C++ enumeration |CellType| with MATLAB name |clib.Model.CellType| 
addEnumeration(libDef, "CellType", "int32",...
    [...
      "Cancer",...  % 1
      "Dead",...  % 3
      "Healthy",...  % 4
      "PSC",...  % 5
      "Empty",...  % 6
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
    "Description", "clib.Model.CellState    Constructor of C++ class CellState."); % Modify help description values as needed.
validate(CellStateConstructor1Definition);

%% C++ class constructor for C++ class |CellState| 
% C++ Signature: CellState::CellState(CellState const & input1)
CellStateConstructor2Definition = addConstructor(CellStateDefinition, ...
    "CellState::CellState(CellState const & input1)", ...
    "Description", "clib.Model.CellState    Constructor of C++ class CellState."); % Modify help description values as needed.
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
% C++ Signature: Params::Params(double p_0,double p_psc,double dmax,int gage,int page,double EC50)
ParamsConstructor1Definition = addConstructor(ParamsDefinition, ...
    "Params::Params(double p_0,double p_psc,double dmax,int gage,int page,double EC50)", ...
    "Description", "clib.Model.Params    Constructor of C++ class Params."); % Modify help description values as needed.
defineArgument(ParamsConstructor1Definition, "p_0", "double");
defineArgument(ParamsConstructor1Definition, "p_psc", "double");
defineArgument(ParamsConstructor1Definition, "dmax", "double");
defineArgument(ParamsConstructor1Definition, "gage", "int32");
defineArgument(ParamsConstructor1Definition, "page", "int32");
defineArgument(ParamsConstructor1Definition, "EC50", "double");
validate(ParamsConstructor1Definition);

%% C++ class method |RandomDouble| for C++ class |Params| 
% C++ Signature: double Params::RandomDouble()
RandomDoubleDefinition = addMethod(ParamsDefinition, ...
    "double Params::RandomDouble()", ...
    "MATLABName", "RandomDouble", ...
    "Description", "RandomDouble    Method of C++ class Params."); % Modify help description values as needed.
defineOutput(RandomDoubleDefinition, "RetVal", "double");
validate(RandomDoubleDefinition);

%% C++ class method |WithProbability| for C++ class |Params| 
% C++ Signature: bool Params::WithProbability(double prob)
WithProbabilityDefinition = addMethod(ParamsDefinition, ...
    "bool Params::WithProbability(double prob)", ...
    "MATLABName", "WithProbability", ...
    "Description", "WithProbability    Method of C++ class Params."); % Modify help description values as needed.
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

%% C++ class public data member |EC50| for C++ class |Params| 
% C++ Signature: double Params::EC50
addProperty(ParamsDefinition, "EC50", "double", ...
    "Description", "double    Data member of C++ class Params."); % Modify help description values as needed.

%% C++ class |Cell| with MATLAB name |clib.Model.Cell| 
CellDefinition = addClass(libDef, "Cell", "MATLABName", "clib.Model.Cell", ...
    "Description", "clib.Model.Cell    Representation of C++ class Cell."); % Modify help description values as needed.

%% C++ class constructor for C++ class |Cell| 
% C++ Signature: Cell::Cell(double X,double Y,double spring_length,Cell * sibling,CellType type,int age)
CellConstructor1Definition = addConstructor(CellDefinition, ...
   "Cell::Cell(double X,double Y,double spring_length,Cell * sibling,CellType type,int age)", ...
   "Description", "clib.Model.Cell    Constructor of C++ class Cell."); % Modify help description values as needed.
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
   "Description", "clib.Model.Cell    Constructor of C++ class Cell."); % Modify help description values as needed.
defineArgument(CellConstructor2Definition, "cell", "clib.Model.Cell", "input", 1); % '<MLTYPE>' can be clib.Model.Cell, or clib.array.Model.Cell
validate(CellConstructor2Definition);

%% C++ class method |Renew| for C++ class |Cell| 
% C++ Signature: void Cell::Renew()
RenewDefinition = addMethod(CellDefinition, ...
    "void Cell::Renew()", ...
    "MATLABName", "Renew", ...
    "Description", "Renew    Method of C++ class Cell."); % Modify help description values as needed.
validate(RenewDefinition);

%% C++ class method |UpdateState| for C++ class |Cell| 
% C++ Signature: void Cell::UpdateState()
UpdateStateDefinition = addMethod(CellDefinition, ...
    "void Cell::UpdateState()", ...
    "MATLABName", "UpdateState", ...
    "Description", "UpdateState    Method of C++ class Cell."); % Modify help description values as needed.
validate(UpdateStateDefinition);

%% C++ class method |Infect| for C++ class |Cell| 
% C++ Signature: void Cell::Infect()
InfectDefinition = addMethod(CellDefinition, ...
    "void Cell::Infect()", ...
    "MATLABName", "Infect", ...
    "Description", "Infect    Method of C++ class Cell."); % Modify help description values as needed.
validate(InfectDefinition);

%% C++ class method |clearNeighbours| for C++ class |Cell| 
% C++ Signature: void Cell::clearNeighbours()
clearNeighboursDefinition = addMethod(CellDefinition, ...
    "void Cell::clearNeighbours()", ...
    "MATLABName", "clearNeighbours", ...
    "Description", "clearNeighbours    Method of C++ class Cell."); % Modify help description values as needed.
validate(clearNeighboursDefinition);

%% C++ class method |OnBoundary| for C++ class |Cell| 
% C++ Signature: bool Cell::OnBoundary()
OnBoundaryDefinition = addMethod(CellDefinition, ...
    "bool Cell::OnBoundary()", ...
    "MATLABName", "OnBoundary", ...
    "Description", "OnBoundary    Method of C++ class Cell."); % Modify help description values as needed.
defineOutput(OnBoundaryDefinition, "RetVal", "logical");
validate(OnBoundaryDefinition);

%% C++ class method |TooCrowded| for C++ class |Cell| 
% C++ Signature: bool Cell::TooCrowded()
TooCrowdedDefinition = addMethod(CellDefinition, ...
    "bool Cell::TooCrowded()", ...
    "MATLABName", "TooCrowded", ...
    "Description", "TooCrowded    Method of C++ class Cell."); % Modify help description values as needed.
defineOutput(TooCrowdedDefinition, "RetVal", "logical");
validate(TooCrowdedDefinition);

%% C++ class method |DistanceSquaredTo| for C++ class |Cell| 
% C++ Signature: double Cell::DistanceSquaredTo(Cell * cell)
DistanceSquaredToDefinition = addMethod(CellDefinition, ...
   "double Cell::DistanceSquaredTo(Cell * cell)", ...
   "MATLABName", "DistanceSquaredTo", ...
   "Description", "DistanceSquaredTo    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(DistanceSquaredToDefinition, "cell", "clib.Model.Cell", "input", 1); % '<MLTYPE>' can be clib.Model.Cell, or clib.array.Model.Cell
defineOutput(DistanceSquaredToDefinition, "RetVal", "double");
validate(DistanceSquaredToDefinition);

%% C++ class method |DistanceSquaredFromCentre| for C++ class |Cell| 
% C++ Signature: double Cell::DistanceSquaredFromCentre()
DistanceSquaredFromCentreDefinition = addMethod(CellDefinition, ...
    "double Cell::DistanceSquaredFromCentre()", ...
    "MATLABName", "DistanceSquaredFromCentre", ...
    "Description", "DistanceSquaredFromCentre    Method of C++ class Cell."); % Modify help description values as needed.
defineOutput(DistanceSquaredFromCentreDefinition, "RetVal", "double");
validate(DistanceSquaredFromCentreDefinition);

%% C++ class method |Necrotic| for C++ class |Cell| 
% C++ Signature: bool Cell::Necrotic(double distanceToBoundary,Params * parameters)
NecroticDefinition = addMethod(CellDefinition, ...
   "bool Cell::Necrotic(double distanceToBoundary,Params * parameters)", ...
   "MATLABName", "Necrotic", ...
   "Description", "Necrotic    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(NecroticDefinition, "distanceToBoundary", "double");
defineArgument(NecroticDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
defineOutput(NecroticDefinition, "RetVal", "logical");
validate(NecroticDefinition);

%% C++ class method |TooYoung| for C++ class |Cell| 
% C++ Signature: bool Cell::TooYoung(Params * parameters)
TooYoungDefinition = addMethod(CellDefinition, ...
   "bool Cell::TooYoung(Params * parameters)", ...
   "MATLABName", "TooYoung", ...
   "Description", "TooYoung    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(TooYoungDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
defineOutput(TooYoungDefinition, "RetVal", "logical");
validate(TooYoungDefinition);

%% C++ class method |LengthenSpring| for C++ class |Cell| 
% C++ Signature: void Cell::LengthenSpring(Params * parameters)
LengthenSpringDefinition = addMethod(CellDefinition, ...
   "void Cell::LengthenSpring(Params * parameters)", ...
   "MATLABName", "LengthenSpring", ...
   "Description", "LengthenSpring    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(LengthenSpringDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
validate(LengthenSpringDefinition);

%% C++ class method |DrugInducedDeath| for C++ class |Cell| 
% C++ Signature: bool Cell::DrugInducedDeath(Params * parameters,double * drugConcentration,int gridRadius)
DrugInducedDeathDefinition = addMethod(CellDefinition, ...
   "bool Cell::DrugInducedDeath(Params * parameters,double * drugConcentration,int gridRadius)", ...
   "MATLABName", "DrugInducedDeath", ...
   "Description", "DrugInducedDeath    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(DrugInducedDeathDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
defineArgument(DrugInducedDeathDefinition, "drugConcentration", "clib.array.Model.Double", "input", 1); % '<MLTYPE>' can be clib.array.Model.Double, or double
defineArgument(DrugInducedDeathDefinition, "gridRadius", "int32");
defineOutput(DrugInducedDeathDefinition, "RetVal", "logical");
validate(DrugInducedDeathDefinition);

%% C++ class method |Die| for C++ class |Cell| 
% C++ Signature: void Cell::Die()
DieDefinition = addMethod(CellDefinition, ...
    "void Cell::Die()", ...
    "MATLABName", "Die", ...
    "Description", "Die    Method of C++ class Cell."); % Modify help description values as needed.
validate(DieDefinition);

%% C++ class method |PossiblyPSCInfectNeighbour| for C++ class |Cell| 
% C++ Signature: void Cell::PossiblyPSCInfectNeighbour(Params * parameters)
PossiblyPSCInfectNeighbourDefinition = addMethod(CellDefinition, ...
   "void Cell::PossiblyPSCInfectNeighbour(Params * parameters)", ...
   "MATLABName", "PossiblyPSCInfectNeighbour", ...
   "Description", "PossiblyPSCInfectNeighbour    Method of C++ class Cell."); % Modify help description values as needed.
defineArgument(PossiblyPSCInfectNeighbourDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
validate(PossiblyPSCInfectNeighbourDefinition);

%% C++ class method |Move| for C++ class |Cell| 
% C++ Signature: void Cell::Move()
MoveDefinition = addMethod(CellDefinition, ...
    "void Cell::Move()", ...
    "MATLABName", "Move", ...
    "Description", "Move    Method of C++ class Cell."); % Modify help description values as needed.
validate(MoveDefinition);

%% C++ class method |Disintegrate| for C++ class |Cell| 
% C++ Signature: void Cell::Disintegrate()
DisintegrateDefinition = addMethod(CellDefinition, ...
    "void Cell::Disintegrate()", ...
    "MATLABName", "Disintegrate", ...
    "Description", "Disintegrate    Method of C++ class Cell."); % Modify help description values as needed.
validate(DisintegrateDefinition);

%% C++ class method |Proliferate| for C++ class |Cell| 
% C++ Signature: Cell * Cell::Proliferate(Params * parameters)
ProliferateDefinition = addMethod(CellDefinition, ...
   "Cell * Cell::Proliferate(Params * parameters)", ...
   "MATLABName", "Proliferate", ...
   "Description", "Proliferate    Method of C++ class Cell."); % Modify help description values as needed.
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
   "MATLABName", "CreateNewParticle", ...
   "Description", "CreateNewParticle    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(CreateNewParticleDefinition, "parameters", "clib.Model.Params", "input", 1); % '<MLTYPE>' can be clib.Model.Params, or clib.array.Model.Params
defineOutput(CreateNewParticleDefinition, "RetVal", "clib.Model.Pancreas", 1);
validate(CreateNewParticleDefinition);

%% C++ class method |InjectDrug| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::InjectDrug(int x,int y,double amount)
InjectDrugDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::InjectDrug(int x,int y,double amount)", ...
    "MATLABName", "InjectDrug", ...
    "Description", "InjectDrug    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(InjectDrugDefinition, "x", "int32");
defineArgument(InjectDrugDefinition, "y", "int32");
defineArgument(InjectDrugDefinition, "amount", "double");
validate(InjectDrugDefinition);

%% C++ class method |LoadCellsCoordinates| for C++ class |Pancreas| 
% C++ Signature: double * Pancreas::LoadCellsCoordinates()
LoadCellsCoordinatesDefinition = addMethod(PancreasDefinition, ...
   "double * Pancreas::LoadCellsCoordinates()", ...
   "MATLABName", "LoadCellsCoordinates", ...
   "Description", "LoadCellsCoordinates    Method of C++ class Pancreas."); % Modify help description values as needed.
defineOutput(LoadCellsCoordinatesDefinition, "RetVal", "double", 1);
validate(LoadCellsCoordinatesDefinition);

%% C++ class method |circumCentre42| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::circumCentre42(double a0,double a1,double b0,double b1,double c0,double c1,void(*vertex)(double, double))
circumCentre42Definition = addMethod(PancreasDefinition, ...
    "void Pancreas::circumCentre42(double a0,double a1,double b0,double b1,double c0,double c1,void(*vertex)(double, double))", ...
    "MATLABName", "circumCentre42", ...
    "Description", "circumCentre42    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(circumCentre42Definition, "a0", "double");
defineArgument(circumCentre42Definition, "a1", "double");
defineArgument(circumCentre42Definition, "b0", "double");
defineArgument(circumCentre42Definition, "b1", "double");
defineArgument(circumCentre42Definition, "c0", "double");
defineArgument(circumCentre42Definition, "c1", "double");
defineArgument(circumCentre42Definition, "vertex", "clib.type.Model.Function1");
validate(circumCentre42Definition);

%% C++ class method |circumCentre| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::circumCentre(double a0,double a1,double b0,double b1,double c0,double c1,void(*vertex)(double, double))
circumCentreDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::circumCentre(double a0,double a1,double b0,double b1,double c0,double c1,void(*vertex)(double, double))", ...
    "MATLABName", "circumCentre", ...
    "Description", "circumCentre    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(circumCentreDefinition, "a0", "double");
defineArgument(circumCentreDefinition, "a1", "double");
defineArgument(circumCentreDefinition, "b0", "double");
defineArgument(circumCentreDefinition, "b1", "double");
defineArgument(circumCentreDefinition, "c0", "double");
defineArgument(circumCentreDefinition, "c1", "double");
defineArgument(circumCentreDefinition, "vertex", "clib.type.Model.Function1");
validate(circumCentreDefinition);

%% C++ class method |EnumerateVoronoiCells| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::EnumerateVoronoiCells(void(*startCell)(CellType),void(*vertex)(double, double),void(*endCell)())
EnumerateVoronoiCellsDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::EnumerateVoronoiCells(void(*startCell)(CellType),void(*vertex)(double, double),void(*endCell)())", ...
    "MATLABName", "EnumerateVoronoiCells", ...
    "Description", "EnumerateVoronoiCells    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(EnumerateVoronoiCellsDefinition, "startCell", "clib.type.Model.Function2");
defineArgument(EnumerateVoronoiCellsDefinition, "vertex", "clib.type.Model.Function1");
defineArgument(EnumerateVoronoiCellsDefinition, "endCell", "clib.type.Model.Function3");
validate(EnumerateVoronoiCellsDefinition);

%% C++ class method |EnumerateNeighbours| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::EnumerateNeighbours(void(*line)(Cell *, Cell *))
EnumerateNeighboursDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::EnumerateNeighbours(void(*line)(Cell *, Cell *))", ...
    "MATLABName", "EnumerateNeighbours", ...
    "Description", "EnumerateNeighbours    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(EnumerateNeighboursDefinition, "line", "clib.type.Model.Function4");
validate(EnumerateNeighboursDefinition);

%% C++ class method |DetermineNeighbours| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::DetermineNeighbours()
DetermineNeighboursDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::DetermineNeighbours()", ...
    "MATLABName", "DetermineNeighbours", ...
    "Description", "DetermineNeighbours    Method of C++ class Pancreas."); % Modify help description values as needed.
validate(DetermineNeighboursDefinition);

%% C++ class method |HealthyCellsBeyondRadius| for C++ class |Pancreas| 
% C++ Signature: bool Pancreas::HealthyCellsBeyondRadius(double radius)
HealthyCellsBeyondRadiusDefinition = addMethod(PancreasDefinition, ...
    "bool Pancreas::HealthyCellsBeyondRadius(double radius)", ...
    "MATLABName", "HealthyCellsBeyondRadius", ...
    "Description", "HealthyCellsBeyondRadius    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(HealthyCellsBeyondRadiusDefinition, "radius", "double");
defineOutput(HealthyCellsBeyondRadiusDefinition, "RetVal", "logical");
validate(HealthyCellsBeyondRadiusDefinition);

%% C++ class method |AddNewCell| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::AddNewCell(Cell * new_cell)
AddNewCellDefinition = addMethod(PancreasDefinition, ...
   "void Pancreas::AddNewCell(Cell * new_cell)", ...
   "MATLABName", "AddNewCell", ...
   "Description", "AddNewCell    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(AddNewCellDefinition, "new_cell", "clib.Model.Cell", "input", 1); % '<MLTYPE>' can be clib.Model.Cell, or clib.array.Model.Cell
validate(AddNewCellDefinition);

%% C++ class method |AddMoreTissue| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::AddMoreTissue(double moving_rim,double max_tumour_radius)
AddMoreTissueDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::AddMoreTissue(double moving_rim,double max_tumour_radius)", ...
    "MATLABName", "AddMoreTissue", ...
    "Description", "AddMoreTissue    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(AddMoreTissueDefinition, "moving_rim", "double");
defineArgument(AddMoreTissueDefinition, "max_tumour_radius", "double");
validate(AddMoreTissueDefinition);

%% C++ class method |MoreTissueAddedIfNecessary| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::MoreTissueAddedIfNecessary()
MoreTissueAddedIfNecessaryDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::MoreTissueAddedIfNecessary()", ...
    "MATLABName", "MoreTissueAddedIfNecessary", ...
    "Description", "MoreTissueAddedIfNecessary    Method of C++ class Pancreas."); % Modify help description values as needed.
validate(MoreTissueAddedIfNecessaryDefinition);

%% C++ class method |DetermineBoundaryCells| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::DetermineBoundaryCells()
DetermineBoundaryCellsDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::DetermineBoundaryCells()", ...
    "MATLABName", "DetermineBoundaryCells", ...
    "Description", "DetermineBoundaryCells    Method of C++ class Pancreas."); % Modify help description values as needed.
validate(DetermineBoundaryCellsDefinition);

%% C++ class method |TumourRadius| for C++ class |Pancreas| 
% C++ Signature: double Pancreas::TumourRadius()
TumourRadiusDefinition = addMethod(PancreasDefinition, ...
    "double Pancreas::TumourRadius()", ...
    "MATLABName", "TumourRadius", ...
    "Description", "TumourRadius    Method of C++ class Pancreas."); % Modify help description values as needed.
defineOutput(TumourRadiusDefinition, "RetVal", "double");
validate(TumourRadiusDefinition);

%% C++ class method |DistanceToLine| for C++ class |Pancreas| 
% C++ Signature: double Pancreas::DistanceToLine(Cell * cell)
DistanceToLineDefinition = addMethod(PancreasDefinition, ...
   "double Pancreas::DistanceToLine(Cell * cell)", ...
   "MATLABName", "DistanceToLine", ...
   "Description", "DistanceToLine    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(DistanceToLineDefinition, "cell", "clib.Model.Cell", "input", 1); % '<MLTYPE>' can be clib.Model.Cell, or clib.array.Model.Cell
defineOutput(DistanceToLineDefinition, "RetVal", "double");
validate(DistanceToLineDefinition);

%% C++ class method |TumourVolume| for C++ class |Pancreas| 
% C++ Signature: double Pancreas::TumourVolume()
TumourVolumeDefinition = addMethod(PancreasDefinition, ...
    "double Pancreas::TumourVolume()", ...
    "MATLABName", "TumourVolume", ...
    "Description", "TumourVolume    Method of C++ class Pancreas."); % Modify help description values as needed.
defineOutput(TumourVolumeDefinition, "RetVal", "double");
validate(TumourVolumeDefinition);

%% C++ class method |getPscRatio| for C++ class |Pancreas| 
% C++ Signature: double Pancreas::getPscRatio()
getPscRatioDefinition = addMethod(PancreasDefinition, ...
    "double Pancreas::getPscRatio()", ...
    "MATLABName", "getPscRatio", ...
    "Description", "getPscRatio    Method of C++ class Pancreas."); % Modify help description values as needed.
defineOutput(getPscRatioDefinition, "RetVal", "double");
validate(getPscRatioDefinition);

%% C++ class method |CreateInitialTumour| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::CreateInitialTumour()
CreateInitialTumourDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::CreateInitialTumour()", ...
    "MATLABName", "CreateInitialTumour", ...
    "Description", "CreateInitialTumour    Method of C++ class Pancreas."); % Modify help description values as needed.
validate(CreateInitialTumourDefinition);

%% C++ class method |SimulateOneHour| for C++ class |Pancreas| 
% C++ Signature: void Pancreas::SimulateOneHour()
SimulateOneHourDefinition = addMethod(PancreasDefinition, ...
    "void Pancreas::SimulateOneHour()", ...
    "MATLABName", "SimulateOneHour", ...
    "Description", "SimulateOneHour    Method of C++ class Pancreas."); % Modify help description values as needed.
validate(SimulateOneHourDefinition);

%% C++ class method |SimulateOneDay| for C++ class |Pancreas| 
% C++ Signature: double Pancreas::SimulateOneDay(int day)
SimulateOneDayDefinition = addMethod(PancreasDefinition, ...
    "double Pancreas::SimulateOneDay(int day)", ...
    "MATLABName", "SimulateOneDay", ...
    "Description", "SimulateOneDay    Method of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(SimulateOneDayDefinition, "day", "int32");
defineOutput(SimulateOneDayDefinition, "RetVal", "double");
validate(SimulateOneDayDefinition);

%% C++ class constructor for C++ class |Pancreas| 
% C++ Signature: Pancreas::Pancreas(Pancreas const & input1)
PancreasConstructor1Definition = addConstructor(PancreasDefinition, ...
    "Pancreas::Pancreas(Pancreas const & input1)", ...
    "Description", "clib.Model.Pancreas    Constructor of C++ class Pancreas."); % Modify help description values as needed.
defineArgument(PancreasConstructor1Definition, "input1", "clib.Model.Pancreas", "input");
validate(PancreasConstructor1Definition);

%% C++ class public data member |drugConcentration| for C++ class |Pancreas| 
% C++ Signature: double [14641] Pancreas::drugConcentration
addProperty(PancreasDefinition, "drugConcentration", "clib.array.Model.Double", [14641], ... % '<MLTYPE>' can be clib.array.Model.Double, or double
    "Description", "clib.array.Model.Double    Data member of C++ class Pancreas."); % Modify help description values as needed.

%% C++ function |SeedAndGrowToStartVolume| with MATLAB name |clib.Model.SeedAndGrowToStartVolume|
% C++ Signature: Pancreas * SeedAndGrowToStartVolume(double p0,double psc,int dmax,int gage,int page,double EC50,double startVolume)
SeedAndGrowToStartVolumeDefinition = addFunction(libDef, ...
   "Pancreas * SeedAndGrowToStartVolume(double p0,double psc,int dmax,int gage,int page,double EC50,double startVolume)", ...
   "MATLABName", "clib.Model.SeedAndGrowToStartVolume", ...
   "Description", "clib.Model.SeedAndGrowToStartVolume    Representation of C++ function SeedAndGrowToStartVolume."); % Modify help description values as needed.
defineArgument(SeedAndGrowToStartVolumeDefinition, "p0", "double");
defineArgument(SeedAndGrowToStartVolumeDefinition, "psc", "double");
defineArgument(SeedAndGrowToStartVolumeDefinition, "dmax", "int32");
defineArgument(SeedAndGrowToStartVolumeDefinition, "gage", "int32");
defineArgument(SeedAndGrowToStartVolumeDefinition, "page", "int32");
defineArgument(SeedAndGrowToStartVolumeDefinition, "EC50", "double");
defineArgument(SeedAndGrowToStartVolumeDefinition, "startVolume", "double");
defineOutput(SeedAndGrowToStartVolumeDefinition, "RetVal", "clib.Model.Pancreas", 1);
validate(SeedAndGrowToStartVolumeDefinition);

%% C++ function |SimulateWholeExperiment| with MATLAB name |clib.Model.SimulateWholeExperiment|
% C++ Signature: void SimulateWholeExperiment(double p0,double psc,int dmax,int gage,int page,double EC50,double startVolume,int timeSteps,double [] volumes)
SimulateWholeExperimentDefinition = addFunction(libDef, ...
   "void SimulateWholeExperiment(double p0,double psc,int dmax,int gage,int page,double EC50,double startVolume,int timeSteps,double [] volumes)", ...
   "MATLABName", "clib.Model.SimulateWholeExperiment", ...
   "Description", "clib.Model.SimulateWholeExperiment    Representation of C++ function SimulateWholeExperiment."); % Modify help description values as needed.
defineArgument(SimulateWholeExperimentDefinition, "p0", "double");
defineArgument(SimulateWholeExperimentDefinition, "psc", "double");
defineArgument(SimulateWholeExperimentDefinition, "dmax", "int32");
defineArgument(SimulateWholeExperimentDefinition, "gage", "int32");
defineArgument(SimulateWholeExperimentDefinition, "page", "int32");
defineArgument(SimulateWholeExperimentDefinition, "EC50", "double");
defineArgument(SimulateWholeExperimentDefinition, "startVolume", "double");
defineArgument(SimulateWholeExperimentDefinition, "timeSteps", "int32");
defineArgument(SimulateWholeExperimentDefinition, "volumes", "clib.array.Model.Double", "input", 1); % '<MLTYPE>' can be clib.array.Model.Double, or double
validate(SimulateWholeExperimentDefinition);

%% C++ function |PerformMultipleRuns| with MATLAB name |clib.Model.PerformMultipleRuns|
% C++ Signature: void PerformMultipleRuns(double p0,double psc,int dmax,int gage,int page,double EC50,double startVolume,int timeSteps,int iterations,double [] volumes)
PerformMultipleRunsDefinition = addFunction(libDef, ...
   "void PerformMultipleRuns(double p0,double psc,int dmax,int gage,int page,double EC50,double startVolume,int timeSteps,int iterations,double [] volumes)", ...
   "MATLABName", "clib.Model.PerformMultipleRuns", ...
   "Description", "clib.Model.PerformMultipleRuns    Representation of C++ function PerformMultipleRuns."); % Modify help description values as needed.
defineArgument(PerformMultipleRunsDefinition, "p0", "double");
defineArgument(PerformMultipleRunsDefinition, "psc", "double");
defineArgument(PerformMultipleRunsDefinition, "dmax", "int32");
defineArgument(PerformMultipleRunsDefinition, "gage", "int32");
defineArgument(PerformMultipleRunsDefinition, "page", "int32");
defineArgument(PerformMultipleRunsDefinition, "EC50", "double");
defineArgument(PerformMultipleRunsDefinition, "startVolume", "double");
defineArgument(PerformMultipleRunsDefinition, "timeSteps", "int32");
defineArgument(PerformMultipleRunsDefinition, "iterations", "int32");
defineArgument(PerformMultipleRunsDefinition, "volumes", "clib.array.Model.Double", "input", 1); % '<MLTYPE>' can be clib.array.Model.Double, or double
validate(PerformMultipleRunsDefinition);

%% C++ function |CreateNewParticle| with MATLAB name |clib.Model.CreateNewParticle|
% C++ Signature: Pancreas * CreateNewParticle(double p0,double psc,int dmax,int gage,int page,double EC50,Pancreas * pancreas)
CreateNewParticleDefinition = addFunction(libDef, ...
   "Pancreas * CreateNewParticle(double p0,double psc,int dmax,int gage,int page,double EC50,Pancreas * pancreas)", ...
   "MATLABName", "clib.Model.CreateNewParticle", ...
   "Description", "clib.Model.CreateNewParticle    Representation of C++ function CreateNewParticle."); % Modify help description values as needed.
defineArgument(CreateNewParticleDefinition, "p0", "double");
defineArgument(CreateNewParticleDefinition, "psc", "double");
defineArgument(CreateNewParticleDefinition, "dmax", "int32");
defineArgument(CreateNewParticleDefinition, "gage", "int32");
defineArgument(CreateNewParticleDefinition, "page", "int32");
defineArgument(CreateNewParticleDefinition, "EC50", "double");
defineArgument(CreateNewParticleDefinition, "pancreas", "clib.Model.Pancreas", "input", 1); % '<MLTYPE>' can be clib.Model.Pancreas, or clib.array.Model.Pancreas
defineOutput(CreateNewParticleDefinition, "RetVal", "clib.Model.Pancreas", 1);
validate(CreateNewParticleDefinition);

%% Validate the library definition
validate(libDef);

end
