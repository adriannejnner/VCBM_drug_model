%% About defineADDMULT.mlx
% This file defines the MATLAB interface to the library |ADDMULT|.
%
% Commented sections represent C++ functionality that MATLAB cannot automatically define. To include
% functionality, uncomment a section and provide values for &lt;SHAPE&gt;, &lt;DIRECTION&gt;, etc. For more
% information, see <matlab:helpview(fullfile(docroot,'matlab','helptargets.map'),'cpp_define_interface') Define MATLAB Interface for C++ Library>.



%% Setup. Do not edit this section.
function libDef = defineADDMULT()
libDef = clibgen.LibraryDefinition("ADDMULTData.xml");
%% OutputFolder and Libraries 
libDef.OutputFolder = "C:\Users\jenner2\OneDrive - Queensland University of Technology\Documents\GitHub\TumourCSharp\MatlabCodes_Adrianne";
libDef.Libraries = "";

%% C++ function |added| with MATLAB name |clib.ADDMULT.added|
% C++ Signature: double added(double in1,double in2)
addedDefinition = addFunction(libDef, ...
    "double added(double in1,double in2)", ...
    "MATLABName", "clib.ADDMULT.added", ...
    "Description", "clib.ADDMULT.added    Representation of C++ function added."); % Modify help description values as needed.
defineArgument(addedDefinition, "in1", "double");
defineArgument(addedDefinition, "in2", "double");
defineOutput(addedDefinition, "RetVal", "double");
validate(addedDefinition);

%% Validate the library definition
validate(libDef);

end
