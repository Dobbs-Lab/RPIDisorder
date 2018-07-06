# RPIDisorder
### Current version: v1.0.0
### WEBSERVER COMING SOON!

### If you already have R, (optionally) RStudio, and Weka v3.8 installed, you can jump to [here](https://github.com/Dobbs-Lab/RPIDisorder#run-rpidisorder-locally) to get started running RPIDisorder locally; otherwise, please follow the steps here: [Installing Software Dependencies](https:/github.com/Dobbsh-Lab/RPIDisorder#A-installing-software-dependencies)

## *******************************************************
# [Table of Contents]
## [0. Citing RPIDisorder]()
## [A. Installing Software Dependencies](https:/github.com/Dobbsh-Lab/RPIDisorder#A-installing-software-dependencies)
## [B. Running the RPIDisorder Pipeline](https:/github.com/Dobbsh-Lab/RPIDisorder#B-running-the-rpidisorder-pipeline)
## [C. Interpreting Results](https:/github.com/Dobbsh-Lab/RPIDisorder#C-interpreting results)
## [D. Troubleshooting](https:/github.com/Dobbsh-Lab/RPIDisorder#D-troubleshooting)
## ********************************************************


# [A. Installing Software Dependencies](#A-installing-software-dependencies)
## Contents:
## [1. Download and Install R](https:/github.com/Dobbsh-Lab/RPIDisorder#1-download-and-install-r)
## [2. Download and Install RStudio (optional)](https:/github.com/Dobbsh-Lab/RPIDisorder#2-download-and-install-rstudio-optional)
## [3. Download and Install Weka v3.8](https:/github.com/Dobbsh-Lab/RPIDisorder#3-download-and-install-weka)
## [4. Download and Setup RPIDisorder Pipeline](https:/github.com/Dobbsh-Lab/RPIDisorder#4-download-and-setup-rpidisorder)
## [5. Download and Install DISOPRED3 (optional*)](https:/github.com/Dobbsh-Lab/RPIDisorder#5-download-and-install-disopred3)
## [6. Download and Install NCBI's BLAST v2.2.26 (ONLY required if you run DISOPRED3 locally)](https:/github.com/Dobbsh-Lab/RPIDisorder#6-download-and-install-ncbi-blast)

* If you are not doing a largescale analysis using many proteins, we highly recommend that you use the DISOPRED3 webserver to obtain your disorder prediction results; installing DISOPRED3 can be difficult depending on your operating system and your familiarity with compiling software from source, and also requires the installation of Legacy BLAST. 


## [1. Download and Install R](#1-download-and-install-r)
RPIDisorder requires the latest version of R in order to run offline. 

Download R for your appropriate operating system:

Windows: https://mirror.las.iastate.edu/CRAN/bin/windows/

 You should select the "base" option, or click "install R for the first time".
 

Mac OS: https://mirror.las.iastate.edu/CRAN/bin/macosx/

 Scroll down to the "Files" section, and find the R pkg file that lists your operating system (El Capitan, Mavericks, Snow Leopard, etc). Select the R-3.x.x.pkg file corresponding to your system - pay special attention to the "Important" section under R-3.4.3.pkg if you have "El Capitan"; you may want to consider using R-3.3.3.pkg if you don't want to install additional tools to support running R 3.4.3 on "El Capitan".


Linux/Unix: https://mirror.las.iastate.edu/CRAN/bin/linux/

 Find your Unix distro, and folow the instructions in the directory.
 

Once you have downloaded the R installer, run it to install R. You may be required to enter administrator credentials; if you do not have these credentials, talk to your institution's IT department to have them install the software.


If you need additional help installing R, please check the installation instructions for your operating system:

Windows:    https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Installing-R-under-Windows

Mac OS:     https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Installing-R-under-macOS

Linux/Unix: https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Installing-R-under-Unix_002dalikes


## [2. Download and Install RStudio](#2-download-and-install-rstudio-optional) (optional)
RPIDisorder does not require the use of the RStudio development environment, but running the RPIDisorder code in the RStudio environment is highly recommended.

You can download RStudio for free here: https://www.rstudio.com/products/rstudio/download/#download

After downloading the RStudio installer, follow the installation instructions.


## [3. Download and Install Weka v3.8](#3-download-and-install-weka)
RPIDisorder requires the Weka (Waikato Environment for Knowledge Analysis) machine learning platform. Weka was created and is maintained by Waikato University in New Zealand. RPIDisorder was created using Weka v3.8, which is the latest stable version. Weka v3.9 is currently under development; we do not recommend using v3.9 with RPIDisorder.

Weka v3.8 is available for download here: https://www.cs.waikato.ac.nz/ml/weka/downloading.html

Scroll down to the appropriate system, download the software, and follow the installation instructions.
(If you do not have Java installed, choose the Weka v3.8 download for your system that includes the Java VM.


## [4. Download and Setup the RPIDisorder Pipeline](#4-download-and-setup-rpidisorder)
Steps: 
1. Download RPIDisorder from GitHub
2. Unzip RPIDisorder-master
3. Unzip rpidisorder.zip

1. Download RPIDisorder from GitHub
From this page, choose "Clone or Download", then choose "Download ZIP". This will download a zipped file called "RPIDisorder-master.zip" to your computer. 

2. Unzip RPIDisorder-master 
You can move the "RPIDisorder-master" zip file to a directory of your choice, then unzip the file. 

You will then find a directory containing four files and two folders. The README contains these instructions for setting up RPIDisorder. The license file contains the terms for using this software. The 'pipeline.R' file contains instructions for generating an input file for Weka from your input protein sequence, RNA sequence, and protein disorder file. The 'necesssaryFunctions.R' file contains functions which must be in your R global environment in order for the 'pipeline.R' scripts to function.

3. Unzip rpidisorder.zip
Select the 'rpidisorder.zip' file and unzip it. The folder 'rpidisorder' contains a file called 'rpidisorder.model', which is the model file containing the RPIDisorder random forest classifier, formatted for use with Weka.

4. 





## [5. Download and Install DISOPRED3](#5-download-and-install-disopred3)
We would like to again reiterate that we strongly recommend using the DISOPRED3 webserver to obtain predictions. It can be difficult to install and configure the necessary dependencies to run DISOPRED locally. If, however, you are doing a large scale analysis on many proteins, it will likely be necessary for you to utilize the offline version of DISOPRED3. 

DISOPRED3 can be downloaded here: http://bioinfadmin.cs.ucl.ac.uk/downloads/DISOPRED/
Follow the installation instructions in the DISOPRED3.16 'README' file. If you have questions or problems installing DISOPRED3, please contact the University College London Group through their website.


## [6. Download and Install NCBI BLAST v2.2.26](#6-download-and-install-ncbi-blast)
You DO NOT need to install NCBI BLAST UNLESS you are running DISOPRED3 locally.

Running DISOPRED3 locally requires an installation of NCBI BLAST v2.2.26, which is available here: ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.26/

NCBI BLAST v2.2.26 requires a sequence database; RPIDisorder was created using the SwissProtDB:
ftp://ftp.ebi.ac.uk/pub/databases/uniprot/knowledgebase/uniprot_sprot.fasta.gz



# [B. Running the RPIDisorder Pipeline](#B-running-the-rpidisorder-pipeline)
## 
Data Folders
The files in the 'data' folder are required for proper functioning of an R script below, 
BUT are NOT part of the datasets used in model creation.

The 'Datasets' folder contains datasets used in the training and testing of the RPIDisorder model; they are NOT required for proper functioning of the tool.

RPIDisorder requires predicted disorder information from DISOPRED (specifically, DISOPRED3), a disorder predictor created and hosted by the University College London Department of Computer Science Bioinformatics Group. You can predict disorder
for a single sequence using their online server here: http://bioinf.cs.ucl.ac.uk/psipred/?disopred=1




Running RPIDisorder Locally:

Currently, RPIDisorder utilizes R statistical software to process input protein and RNA sequences, in addition to a DISOPRED3 disorder file for the input protein, to generate a feature vector for the input protein and RNA pair. The R script will turn this feature vector into an .arff (Attribute-Relation File Format) file, which is then fed into the WEKA machine learning platform.

Software Dependencies:
The WEKA machine learning platform is required. 
Download here: http://www.cs.waikato.ac.nz/ml/weka/downloading.html

You will also require the latest version of R, available here: https://www.r-project.org/
It is recommended, but not required, that you use the RStudio integrated development environment for R (Desktop version), which is available here:https://www.rstudio.com/products/rstudio/download/

In the near future, we will be adding better integration of DISOPRED3 predictions into this pipeline, 
and will implement the ability to make predictions without opening WEKA at all.
The R scripts and systems included here will be made available in package form for easier use and installation.

In order to predict whether a protein will bind an RNA using RPIDisorder, open 'R' and enter
all functions in 'necessaryFunctions.R' into the R environment.
Then follow the instructions in 'pipeline.R' to generate an ARFF file.

