clear ; clc; close all;
%% setting up paths
pathProject  = pwd;
if pathProject(end) ~= filesep % make sure there is a '/' at end of directory
    pathProject = [pathProject filesep];
end
irtdir=[pathProject,'lib',filesep,'irt',filesep];
try run([irtdir,'setup.m'])
catch,error('NUFFT Path not set correctly'); end

% Adaptive PPD: Dabbech et al. 2018
pathLibAPPD=[pathProject,'src',filesep];
addpath(genpath(pathLibAPPD));

% PPD: Onose et al 2016
pathLibSARA = [pathProject,'lib',filesep, 'SARA-PPD-master',filesep];
addpath(genpath(pathLibSARA));

%W-correction: dabbech et al 2017
pathWCorrection = [pathProject,'lib',filesep,'wproj_utilities',filesep];
addpath(pathWCorrection);

% DATA dir.
pathData = [pathProject,'data',filesep];

% Results dir.
pathResults = [pathProject,'imaging_results',filesep];
try mkdir(pathResults) 
end
%% param struct
param_global.pathData = pathData; %data path
param_global.pathResults = pathResults; %results path 

param_global.Nx = 512; %image dim.
param_global.Ny = 512; %image dim.

param_global.pixelSize = 2.5; % 'in arcsec'
param_global.ObsFreq = 4536E6;% freq in 'Hz'

param_global.visibilityFileName = '3c391_I00' ;
param_global.flag_is_weightsFixed2sigma = 0; % 'weights' in the data file corresponds to SIGMA.

%solver
param_global.l1_reg = 1e-4;% soft-thresholding param. of SARA
param_global.max_iter = 100000;
param_global.rel_obj = 1e-6; 

param_global.flag_adaptive_l2bounds =0 ; % no adaptive epsilon if noise statistics are known (always the case for sims)

param_global.sizeDataBlk = 100000; % not compulsory: set data block sizes in the solver


%% run Adaptive PPD
main_imaging_real_data(param_global);


