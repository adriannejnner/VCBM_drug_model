% rootdir = 'C:\Users\jenner2\OneDrive - Queensland University of Technology\Documents\GitHub';
% 
% headerFile = fullfile(rootdir,"TumourCSharp","MatlabCodes_Adrianne","cryptopp_wrapper.h");
% sourceFile = fullfile(rootdir,"TumourCSharp","MatlabCodes_Adrianne","cryptopp_wrapper.cpp");
% iPath = fullfile(rootdir,"TumourCSharp","MatlabCodes_Adrianne");
% 
% clibgen.generateLibraryDefinition(headerFile,...
%     "SupportingSourceFiles",sourceFile,...
%     "IncludePath", iPath,...
%     "PackageName","matrixOps");
% 
% build(definematrixOps)


rootdir = 'C:\Users\jenner2\OneDrive - Queensland University of Technology\Documents\GitHub';

headerFile = fullfile(rootdir,"TumourCSharp","MatlabCodes_Adrianne","added.h");
sourceFile = fullfile(rootdir,"TumourCSharp","MatlabCodes_Adrianne","added.cpp");
iPath = fullfile(rootdir,"TumourCSharp","MatlabCodes_Adrianne");

clibgen.generateLibraryDefinition(headerFile,...
    "SupportingSourceFiles",sourceFile,...
    "IncludePath", iPath,...
    "PackageName","ADDMULT");

build(defineADDMULT)

addpath('ADDMULT')
dirLoc = fullfile(rootdir,'TumourCSharp','MatlabCodes_Adrianne');
path = getenv('PATH');
setenv('PATH', [dirLoc ';' path]);

import clib.ADDMULT.*

added(1,200)