%% Demo
% This is a demo to show how you are able to use the codes

%% Clearing Workspace
clc                          % Clears the Command Window, removing all previous outputs.
clear                        % Deletes all variables from the workspace, freeing up system memory.
close all                    % Closes all figures (windows) that are currently open.

%% Reading the data needed for ranking learning dates using "KNNSnowGeneration" Function
% Replace '.' with the actual path to your directory
QueryDates=load('./Data/QueryDates.mat');  % Loads data from the file 'QueryDates.mat' into a structure.
QueryDates=QueryDates.QueryDates;  % Extracts the 'QueryDates' table from the structure.
LearningDates=load('./Data/LearningDates.mat'); % Loads data from 'LearningDates.mat' into a structure.
LearningDates=LearningDates.LearningDates; % Extracts the 'LearningDates' table from the structure.
Weights=load('./Data/BayesResultXAtMinObjective.mat'); % Loads data from 'BayesResultXAtMinObjective.mat' into a structure.
Weights=Weights.BayesResultXAtMinObjective;     % Extracts the weights table from the structure.

%% The function for Ranking the learning dates
clc                          % Clears the Command Window again.
% Replace '.' with the actual path to your directory
[ResultIndAll,ErrorSTD,ErrorMean]=KNNSnowGeneration(QueryDates,LearningDates,Weights); % Calls 'KNNSnowGeneration' with loaded data to rank learning dates.
save('./Output/ResultIndAll.mat','ResultIndAll'); % Saves the ranked learning dates to a file.
save('./Output/ErrorSTD.mat','ErrorSTD');         % Saves the standard deviation of errors to a file.
save('./Output/ErrorMean.mat','ErrorMean');       % Saves the mean of errors to a file.

%% Loading additional data
% Replace '.' with the actual path to your directory
SWE = load('./Data/SWE.mat');                   % Loads data from 'SWE.mat'.
SWE=SWE.SWE;                             % Extracts the SWE data.
SWEIndex = load('./Data/SWEIndex.mat');         % Loads data from 'SWEIndex.mat'.
SWEIndex=SWEIndex.SWEIndex;              % Extracts the SWE Index data.
ResultIndAll=load('./Output/ResultIndAll.mat');   % Loads the previously saved ranked learning dates.
ResultIndAll=ResultIndAll.ResultIndAll;  % Extracts the ranked learning dates data.
ErrorSTD=load('./Output/ErrorSTD.mat');   % Loads the previously saved ErrorSTD.
ErrorSTD=ErrorSTD.ErrorSTD;  % Extracts the ErrorSTD data.
ErrorMean=load('./Output/ErrorMean.mat');   % Loads the previously saved ErrorMean.
ErrorMean=ErrorMean.ErrorMean;  % Extracts the ErrorMean data.
destinationFolder = './OutputAll';       % Defines a destination folder for saving output files.

%% Clearing Command Window
clc                                      % Clears the Command Window one more time.

%% Setting up reference matrix for geospatial data
% Replace '.' with the actual path to your directory
info=geotiffinfo('./Data/RasterCal.tif');       % Retrieves metadata from a GeoTIFF file.

R = makerefmat('RasterSize', [225 225], ...% Creates a reference matrix specifying the raster size and geographic limits.
               'LatitudeLimits', [38.00007 39.00007], ...
               'LongitudeLimits', [-120.00022 -118.99922], ...
               'ColumnsStartFrom', 'north', ...
               'RowsStartFrom', 'west');


%% The function for Generation Snow Water Equivalent (SWE) images
GeneratingImages(SWE,SWEIndex,R,info,ResultIndAll,destinationFolder,130,ErrorMean,ErrorSTD); % Generates images for Snow Water Equivalent using the provided data.
