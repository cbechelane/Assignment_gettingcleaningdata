# Getting and Cleaning Data Course Project

## Goal

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.


The original data for the project is here:

 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
 

One R script called run_analysis.R was created. It does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject - *tidydata.txt*.

## Structure

The project contains the following files:

- *README.md*: this file, which explains the project goals and the analysis files
- *README.html*: the HTML version of *README.md*

- *run_analysis.R*: the R script run on the data set

- *tidydata.txt*: the tidy data obtained when running *run_analysis.R* on the original data 

- *CodeBook.md*: document containing information about each of the variables in the dataset *tidydata.txt*
- *CodeBook.html*: the HTML version of *CodeBook.md*


## Assumptions

- the original data was downloaded to the same directory as the R script and unziped.
- after this step, all the files are contained in the directory "UCI HAR Dataset".
- *run_analysis.R* is then run, and after that the file *tidydata.txt* is generated.


## Script steps

0. Environment preparation
    + The library "data.table" is loaded
    + The test and training datasets, activity labels and subjects are read from the original data

1. Merges the training and the test sets to create one data set
    + Firstly all the corresponding data from test and training are merged using rbind, creating allsets, alllabels and allsubject 
    + After this, these 3 objects are merged into one, called mergeddata, using cbind
  
2. Extracts only the measurements on the mean and standard deviation for each measurement.
    + reads the features that were measured are in the metadata file features.txt
    + mean and standard deviation are the features that contain either "mean()" or "std()" in the name, as per the file "features_info.txt". Therefore, these are subseted
    + adds the activity label id and subject id to the beginning of the features list before subsetting
  
3. Uses descriptive activity names to name the activities in the data set
    + the names of the activities are in the metadata file activity_labels.txt
    + the script merges activity labels with the dataset, first by setting the appropriate keys in order to merge
  
4. Appropriately labels the data set with descriptive variable names.
    + To make the column names even more readable, we do the following substitutions
        - Acc -> Accelerometer
        - Gyro -> Gyroscope
        - f -> Frequency
        - t -> Time
        - BodyBody -> Body
        - Mag -> Magnitude
        - () -> "empty string"
  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    + Firstly, subject is set as a factor
    + Then we aggregate the data by subject and activity
    + The data is ordered by subject and activity, in this order
    + Finally, the dataset is written in *tidydata.txt*
  
For more details on each step of the script, please refer to the comments in the script file.

