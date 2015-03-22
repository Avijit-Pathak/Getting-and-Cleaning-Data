#Getting and Cleaning Data Project

*This Code Book describes the variables, the data, and any transformations or work that I performed to clean up the data

#Source Data

*A full description is available at the site where the data was obtained: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#Data Set Information

*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

#Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

#Activity Given

###You should create one R script called run_analysis.R that does the following. 
1.Merges the training and the test sets to create one data set.

2.Extracts only the measurements on the mean and standard deviation for each measurement. 

3.Uses descriptive activity names to name the activities in the data set

4.Appropriately labels the data set with descriptive variable names. 

5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#1.Merges the training and the test sets to create one data set.

Set the source Directory

Read various data sets given as txt files

####Varibles used

-feature for features.txt
-activitylab for activity_labels.txt
-subjecttrain for subject_train.txt
-xtrain for x_train.txt
-ytrain for y_train.txt
-subjecttest for subject_test.txt
-xtest for x_test.txt
-ytest for y_test.txt

#2. Extract only the measurements on the mean and standard deviation for each measurement.

Created a logical vector that gives true values for mean(),stddev() subset it in the merged data set to get the required columns

#3. Use descriptive activity names to name the activities in the data set.

Merging the data set with activitylab variable gives it the discriptive names

#4.Appropriately labels the data set with descriptive variable names.

This is done by using gsub function for pattern replacement inside a loop

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

After excluding the activity column, Tidy data set has been created using aggregate function, as per the course.