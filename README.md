v1.0.0
For datasets used during these experiments, check the 'Datasets' folder.
The files in the 'data' folder are required for proper functioning of an R script below, 
and are not part of the datasets used in experiments.

RPIDisorder requires predicted disorder information from DISOPRED. You can predict disorder
for a single sequence using the online server here: http://bioinf.cs.ucl.ac.uk/psipred/?disopred=1
Or you can download and install the offline version here: http://bioinfadmin.cs.ucl.ac.uk/downloads/DISOPRED/

The WEKA machine learning platform is required. Download here: http://www.cs.waikato.ac.nz/ml/weka/downloading.html
You will also require the latest version of R: https://www.r-project.org/

In the near future, we will be adding better integration of DISOPRED predictions into this pipeline, 
and will implement the ability to make predictions without opening WEKA at all.
The R scripts and systems included here will be made available in package form for easier use and installation.

In order to predict whether a protein will bind an RNA using RPIDisorder, open 'R' and enter
all functions in 'necessaryFunctions.R' into the R environment.
Then follow the instructions in 'pipeline.R' to generate an ARFF file.

