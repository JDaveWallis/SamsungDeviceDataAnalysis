# SamsungDeviceDataCollection
This repository provides a codebook, R script and resultant tidy data set of selected device performance data for the Samsung Galaxy S Smartphone.  Developed as course project for Johns Hopkins "Getting and Cleaning Data" course, through Coursera. (Dave Wallis - 19 November 2015)


The [run_analysis.R](https://github.com/JDaveWallis/SamsungDeviceDataAnalysis/blob/master/run_analysis.R) script contains significant in-line comments describing the activities being performed by the script.  The text below summarizes those basic steps:

* Reads in the master data for Activties and Variables to get those object types/descriptions.
* Reads in the raw Observation data files associated to Subjects, Activities and Variables for both the training and test populations.
* Merges the training and test population Observation data for Subjects, Activities, and Variables into 3 consolidated data sets.
* Subject and Activity descriptive labels are assigned to those columns, and the ActivityName is added to the Activity data set.
* All Variables in the master file associated with mean and std are identified by extracting those Variables that contain the string "mean()", "Mean()", or "std()".  Note that there are 66 of these variables identified through this method.
* Descriptive label names are assigned for each of those identified 66 Variables. These descriptive column names were constructured in Excel, using the translation method described in the code book [CODEBOOK.md](https://github.com/JDaveWallis/SamsungDeviceDataAnalysis/blob/master/CODEBOOK.md).
* All Variable observations for those identified 66 Variables are extracted from the consolidated Variable observationdata set.
* The Subject, Activity, and subset Variable datasets are concatenated together using the cbind() function.
* Note that the consolidated detailed observation data set includes 12,099 observation records, and 69 columns (3 identifiers and 66 variables).
* The tidy data set is then created by aggregating the detailed observation data set across subject and activity, with the aggregate "mean" function being applied to each of the 66 observation variable columns.
* The resultant tidy date set contains 180 records - 6 activity records for each of the 30 subjects in the study.  The number of columns is 69 (3 identifiers and 66 variables) - that is not changed by the aggregation of data across records.
* The [tidy_data.txt] (https://github.com/JDaveWallis/SamsungDeviceDataAnalysis/blob/master/tidy_data.txt) file is then written to disk. 


# Execution of the "run_analysis.R" script

Print statements are generated throughout the process to indicate status, and cleanup of data sets no longer needed occurs throughout the "run_analysis.R" script.  The following process status messages are from a successful execution of the script.

source("run_analysis.R")

"2015-11-21 10:24:10 Beginning process"

"2015-11-21 10:24:10 Reading raw files - Training population data"

"2015-11-21 10:24:32 Reading raw files - Test population data"

"2015-11-21 10:24:37 Creating consolidated vectors of raw Training and Test population data"

"2015-11-21 10:24:38 Creating detailed subset observation dataset"

"2015-11-21 10:24:38 Creating summarized observation dataset"

There were 50 or more warnings (use warnings() to see the first 50)

