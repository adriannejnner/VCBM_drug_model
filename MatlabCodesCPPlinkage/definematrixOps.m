%% About definematrixOps.mlx
% This file defines the MATLAB interface to the library |matrixOps|.
%
% Commented sections represent C++ functionality that MATLAB cannot automatically define. To include
% functionality, uncomment a section and provide values for &lt;SHAPE&gt;, &lt;DIRECTION&gt;, etc. For more
% information, see <matlab:helpview(fullfile(docroot,'matlab','helptargets.map'),'cpp_define_interface') Define MATLAB Interface for C++ Library>.



%% Setup. Do not edit this section.
function libDef = definematrixOps()
libDef = clibgen.LibraryDefinition("matrixOpsData.xml");
%% OutputFolder and Libraries 
libDef.OutputFolder = "C:\Users\jenner2\OneDrive - Queensland University of Technology\Documents\GitHub\TumourCSharp\MatlabCodes_Adrianne";
libDef.Libraries = "";

%% C++ function |main| with MATLAB name |clib.matrixOps.main|
% C++ Signature: int main()
mainDefinition = addFunction(libDef, ...
    "int main()", ...
    "MATLABName", "clib.matrixOps.main", ...
    "Description", "clib.matrixOps.main    Representation of C++ function main."); % Modify help description values as needed.
defineOutput(mainDefinition, "RetVal", "int32");
validate(mainDefinition);

%% Validate the library definition
validate(libDef);

end
