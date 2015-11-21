---
TITLE: "Samsung Galaxy S Smartphone - data collection of selected device performance study results"
AUTHOR: "Dave Wallis"
DATE: "19 November 2015"

---

## Project Description
This data collection project is designed to collect, clean and consolidate selected experimental device performance data for
the Samsung Galaxy S Smartphone.  The raw data is provided from a "Human Activity Recognition" study performed at
the Smartlab Non Linear Complex Systems Laboratory in Genoa, Italy.

The specific goals of this project include:
* Creating a consolidated data set that combines the test and training population data.
* Including only those variables related to mean or standard deviation measurements, as well as the 
  activity and subject identifiers and descriptions where avaiable.
* Renaming variable names to be more descriptive.
* Consolidating the selected row (population) and column (variable) data into an aggregated data set,
  showing the average measurements of each selected variable in a single record for each subject/activity combination.

##Study design and data processing

###Collection of the raw data
The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, device data was captured for 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record the following data is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
     (Accelerometer data is presented in "standard gravity" units.
- Triaxial Angular velocity from the gyroscope. 
     (Gyroscope data is presented in units of "radians per second".
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

###Notes on the original (raw) data 
The raw data does include some null data, where measurements were not collected for some reason.  Those entries are not included in the calculation of averages for the different variables.

##Creating the tidy datafile

###Guide to create the tidy data file
These are the steps followed to produce the final summarized tidy data file:
1) The raw training and test data are first combined into single data sets (for activity, subject and variable).
2) Descriptive label names are assigned for the activity and subject columns.
3) The variables related to mean and standard deviation are identified by evaluating the raw variable names, and only selecting those names that contain the strings "mean()", "Mean()", or "std()".
4) The subject, activity and selected mean/std variable data is then combined into a single data frame, where each record is a single observation for an activity performed by a subject.
5) The raw variable column names are assigned more descriptive names, using the following mapping mechanism:
	- X				translates to		XAxis
	- Y				translates to		YAxis
	- Z				translates to		ZAxis
	- Body			translates to 		Body (duplicate occurrences of Body in a variable name are removed)
	- Acc			translates to 		Accelerometer
	- Gravity		translates to 		Gravity
	- Gyro			translates to		Gyroscope
	- Jerk			translates to		Jerk
	- Mag			translates to		Magnitued
	- t (at beginning of the raw variable name) translates to Time
	- f (at beginning of the raw variable name) translates to Frequency
	- mean/Mean		translates to		Mean
	- std			translates to		Std
	
	The descriptive column names are presented in Camel Case (Every word begins with an upper-case letter; non-beginning word letters are lower-case; no special characters in the descriptive name).
	As an example:  The raw variable name "tBodyAccJerk-mean()-Z" translates to the descriptive name of "BodyAccelerometerJerkZAxisTimeMean".

###Cleaning of the data
The README.md file describes the "run_analysis.R" data consolidation/cleansing script in greater detail. [link to the readme document]()

##Description of the variables in the tidy_data.txt file
General description of the file including:
 - The tidy_data.txt includes 180 rows (summary observations for 30 subjects, with 6 activities for each subject) and 69 columns (3 identifiers and 66 variables).  
 
 - The first 3 columns identify each record:  
  1. SubjectID identifies the subject number (between 1 and 30)							class="int"
  2. ActivityID identifies the Activity number (between 1 and 6) 						class="int"
  3. ActivityName displays the actual activity that corresponds to the ActivityID 		class="chr"
 
 - The remaining 66 columns are the actual average values of the variables captured in the study for each observation (Subject/Activity):
  4. BodyAccelerometerXAxisTimeMean					Average value of "standard gravity" units, 	class="num"
  5. BodyAccelerometerYAxisTimeMean					Average value of "standard gravity" units, 	class="num"
  6. BodyAccelerometerZAxisTimeMean					Average value of "standard gravity" units, 	class="num"
  7. BodyAccelerometerXAxisTimeStd					Average value of "standard gravity" units, 	class="num"
  8. BodyAccelerometerYAxisTimeStd					Average value of "standard gravity" units, 	class="num"
  9. BodyAccelerometerZAxisTimeStd					Average value of "standard gravity" units, 	class="num"
 10. GravityAccelerometerXAxisTimeMean				Average value of "standard gravity" units, 	class="num"
 11. GravityAccelerometerYAxisTimeMean 				Average value of "standard gravity" units, 	class="num"
 12. GravityAccelerometerZAxisTimeMean 				Average value of "standard gravity" units, 	class="num"
 13. GravityAccelerometerXAxisTimeStd  				Average value of "standard gravity" units, 	class="num"
 14. GravityAccelerometerYAxisTimeStd 				Average value of "standard gravity" units, 	class="num"
 15. GravityAccelerometerZAxisTimeStd				Average value of "standard gravity" units, 	class="num"
 16. BodyAccelerometerJerkXAxisTimeMean 			Average value of "standard gravity" units, 	class="num"
 17. BodyAccelerometerJerkYAxisTimeMean				Average value of "standard gravity" units, 	class="num"
 18. BodyAccelerometerJerkZAxisTimeMean				Average value of "standard gravity" units, 	class="num"
 19. BodyAccelerometerJerkXAxisTimeStd				Average value of "standard gravity" units, 	class="num"
 20. BodyAccelerometerJerkYAxisTimeStd				Average value of "standard gravity" units, 	class="num"
 21. BodyAccelerometerJerkZAxisTimeStd				Average value of "standard gravity" units, 	class="num"
 22. BodyGyroscopeXAxisTimeMean          			Average value of "radians per second", 		class="num"
 23. BodyGyroscopeYAxisTimeMean         			Average value of "radians per second", 		class="num"
 24. BodyGyroscopeZAxisTimeMean          			Average value of "radians per second", 		class="num"
 25. BodyGyroscopeXAxisTimeStd           			Average value of "radians per second", 		class="num"
 26. BodyGyroscopeYAxisTimeStd            			Average value of "radians per second", 		class="num"
 27. BodyGyroscopeZAxisTimeStd            			Average value of "radians per second", 		class="num"
 28. BodyGyroscopeJerkXAxisTimeMean        			Average value of "radians per second", 		class="num"
 29. BodyGyroscopeJerkYAxisTimeMean         		Average value of "radians per second", 		class="num"
 30. BodyGyroscopeJerkZAxisTimeMean         		Average value of "radians per second", 		class="num"
 31. BodyGyroscopeJerkXAxisTimeStd          		Average value of "radians per second", 		class="num"
 32. BodyGyroscopeJerkYAxisTimeStd          		Average value of "radians per second", 		class="num"
 33. BodyGyroscopeJerkZAxisTimeStd          		Average value of "radians per second", 		class="num"
 34. BodyAccelerometerMagnitudeTimeMean				Average value of "standard gravity" units, 	class="num"
 35. BodyAccelerometerMagnitudeTimeStd				Average value of "standard gravity" units, 	class="num"
 36. GravityAccelerometerMagnitudeTimeMean			Average value of "standard gravity" units, 	class="num"
 37. GravityAccelerometerMagnitudeTimeStd			Average value of "standard gravity" units, 	class="num"
 38. BodyAccelerometerJerkMagnitudeTimeMean 		Average value of "standard gravity" units, 	class="num"
 39. BodyAccelerometerJerkMagnitudeTimeStd 			Average value of "standard gravity" units, 	class="num"
 40. BodyGyroscopeMagnitudeTimeMean         		Average value of "radians per second", 		class="num"
 41. BodyGyroscopeMagnitudeTimeStd          		Average value of "radians per second", 		class="num"
 42. BodyGyroscopeJerkMagnitudeTimeMean     		Average value of "radians per second", 		class="num"
 43. BodyGyroscopeJerkMagnitudeTimeStd      		Average value of "radians per second", 		class="num"
 44. BodyAccelerometerXAxisFrequencyMean			Average value of "standard gravity" units, 	class="num"
 45. BodyAccelerometerYAxisFrequencyMean			Average value of "standard gravity" units, 	class="num"
 46. BodyAccelerometerZAxisFrequencyMean			Average value of "standard gravity" units, 	class="num"
 47. BodyAccelerometerXAxisFrequencyStd				Average value of "standard gravity" units, 	class="num"
 48. BodyAccelerometerYAxisFrequencyStd 			Average value of "standard gravity" units, 	class="num"
 49. BodyAccelerometerZAxisFrequencyStd 			Average value of "standard gravity" units, 	class="num"
 50. BodyAccelerometerJerkXAxisFrequencyMean		Average value of "standard gravity" units, 	class="num"
 51. BodyAccelerometerJerkYAxisFrequencyMean		Average value of "standard gravity" units, 	class="num"
 52. BodyAccelerometerJerkZAxisFrequencyMean		Average value of "standard gravity" units, 	class="num"
 53. BodyAccelerometerJerkXAxisFrequencyStd 		Average value of "standard gravity" units, 	class="num"
 54. BodyAccelerometerJerkYAxisFrequencyStd 		Average value of "standard gravity" units, 	class="num"
 55. BodyAccelerometerJerkZAxisFrequencyStd 		Average value of "standard gravity" units, 	class="num"
 56. BodyGyroscopeXAxisFrequencyMean     			Average value of "radians per second", 		class="num"
 57. BodyGyroscopeYAxisFrequencyMean    			Average value of "radians per second", 		class="num"
 58. BodyGyroscopeZAxisFrequencyMean    			Average value of "radians per second", 		class="num"
 59. BodyGyroscopeXAxisFrequencyStd     			Average value of "radians per second", 		class="num"
 60. BodyGyroscopeYAxisFrequencyStd     			Average value of "radians per second", 		class="num"
 61. BodyGyroscopeZAxisFrequencyStd     			Average value of "radians per second", 		class="num"
 62. BodyAccelerometerMagnitudeFrequencyMean		Average value of "standard gravity" units, 	class="num"
 63. BodyAccelerometerMagnitudeFrequencyStd 		Average value of "standard gravity" units, 	class="num"
 64. BodyAccelerometerJerkMagnitudeFrequencyMean  	Average value of "standard gravity" units, 	class="num"
 65. BodyAccelerometerJerkMagnitudeFrequencyStd	  	Average value of "standard gravity" units, 	class="num"
 66. BodyGyroscopeMagnitudeFrequencyMean  			Average value of "radians per second", 		class="num"
 67. BodyGyroscopeMagnitudeFrequencyStd   			Average value of "radians per second", 		class="num"
 68. BodyGyroscopeJerkMagnitudeFrequencyMean		Average value of "radians per second", 		class="num"
 69. BodyGyroscopeJerkMagnitudeFrequencyStd			Average value of "radians per second", 		class="num"

 - The summarized data set is written out to a diskfile named "tidy_data.txt".