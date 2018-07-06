# RPIDisorder
### Current version: v1.0.0
### WEBSERVER AND COMMAND LINE VERSIONS COMING SOON!

### If you already have R, (optionally) RStudio, and Weka v3.8 installed, you can jump to [here](https://github.com/Dobbs-Lab/RPIDisorder#run-rpidisorder-locally) to get started running RPIDisorder locally; otherwise, please follow the steps here: [Installing Software Dependencies](https:/github.com/Dobbsh-Lab/RPIDisorder#A-installing-software-dependencies)

## *******************************************************
# Table of Contents
## [0. Citing RPIDisorder](https:/github.com/Dobbsh-Lab/RPIDisorder#0-citing-rpidisorder)
## [A. Installing Software Dependencies](https:/github.com/Dobbsh-Lab/RPIDisorder#A-installing-software-dependencies)
## [B. Running the RPIDisorder Pipeline](https:/github.com/Dobbsh-Lab/RPIDisorder#B-running-the-rpidisorder-pipeline)
## [C. Interpreting Results](https:/github.com/Dobbsh-Lab/RPIDisorder#C-interpreting results)
## [D. Troubleshooting](https:/github.com/Dobbsh-Lab/RPIDisorder#D-troubleshooting)
## ********************************************************

# [0. Citing RPIDisorder](#0-citing-rpidisorder)

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

The files in the 'data' folder are required for proper functioning of an R script below, BUT are NOT part of the datasets used in model creation. The 'Datasets' folder contains datasets used in the training and testing of the RPIDisorder model; they are NOT required for proper functioning of the tool.

3. Unzip rpidisorder.zip
Select the 'rpidisorder.zip' file and unzip it. The folder 'rpidisorder' contains a file called 'rpidisorder.model', which is the model file containing the RPIDisorder random forest classifier, formatted for use with Weka. (This is zipped and compressed due to GitHub's limitations on file size uploads.)


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
## Contents:
## [1. Obtain Disorder Input File](https:/github.com/Dobbsh-Lab/RPIDisorder#1-obtaining-diso-input)
## [2. Generate .arff file for Protein-RNA Pair](https:/github.com/Dobbsh-Lab/RPIDisorder#2-generate-arff)
## [3. Predict on .arff File in Weka](https:/github.com/Dobbsh-Lab/RPIDisorder#3-predict-on-arff)

## [1. Obtain Disorder Input File](#1-obtaining-diso-input)
Option 1: Use DISOPRED3 webserver
Option 2: Use offline DISOPRED3

Option 1. Use DISOPRED3 webserver
RPIDisorder requires predicted disorder information from DISOPRED (specifically, DISOPRED3), a disorder predictor created and hosted by the University College London Department of Computer Science Bioinformatics Group. You can predict disorder
for a single sequence using their online server here: http://bioinf.cs.ucl.ac.uk/psipred/?disopred=1

Option 2. Use offline DISOPRED3
Follow the installation instructions [here](https:/github.com/Dobbsh-Lab/RPIDisorder#5-download-and-install-disopred3). Then, follow the DISOPRED3 README instructions to obtain a disorder file (.diso extension) for your protein of interest.


## [2. Generate .arff File for Protein-RNA Pair](#2-generate-arff)
Steps:
1. Enter background functions into the R environment
2. Input your protein sequence, RNA sequence, and disorder prediction file
3. Set your working directory
4. Obtain your .arff file for use in Weka

RPIDisorder needs three inputs: a protein amino acid sequence, an RNA ribonucleotide sequence, and a file of predicted disorder in the format generated by DISOPRED3. Part of this pipeline currently involves changing and running R code. You can run a line of R code by putting your cursor in the line you wish to run and hitting [Enter].


Step 1. Enter background function into the R environment
At this point, you should open the file called 'necessaryFunctions.R', highlight all the code in the file, and enter all the code into the console. (If you are using RStudio, you can hit the 'Run' button in the upper right hand corner of the code window.)


Step 2. Input your protein sequence, RNA sequence, and disorder prediction file
Open the file 'pipeline.R' in R or RStudio (recommended). Navigate to line 3, and replace the quoted text with the amino acid sequence you are interested in. Your amino acid sequence must contain only the standard 20 amino acids designated by the 1-letter IUPAC code. The sequence should not contain FASTA headers, spaces, or any other characters or punctuation. Your sequence should be in quotes, however. Input your RNA sequence, using the IUPAC 1-letter code, in line 4, following the same rules as above. (Your RNA sequence can use 'T' or 'U' characters.)
Enter both of these lines into the console.
Navigate to line 12, and run this line of code. A window will open, prompting you to choose a file for input. Navigate to your .diso DISOPRED3 file, and select this file.


Step 3. Set your working directory
Enter the code on line 15, `setwd(choose.dir())`. This code will open a prompt for you to select a folder, or directory. Navigate within this window to your 'rpidisorder-master' folder, and choose this location. This will allow the code to find certain files it needs.


Step 4. Obtain your .arff file for use in Weka
On line 18, change the quoted text ("NameHere") to a descriptor for your protein-RNA pair (e.g., 'egfr1-lncrna12'). This will give a descriptive name for your .arff file.
Next, run the  code on line 21. Your .arff file will now be in your 'rpidisorder-master' folder.


## [3. Predict on .arff File in Weka](#3-predict-on-arff)
Steps:
1. Open Weka 3.8
2. Load your .arff file into Weka
3. Load RPIDisorder model file into Weka
4. Setup for prediction
5. Predict

1. Open Weka 3.8
Navigate to your Weka 3.8 installation, and open Weka 3.8. A window may pop up, informing you that Weka has a package manager. If you don't want to see this message, check the checkbox and then hit 'OK'; otherwise, just hit 'OK'. 
Next, click on the 'Explorer' button in the top right corner.

2. Load your .arff file into Weka
In the upper left-hand corner, select 'Open File.' Navigate to your .arff file generated above, and select that file. The previously grayed out "Classify" tabe will now be available; click on this tab.

3. Right click (or command click) in the white box in the lower left-hand corner. Select 'Load Model', then navigate to and select the rpidisorder.model file in your rpidisorder-master folder.

4. In the box on the left side of the screen, labeled 'Test options', select the radio button for 'Supplied test set'. Then hit the 'Set...' button. In the pop-up window, select 'Open file...' and then make sure your .arff file is selected. Next, in the 'Test options' box, hit the 'More options...' button, then click the button that says 'Choose' and select 'PlainText'. Then hit 'OK'.

5. In the box in the lower-left hand corner, labeled 'Result list (right-click for options)', right-click and select 'Re-evaluate model on current test set.' You will see output to the "Classifier output" box on the right.


# [C. Interpreting Results](#C-interpeting-results)


