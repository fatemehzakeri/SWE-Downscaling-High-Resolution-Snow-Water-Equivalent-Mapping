function [ResultIndAll,ErrorSTD,ErrorMean]=KNNSnowGeneration(QueryDates,LearningDates,Weights)
% KNN Daily 500 m Snow Water Equivalent (SWE) Generation is composed of a main function named KNNSnowGeneration.mat for ranking learning dates based on their closeness.
% It also provides the average of the similarity metric over the candidates (a scalar),
% and the standard deviation of the similarity metric over the candidates (a scalar).
% KNNSnowGeneration needs two main imports and one optional import.
% 
% The first import in the function is a table named QueryDates (needed).
% The columns of the QueryDates table include short and long climate temporal-neighborhoods of temperature min/max precipitation,
%, and surface downwelling shortwave radiation, and low resolution SWE. Each row represents a Query Date. 
% 
% The second import in the function is a table named LearningDates (needed).
% The columns of the LearningDates table are similar to those of QueryDates but represent Learning Dates.
% 
% The optional import in the function is a table named Weights.
% The columns of the Weights table include weights for various climate metrics.

% Initialize an empty matrix to hold the ranking results
ResultInd=zeros(size(QueryDates,1), size(LearningDates,1) + 1);

% Convert QueryDates and LearningDates tables to arrays excluding the first column
A=table2array(QueryDates(:,2:end));
B=table2array(LearningDates(:,2:end));

% Check if the Weights table is prod
if exist('Weights','var')
    % Extract weights from the Weights table
    wCloseAggreTmax=Weights.wCloseAggreTmax; % Tmax Short Temporal-neighborhood Weights;
    wCloseAggreTmin=Weights.wCloseAggreTmin; % Tmin Short Temporal-neighborhood Weights;
    wCloseAggreP=Weights.wCloseAggreP;       % Precipitation Short Temporal-neighborhood Weights;
    wCloseAggreRsds=Weights.wCloseAggreRsds; % RSDS Short Temporal-neighborhood Weights;
    wTmax=Weights.wTmax;                     % Tmax Long Temporal-neighborhood Weights;
    wTmin=Weights.wTmin;                     % Tmin Long Temporal-neighborhood Weights;
    wP=Weights.wP;                           % Precipitation Long Temporal-neighborhood Weights;
    wRsds=Weights.wRsds;                     % RSDS Long Temporal-neighborhood Weights;
    wSWE=Weights.wSWE;                       % Low Resolution SWE Weights;
else
    % Default weights to 1 if not provided
    wCloseAggreTmax=1; wCloseAggreTmin=1; wCloseAggreP=1; wCloseAggreRsds=1;
    wTmax=1; wTmin=1; wP=1; wRsds=1; wSWE=1;
end

% Create a weights matrix
AllW=zeros(size(LearningDates,1), size(LearningDates,2)-1);
% Populate the weights matrix with appropriate values
AllW(:,209:4:237)=wCloseAggreTmax;
AllW(:,210:4:238)=wCloseAggreTmin;
AllW(:,211:4:239)=wCloseAggreP;
AllW(:,212:4:240)=wCloseAggreRsds;
AllW(:,1:4:205)=wTmax;
AllW(:,2:4:206)=wTmin;
AllW(:,3:4:207)=wP;
AllW(:,4:4:208)=wRsds;
AllW(:,241)=wSWE;

% Normalize weights
SumWeights=sum(AllW(1,:));
AllW=AllW./SumWeights;

% Initialize error matrices
ErrorMean=zeros(size(QueryDates,1), size(LearningDates,1) + 1);
ErrorSTD=zeros(size(QueryDates,1), size(LearningDates,1) + 1);

% Parallel for loop to process each query date
parfor i=1:size(A,1)
    A11=A(i,:);
    % Compute differences and apply absolute function
    D=cellfun(@minus, B, repmat(A11, [size(B,1), 1]), 'un', 0);
    A2=cellfun(@abs,D,'UniformOutput',false);
    % Compute mean of absolute differences
    A3=cellfun(@(x) nanmean(x,'all'),A2,'UniformOutput',false);
    A4=[A3{:}];
    A4=reshape(A4, size(A3,1), size(A3,2));
    A5_mean=sum(A4,2,'omitnan');
    % Weighted sum of differences
    A4=A4.*AllW;
    A5=sum(A4,2,'omitnan');
    % Compute standard deviation
    A3_1=cellfun(@(x) std(x,0,'all','omitnan'),A2,'UniformOutput',false);
    A4_1=[A3_1{:}];
    A4_1=reshape(A4_1, size(A3_1,1), size(A3_1,2));
    A5_STD=sum(A4_1,2,'omitnan');
    A4_1=A4_1.*AllW;
    A5_1=sum(A4_1,2,'omitnan');
    % Sort based on the weighted sum of differences
    [~,I] = sort(A5);

    % Store the ranked dates and errors
    ResultInd(i, :) = [QueryDates.Dates(i), (LearningDates.Dates(I))'];
    ErrorSTD(i, :) = [QueryDates.Dates(i), (A5_STD(I))'];
    ErrorMean(i, :) = [QueryDates.Dates(i), (A5_mean(I))'];
end
ResultIndAll=ResultInd;

end
