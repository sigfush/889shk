# Analyzing resting-state fMRI data from multiple sources
This README link was created as part of a final project in PSYC 889 (“Advanced MRI Analyses”) at the University of South Carolina. The author assumes full responsibility for the description put forth below and credits others who have contributed to this work in any way where applicable. 

Overview: The current project is a data-driven study motivated by a recent finding from our group suggesting that functional cortical brain activation is mediated by the brain-derived neurotrophin factor (BDNF) gene in subjects with chronic aphasia (Kristinsson et al., in press). We were interested in investigating whether there was a difference in resting-state functional brain networks by BDNF genotype in the same sample of subjects. To this end, we had available data on BDNF genotype, various language measures, and neuroimaging data. Below we briefly describe the objects of the study, the available data, and focus mainly on issues faced in processing the resting-state functional MRI data and the resolution of these issues. Our aim is that this step-by-step guide may prove useful for others faced with similar problems. 

# Study objective
  - We wished to compare correlations between functional connections within the default-mode network resting state brain         network across two groups of subjects with chronic aphasia; those with the Val66Val variant (typical group) of the BDNF gene and those with the Val66Met/Met66Met variant (atypical group) of the BDNF gene. 

We collapsed data obtained for three different studies. Resting-state fMRI data was obtained over different time periods, on two different scanners, and utilized difference sequence protocols. Specifically, three sequences were present in the data set:
  - Sequence 1: Siemens Trio 3T scanner, 64x64x34 voxels, voxel resolution 3.2x3.2x3.6 mm, TR = 1.85 s, 196 volumes (n = 19)
  - Sequence 2: Siemens Prisma 3t scanner, 90x90x50 voxels, voxel resolution 2.4x2.4x2.4 mm, TR = 1.65 s, 370 volumes (n = 5)
  - Sequence 3: Siemens Prisma 3t scanner, 90x90x50 voxels, voxel resolution 2.4x2.4x2.4 mm, TR = 1.65 s, 427 volumes (n = 39)
  
For this reason, we were faced with two distinct major problems requiring attention before the data could be analyzed. 

# Issues faced
  1) The number of volumes different between sequences 1-3, which, left unaddressed, would skew the correlational analysis.
  2) The spatial resolution differed between sequences 1-3, posing a potential problem for data analysis.
  
# Resolution
Issue 1)
Our aim was to re-process the scans to have the same number of volumes across all subjects. We did this by truncating the longer sequences to match the number of volumes in sequence 1 (196). We utilized three separate Matlab scripts to obtain this goal. 
- Step 1
Implementing the first script ("copy_rest"), we generated a new folder and copied nifti files that contained resting-state data for our subject list to this location. This script takes an Excel sheet as input and finds '.nii' files containing resting state data (in this case, the script searches in preprocessed files including these prefixes: 'mfdswaRest', 'mfdswRest', 'fdswaRest', 'fdswRest'). The files are then copied to a desired location. 
- Step 2
The second script ("truncate_mri") operates from the directory where the resting-state files were copied to. This simple script browses through the files and truncates files with more than 196 volumes (> 196) to contain only 196 volumes. In our study, thus, files that have sequnces 2 and 3 are truncated, whereas files that have sequence 1 will be left unaffected. Truncated '.nii' files are saved in the same directory. 
- Step 3
Last, we used the third script ("create_fc") to convert the '.nii' files to files readable in Matlab ('.mat'). The new files are named according to a specific master number for each subject and saved in the same directory. 

Therefore, our resulting resting-state connectome Matlab files now include the same number of volumes across subjects and are ready to be analyzed. Note that for our purpose, we only required resting-state data and this is the only data included in the outputted files. 

Issue 2)
- We treated this issue at the data analysis level. Our main concern was that the spatial resolution would significantly affect our analysis, i.e. that true group differences would be masked by different spatial resolution in sequence 1 vs. sequences 2 & 3. Therefore, our first step was to perform a support vector machine (SVM) analysis to classify subjects based on the sequence of their resting-state data (binary classification: 0 = sequence 1, 1 = sequences 2 & 3). Our concern proved valid, as sequence type was predicted with over 90% accuracy. 
- While we discussed other options, we decided to remediate this issue by including sequence type as a nuisance regressor in all subsequent analyses, thus accounting for the variability in group differences explained by sequence type. We ran our subsequent analyses on subjects with the long sequence only as well to check the reliability of our approach. 

# Data analysis
Having successfully remediated the issues we faced, we moved on to analyzing our data. We performed our analyses using NiiStat software (developed by Chris Rorden, https://www.nitrc.org/projects/niistat/). In line with our primary objective, we sought to classify our subjects into one of two categories; typical and atypical groups. We used Freedman Lane permutation based approach to control for multiple comparisons. This approach allowed us to include columns for nuisance regressors in the Excel sheet (insert a minus "-" sign in front of number of permutations). 

We used the John's Hopkin's University (JHU) brain atlas built into NiiStat. The default-mode network was defined in terms of the following JHU regions based on previous literature (Greicius et al., 2003; Thomason et al., 2009; Wang et al., 2014): 31_LH_AngularGyrus, 32_RH_AngularGyrus, 33_LH_Pre-cuneus, 34_Pre-cuneus, 45_LH_ParahippocampalGyrus, 46_RH_ParahippocampalGyrus, 69_LH_PosteriorCingulateGyrus, 70_RH_PosteriorCingulateGyrus, 75_LH_Hippocampus, 76_RH_Hippocampus, 141_LH_Cingulum(Hippocampus), 142_RH_Cingulum(Hippocampus. 

In addition to exploring BDNF genotype-specific differences in the default-mode network, we were interested in examining if and how these differences were manifested in language profiles in our subjects. To achieve this goal, we wrote a simple Matlab script that extracts the correlation between two areas (as we were only interested in connections that survived our permutation analysis). This script is titled "extract_connections" and has been made available. Usage requires setting a path to a specific directory and specifying regions of interest ('roi1' and 'roi2'). The connection strength can then be associated with behavioral measures.

Results from these analyses will be reported in a poster presented at the Society for the Neurobiology of Language Conference in August, 2019. 
