###  Getting and Cleaning Data - course project
###  Developed by Dave Wallis
###  19 November 2015
###
###  The purpose of this project is to process a set of data related to device performance
###  data for a Samsung Galaxy S smartphone.  The data includes observations from 30 
###  different subjects, performing up to 6 different activities that test the
###  performance of the device.  The data is separated into a test population (30%) and
###  a training population (70%).
###
###  The basic requirements of the project are to:
###    1) Merge the training and test observation data into a single data set.
###    2) Extract the data for any variables relating to mean or standard deviation.
###    3) Use descriptive names to name the activities in the data set.
###    4) User descriptive label names to describe the variables.
###    5) Produce a summarized tidy data set containing the average of each variable
###       for each activity that a subject performed.
###
###  Print statements are generated throughout the process to indicate status.
###  The flush.console() is needed to route print messages immediately to the console.
print(paste(Sys.time(),"Beginning process"))
flush.console()   # to print message immediately from function

###
### Load Master Data
###
###    The master data includes Variable and Activity definitions.  Descriptive
###    labels are applied at when the data is read in, in order to replicate through 
###    subsequent steps in the process, and to make the incremental data sets easier
###    to understand.
###

Variables <- read.table("UCI HAR Dataset/features.txt",
			stringsAsFactors=FALSE)
names(Variables) <- c("VariableID","VariableName")
Activities <- read.table("UCI HAR Dataset/activity_labels.txt",
			stringsAsFactors=FALSE)
names(Activities) <- c("ActivityID","ActivityName")

###
### Load Population Model Training Population Data
###
###    The training observation data is processed.  For each observation:
###      - XTrain contains variable data for the training group.
###      - YTrain contains activity data for the training group.
###      - SubjTrain contains subject data for the training group.
###

print(paste(Sys.time(),"Reading raw files - Training population data"))
flush.console()   # to print message immediately from function

XTrain <- read.table("UCI HAR Dataset/train/X_train.txt",
			stringsAsFactors=FALSE)
YTrain <- read.table("UCI HAR Dataset/train/y_train.txt",
			stringsAsFactors=FALSE)
SubjTrain <- read.table("UCI HAR Dataset/train/subject_train.txt",
			stringsAsFactors=FALSE)

###
### Load Population Model Test Data
###
###    The test observation data is processed.  For each observation:
###      - XTest contains variable data for the test group.
###      - YTest contains activity data for the test group.
###      - SubjTest contains subject data for the test group.
###

print(paste(Sys.time(),"Reading raw files - Test population data"))
flush.console()   # to print message immediately from function

XTest <- read.table("UCI HAR Dataset/test/X_test.txt",
			stringsAsFactors=FALSE)
YTest <- read.table("UCI HAR Dataset/test/y_test.txt",
			stringsAsFactors=FALSE)
SubjTest <- read.table("UCI HAR Dataset/test/subject_test.txt",
			stringsAsFactors=FALSE)

###
### Combine Training and Test data
###
###    This step combines the training and test related data into the 
###    separate data frames for each area (Subject, Activity, and Variable).
###    Subject and Variable descriptive labels are applied at this point.
###
###    Editorial Note:  
###    The method of adding in the ActivityName field is not very elegant
###    or scalable - I'm sure there are more efficient methods of accomplishing
###    this in R.  But for the purpose of this assignment, this did work...
###

print(paste(Sys.time(),"Creating consolidated vectors of raw Training and Test population data"))
flush.console()   # to print message immediately from function

SubjectData <- rbind(SubjTrain, SubjTest)
names(SubjectData) <- c("SubjectID")

ActivityData <- rbind(YTrain, YTest)
names(ActivityData) <- c("ActivityID")
ActivityData$ActivityName = "XXX"
ActivityData$ActivityName[which(ActivityData$ActivityID==1)] <- Activities[1,2]
ActivityData$ActivityName[which(ActivityData$ActivityID==2)] <- Activities[2,2]
ActivityData$ActivityName[which(ActivityData$ActivityID==3)] <- Activities[3,2]
ActivityData$ActivityName[which(ActivityData$ActivityID==4)] <- Activities[4,2]
ActivityData$ActivityName[which(ActivityData$ActivityID==5)] <- Activities[5,2]
ActivityData$ActivityName[which(ActivityData$ActivityID==6)] <- Activities[6,2]

VariableData <- rbind(XTrain, XTest)

###
### Clean up memory - remove staging datasets.
### Note that this is performed at various sections within this script.
###

rm(XTest,YTest,SubjTest,XTrain,YTrain,SubjTrain)

###
### Create data frame extracting all variables related to mean or standard deviation
###
###   The list of variables associated with means and standard deviations are 
###   extracted by evaluating the base variable names, and extracting (via grep)
###   any variables with names containing "mean()", "Mean()", or "std()".
###

print(paste(Sys.time(),"Creating detailed subset observation dataset"))
flush.console()   # to print message immediately from function

MeanVariables <- Variables[grep("[Mm]ean\\(\\)", Variables$VariableName),]
StdVariables <- Variables[grep("std\\(\\)", Variables$VariableName),]
MeanStdUnsorted <- rbind(MeanVariables,StdVariables)
MeanStdVariables <- MeanStdUnsorted[with(MeanStdUnsorted,order(VariableID)),]

###
### Add additional column to the MeanStdVariables dataframe with the more understandable
### field names.  These can be compared to the raw variable field names to ensure
### the mapping to the new values is accurate.
###
###   Note that the creation of the descriptive variable names was a manual process
###   performed in Excel.  The variables identified in the previous step were 
###   written to a .csv file - that .csv file was then opened in Excel, and a 
###   new column was created where the new variable names were entered in.
###   The values of those new fields were then copied and used to build the
###   new column in the MeanStdVariables data frame.
###

MeanStdVariables$TidyVariableName <-
   c("BodyAccelerometerXAxisTimeMean","BodyAccelerometerYAxisTimeMean",
"BodyAccelerometerZAxisTimeMean","BodyAccelerometerXAxisTimeStd",
"BodyAccelerometerYAxisTimeStd","BodyAccelerometerZAxisTimeStd",
"GravityAccelerometerXAxisTimeMean","GravityAccelerometerYAxisTimeMean",
"GravityAccelerometerZAxisTimeMean","GravityAccelerometerXAxisTimeStd",
"GravityAccelerometerYAxisTimeStd","GravityAccelerometerZAxisTimeStd",
"BodyAccelerometerJerkXAxisTimeMean","BodyAccelerometerJerkYAxisTimeMean",
"BodyAccelerometerJerkZAxisTimeMean","BodyAccelerometerJerkXAxisTimeStd",
"BodyAccelerometerJerkYAxisTimeStd","BodyAccelerometerJerkZAxisTimeStd",
"BodyGyroscopeXAxisTimeMean","BodyGyroscopeYAxisTimeMean",
"BodyGyroscopeZAxisTimeMean","BodyGyroscopeXAxisTimeStd",
"BodyGyroscopeYAxisTimeStd","BodyGyroscopeZAxisTimeStd",
"BodyGyroscopeJerkXAxisTimeMean","BodyGyroscopeJerkYAxisTimeMean",
"BodyGyroscopeJerkZAxisTimeMean","BodyGyroscopeJerkXAxisTimeStd",
"BodyGyroscopeJerkYAxisTimeStd","BodyGyroscopeJerkZAxisTimeStd",
"BodyAccelerometerMagnitudeTimeMean","BodyAccelerometerMagnitudeTimeStd",
"GravityAccelerometerMagnitudeTimeMean","GravityAccelerometerMagnitudeTimeStd",
"BodyAccelerometerJerkMagnitudeTimeMean","BodyAccelerometerJerkMagnitudeTimeStd",
"BodyGyroscopeMagnitudeTimeMean","BodyGyroscopeMagnitudeTimeStd",
"BodyGyroscopeJerkMagnitudeTimeMean","BodyGyroscopeJerkMagnitudeTimeStd",
"BodyAccelerometerXAxisFrequencyMean","BodyAccelerometerYAxisFrequencyMean",
"BodyAccelerometerZAxisFrequencyMean","BodyAccelerometerXAxisFrequencyStd",
"BodyAccelerometerYAxisFrequencyStd","BodyAccelerometerZAxisFrequencyStd",
"BodyAccelerometerJerkXAxisFrequencyMean","BodyAccelerometerJerkYAxisFrequencyMean",
"BodyAccelerometerJerkZAxisFrequencyMean","BodyAccelerometerJerkXAxisFrequencyStd",
"BodyAccelerometerJerkYAxisFrequencyStd","BodyAccelerometerJerkZAxisFrequencyStd",
"BodyGyroscopeXAxisFrequencyMean","BodyGyroscopeYAxisFrequencyMean",
"BodyGyroscopeZAxisFrequencyMean","BodyGyroscopeXAxisFrequencyStd",
"BodyGyroscopeYAxisFrequencyStd","BodyGyroscopeZAxisFrequencyStd",
"BodyAccelerometerMagnitudeFrequencyMean","BodyAccelerometerMagnitudeFrequencyStd",
"BodyAccelerometerJerkMagnitudeFrequencyMean","BodyAccelerometerJerkMagnitudeFrequencyStd",
"BodyGyroscopeMagnitudeFrequencyMean","BodyGyroscopeMagnitudeFrequencyStd",
"BodyGyroscopeJerkMagnitudeFrequencyMean","BodyGyroscopeJerkMagnitudeFrequencyStd")

###
### Subset VariableData to selected columns identified in MeanStdVariables
###
###   The descriptive "tidy" variable names were then used to rename
###   the columns of the selected variables in the SelectedVariableData
###   data frame created in a previous step.
###

SelectedVariableID <- unlist(c(MeanStdVariables[1]))
SelectedVariableData <- VariableData[SelectedVariableID]
names(SelectedVariableData) <- MeanStdVariables$TidyVariableName

###
### Build selected data fram = Subject + Activity + selected Variable columns
###
###   A consolidated data frame was built from the subject, activity and variable
###   data using the cbind() function.
###

SelectedObservationData <- cbind(SubjectData,ActivityData,SelectedVariableData)
rm(MeanVariables,StdVariables,MeanStdUnsorted,SelectedVariableID,SelectedVariableData)
rm(ActivityData,SubjectData,VariableData)

###
### Create aggregated tidy data set - summarizing average variable values by
### Subject ID and Activity ID.  There are 180 resultant observation records
### in the final data set (30 subjects * 6 activities each).
###
###   The final step is to aggregate the detailed data set by subject ID and
###   activity ID.  The first step aggregates that date using the 
###   aggregate(..., mean) function.  The second step removes the unneeded
###   grouping columns introduced by the aggregate function.  The third step 
###   orders those rows by subject ID and activity ID.  And finally, the 
###   output "tidy_data.txt file" is written to disk.
###

print(paste(Sys.time(),"Creating summarized observation dataset"))
flush.console()   # to print message immediately from function

AggregateObservationData <- aggregate(SelectedObservationData,
           list(SubjectID=SelectedObservationData$SubjectID,
           ActivityID=SelectedObservationData$ActivityID,
           ActivityName=SelectedObservationData$ActivityName),mean)

StageAggregateData <- cbind(AggregateObservationData[1:3],AggregateObservationData[7:72])
TidyAggregateData <- StageAggregateData[order(StageAggregateData$SubjectID,
           StageAggregateData$ActivityID),]
write.table(TidyAggregateData,"tidy_data.txt",row.names=FALSE)
rm(StageAggregateData,AggregateObservationData,SelectedObservationData)

###
###  Fin
###