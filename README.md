# SWE-Downscaling-High-Resolution-Snow-Water-Equivalent-Mapping

## Project Description
This project develops a method for estimating high-resolution daily Snow Water Equivalent (SWE) in mountainous regions—a challenge due to complex geographical factors and sparse meteorological data. Utilizing a K-nearest neighbors algorithm with a tailored distance metric, the scripts provide downscaled SWE predictions at 500m resolution. These scripts support a broader study detailed in an associated paper, which investigates the statistical relationships between meteorological estimators and SWE.

## Repository Structure
The repository is organized in a tree structure, showing folders and files essential for the project's operation. Each item listed is either a file or a directory, with directories potentially housing multiple files or subdirectories. Below is an outline of the repository's architecture:

```
/SnowWE_Estimation             # Main project folder
  |-- Demo.m                   # Script demonstrating the complete workflow
  |-- KNNSnowGeneration.m      # Function for ranking learning dates
  |-- GeneratingImages.m       # Function for generating SWE images
  /Data/                       # Contains all necessary data files
    |-- [Link to Download QueryDates.mat](#)  # Link to download QueryDates.mat
    |-- [Link to Download LearningDates.mat](#)  # Link to download LearningDates.mat
    |-- BayesResultXAtMinObjective.mat  # MAT file with algorithm weights
    |-- SWE.mat                # MAT file with Snow Water Equivalent data
    |-- SWEIndex.mat           # MAT file indexing the SWE data
    |-- RasterCal.tif          # GeoTIFF file with geospatial data
  /Output/                     # Directory for output files
    |-- ResultIndAll.mat       # Output file with ranked learning dates results
    |-- ErrorSTD.mat           # Output file detailing standard deviation of errors
    |-- ErrorMean.mat          # Output file detailing mean of errors
    |-- [Link to download OutputAll/](#)  # Link to a subdirectory with generated SWE images
```

## Using the Repository

### Downloading
- Initially, download the `/SnowWE_Estimation`, `/Data`, and `/Output` directories to your local machine or development environment. Note: Some files require accessing Google Drive links provided.

### Installation and Setup
- Ensure MATLAB is installed as the project scripts are MATLAB functions (.m files).
- Place any additional required data files into the `Data/` directory following the script dependencies.

### Executing Scripts
- Open MATLAB and navigate to the `/SnowWE_Estimation` directory.
- Execute `Demo.m` to view a demonstration of data processing and output generation. This script will call other scripts and functions sequentially.
- Explore `KNNSnowGeneration.m` and `GeneratingImages.m` to understand data ranking and image generation functionalities.

### Checking Outputs
- After script execution, examine the `Output/` and `OutputAll/` directories for generated results, including matrices and images.
- Review `ResultIndAll.mat`, `ErrorSTD.mat`, and `ErrorMean.mat` to analyze the numerical results and error assessments.

## Acknowledgments
- This research is a collaborative effort between Fatemeh Zakeri and Gregoire Mariethoz at the University of Lausanne, and Manuela Girotto at the University of California, Berkeley. For detailed methodology and scientific background, refer to the included PDF document.
```
