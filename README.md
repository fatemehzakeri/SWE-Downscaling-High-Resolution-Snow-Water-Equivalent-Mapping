# SWE-Downscaling-High-Resolution-Snow-Water-Equivalent-Mapping
#### Project Description
This project implements a method for estimating high-resolution daily Snow Water Equivalent (SWE) in mountainous regions, which is challenging due to complex geographical factors and sparse meteorological data. The scripts use a K-nearest neighbors algorithm with a custom distance metric to estimate downscaled SWE at a 500m resolution. These scripts are part of a broader study detailed in the paper, which explores the statistical relationship between meteorological estimators and SWE.

### Understanding the Repository Structure

The structure is outlined in a tree format, showing folders (directories) and files. Each item is either a file or a folder, where folders may contain multiple files or subfolders. Here’s what each part represents:

```
/SnowWE_Estimation             # Main project folder
|-- Demo.m                     # Script demonstrating the full workflow
|-- KNNSnowGeneration.m        # Function to rank learning dates
|-- GeneratingImages.m         # Function to generate SWE images
|-- Data/                      # Directory containing all necessary data files
    |-- QueryDates.mat         # MAT file with query dates data
    |-- LearningDates.mat      # MAT file with learning dates data
    |-- BayesResultXAtMinObjective.mat  # MAT file with weights for the algorithm
    |-- SWE.mat                # MAT file containing Snow Water Equivalent data
    |-- SWEIndex.mat           # MAT file with index for the SWE data
    |-- RasterCal.tif          # GeoTIFF file containing geospatial data
|-- Output/                    # Directory for storing output files
    |-- ResultIndAll.mat       # Output file with results of learning date ranking
    |-- ErrorSTD.mat           # Output file with standard deviation of errors
    |-- ErrorMean.mat          # Output file with mean of errors
    |-- OutputAll/             # Subdirectory for additional output files
```

### Using the Repository Structure

1. **Cloning or Downloading:**
   - To start working with the project, you should clone or download the entire `/SnowWE_Estimation` directory to your local machine or development environment.

2. **Installation and Setup:**
   - Make sure that you have MATLAB installed, as the scripts are MATLAB functions (.m files).
   - Place any additional required data files into the `Data/` directory according to the dependencies mentioned in the script files.

3. **Executing Scripts:**
   - Open MATLAB and navigate to the `/SnowWE_Estimation` directory.
   - Run `Demo.m` to see a demonstration of how data is processed and how outputs are generated. This script will sequentially call other scripts and functions as needed.
   - Explore `KNNSnowGeneration.m` and `GeneratingImages.m` to understand the specific functionalities related to data ranking and image generation.

4. **Checking Outputs:**
   - After running the scripts, check the `Output/` and `OutputAll/` directories for results like matrices and images.
   - Review the `ResultIndAll.mat`, `ErrorSTD.mat`, and `ErrorMean.mat` for numerical results and error analyses.

5. **Modifying and Contributing:**
   - If you plan to contribute to the project or customize the scripts, understanding the repository structure is crucial. Add your scripts or modify existing ones and maintain the structure for consistency.
   - If new types of data files are introduced, update the `Data/` directory accordingly and document the changes in the README.

This structured approach not only keeps your project organized but also makes it easier for other users or contributors to understand how to set up and interact with your project. Make sure to keep this structure updated in your README if you make changes to the directory organization or add new files.

#### Acknowledgments
- This script is based on research conducted by Fatemeh Zakeri at the University of Lausanne and Manuela Girotto at the University of California, Berkeley. For detailed methodology and scientific background, refer to the included PDF document.

This README provides a clear guide for using and understanding the code within the context of high-resolution SWE estimation. Adjustments or extensions can be made as needed to fit the project's future developments or user contributions.
