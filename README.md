WEBSERVER COMING SOON!


v1.0.0
For datasets used during these experiments, check the 'Datasets' folder.
The files in the 'data' folder are required for proper functioning of an R script below, 
and are not part of the datasets used in experiments.

RPIDisorder requires predicted disorder information from DISOPRED, a disorder predictor created and hosted by the University College London Department of Computer Science Bioinformatics Group. You can predict disorder
for a single sequence using their online server here: http://bioinf.cs.ucl.ac.uk/psipred/?disopred=1
(This is recommended for most users, as it can be difficult to install and configure the 
necessary dependencies to run DISOPRED locally.)


If you wish to run DISOPRED locally, download and install the offline version here:
http://bioinfadmin.cs.ucl.ac.uk/downloads/DISOPRED/

Installation instructions are included in the DISOPRED README file.

Please note that running DISOPRED locally requires an installation of NCBI BLAST v2.2.26, which is available here:
ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.2.26/

NCBI BLAST requires a sequence database; RPIDisorder was created using the SwissProtDB:
ftp://ftp.ebi.ac.uk/pub/databases/uniprot/knowledgebase/uniprot_sprot.fasta.gz



The WEKA machine learning platform is required. Download here: http://www.cs.waikato.ac.nz/ml/weka/downloading.html
You will also require the latest version of R: https://www.r-project.org/

In the near future, we will be adding better integration of DISOPRED predictions into this pipeline, 
and will implement the ability to make predictions without opening WEKA at all.
The R scripts and systems included here will be made available in package form for easier use and installation.

In order to predict whether a protein will bind an RNA using RPIDisorder, open 'R' and enter
all functions in 'necessaryFunctions.R' into the R environment.
Then follow the instructions in 'pipeline.R' to generate an ARFF file.

