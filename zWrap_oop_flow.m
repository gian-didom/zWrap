% This will be the app flow.
addpath(genpath('classes'));
addpath(genpath('functions'));
addpath(genpath('boards/zedboard'));

path_to_folder = "/Users/gianfry/Documents/DLR/zWrap/test/VMyfVoJrTg_fun/predictMixed051";

mySettings = ZSettings(sprintf("-path %s -pack -y", path_to_folder)); 
myBoard = ZBoard();   % This should a) Download the necessary files/pull the requested stuff from the server, b) create the board object

%% The old flow:
% - Parse arguments
% - Check dependencies (of board!)
% - Load project information (buildInfo, codeInfo, compileInfo)
% - Pack all the code, including headers
% - [Simulink] Remove the "main" functions
% - Generate input and output interface structure
% - [Optional] Verify input and output size with gcc
% - [Optional] Apply extensions (I/O extensions)
% - Generate project folder
% - Generate input and output serializing/deserializing functions //TODO: Evaluate protobuf encoding?
% - [Optional] Apply extensions (codegen extensions)
% - Generate board build (customize BSP folder structure to the project)
% - Generate Simulink library
% - Run makefiles for code [BUILD interface+function application]
% - Run board tests

% In functional terms:

myProject = ZProject(mySettings);
myProject.load();
myProject.pack();
myProject.processInput();
myProject.processOutput();
myProject.generateProjectFolder();
myProject.generateInputSerializer();
myProject.generateOutputParser();

% Initialize board object
myBoard = ZedBoard();
myBoard.setProject(myProject);
myBoard.build();