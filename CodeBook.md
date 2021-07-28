# Codebook

## Human Activity Recognition Using Smartphones Dataset

This document describes the variables and summaries calculated, along with units, and any other relevant information related to the data in the dataset *tidydata.txt*.

## The experiments

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. Please refer to the Features session below for more details.

For each record it was captured:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment. Its range is from 1 to 30.

## Features

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals (prefix 'Time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (TimeBodyAccelerometer-XYZ and TimeGravityAccelerometer-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (TimeBodyAccelerometerJerk-XYZ and TimeBodyGyroscopeJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (TimeBodyAccelerometerMagnitude, TimeGravityAccelerometerMagnitude, TimeBodyAccelerometerJerkMagnitude, TimeBodyGyroscopeMagnitude, TimeBodyGyroscopeJerkMagnitude). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing FrequencyBodyAccelerometer-XYZ, FrequencyBodyAccelerometerJerk-XYZ, FrequencyBodyGyroscope-XYZ, FrequencyBodyAccelerometerJerkMagnitude, FrequencyBodyGyroscopeMagnitude, FrequencyBodyGyroscopeJerkMagnitude.

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: 

- mean: Mean value
- std: Standard deviation



## Features list

- TimeBodyAccelerometer-mean-XYZ
- TimeBodyAccelerometer-std-XYZ
- TimeGravityAccelerometer-mean-XYZ
- TimeGravityAccelerometer-std-XYZ
- TimeBodyAccelerometerJerk-mean-XYZ
- TimeBodyAccelerometerJerk-std-XYZ
- TimeBodyGyroscope-mean-XYZ
- TimeBodyGyroscope-std-XYZ
- TimeBodyGyroscopeJerk-mean-XYZ
- TimeBodyGyroscopeJerk-std-XYZ
- TimeBodyAccelerometerMagnitude-mean         
- TimeBodyAccelerometerMagnitude-std          
- TimeGravityAccelerometerMagnitude-mean      
- TimeGravityAccelerometerMagnitude-std       
- TimeBodyAccelerometerJerkMagnitude-mean     
- TimeBodyAccelerometerJerkMagnitude-std      
- TimeBodyGyroscopeMagnitude-mean             
- TimeBodyGyroscopeMagnitude-std              
- TimeBodyGyroscopeJerkMagnitude-mean         
- TimeBodyGyroscopeJerkMagnitude-std          
- FrequencyBodyAccelerometer-mean-XYZ
- FrequencyBodyAccelerometer-std-XYZ
- FrequencyBodyAccelerometerJerk-mean-XYZ
- FrequencyBodyAccelerometerJerk-std-XYZ
- FrequencyBodyGyroscope-mean-XYZ
- FrequencyBodyGyroscope-std-XYZ
- FrequencyBodyAccelerometerMagnitude-mean    
- FrequencyBodyAccelerometerMagnitude-std     
- FrequencyBodyAccelerometerJerkMagnitude-mean
- FrequencyBodyAccelerometerJerkMagnitude-std 
- FrequencyBodyGyroscopeMagnitude-mean        
- FrequencyBodyGyroscopeMagnitude-std         
- FrequencyBodyGyroscopeJerkMagnitude-mean    
- FrequencyBodyGyroscopeJerkMagnitude-std  



## The data

In the dataset *tidydata.txt* it is presented the average of each variable for each activity and each subject.

