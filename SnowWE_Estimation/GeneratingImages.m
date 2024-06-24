function GeneratingImages(SWE, Dates, R, info, ResultIndAll, destinationFolder, KNN, ErrorMean, ErrorSTD)
%% Inputs:
% SWE: Cell array containing SWE images.
% Dates: Array of dates corresponding to the SWE images.
% R: Spatial referencing object used for geospatial mapping of images.
% info: Metadata from a GeoTIFF file, used for saving new TIFF files with the same georeferencing.
% ResultIndAll: Matrix with ranked learning dates for each query date.
% destinationFolder: Folder path for saving the generated TIFF binary Snow Water Equivalent (SWE) images.
% KNN: Number of selected images for averaging to generate each output image.

%%

% Extract the first KNN columns from ResultIndAll for processing
ResultInd2 = ResultIndAll(:, 1:KNN);

A = []; % Initialize an empty array to store selected SWE images.
B = {}; % Cell array to store the averaged images.

% Loop over each row in ResultInd2
for i = 1:size(ResultInd2, 1)
    for j = 2:KNN
        % Check if the date in ResultInd2 matches any in the Dates array and get the index
        [tf1, idx2] = ismember(ResultInd2(i, j), Dates);
        % Store the corresponding SWE image into A
        A(:, :, j-1) = SWE{idx2, 1};
    end

    % Compute the mean across the third dimension (images) and store in B
    B{i, 1} = mean(A, 3);

    % Create output file name based on the first date in ResultInd2 and the mean errors
    outputBaseName = string(ResultInd2(i, 1)) + '_ErrorSTD' + round(mean(ErrorSTD(i, 2:KNN), 'all'), 2) + '_ErrorMean' + round(mean(ErrorMean(i, 2:KNN), 'all'), 2) + '.tif';
    fullDestinationFileName = fullfile(destinationFolder, outputBaseName);

    % Write the averaged image as a GeoTIFF file
    geotiffwrite(fullDestinationFileName, B{i, 1}, R, 'GeoKeyDirectoryTag', info.GeoTIFFTags.GeoKeyDirectoryTag);
end
end
