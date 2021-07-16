################################################################################
#
# This script:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

################################################################################


# sets the work directory as the same directory of this script
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# install required additional package
install.packages("data.table")
library(data.table)

# Note: the original data was downloaded to the same directory as this script,
# and unzipped to the directory "UCI HAR Dataset"

# reads test set and training set
testset <- fread("UCI HAR Dataset\\test\\X_test.txt")
trainingset <- fread("UCI HAR Dataset\\train\\X_train.txt")

# reads test and training activity labels
testlabels <- fread("UCI HAR Dataset\\test\\y_test.txt")
traininglabels <- fread("UCI HAR Dataset\\train\\y_train.txt")

# reads test and training subjects
testsubj <- fread("UCI HAR Dataset\\test\\subject_test.txt")
trainingsubj <- fread("UCI HAR Dataset\\train\\subject_train.txt")


################################################################################

# 1. Merges the training and the test sets to create one data set

# puts all test and training sets into one object 
allsets <- rbind(testset, trainingset)

# puts all test and training labels into one object
alllabels <- rbind(testlabels, traininglabels)
setnames(alllabels, "V1", "activity_id")

# puts all test and training subjects into one object
allsubjects <- rbind(testsubj, trainingsubj)
setnames(allsubjects, "V1", "subject")

# merges all sets, subjects and labels data into one set
mergeddata <- cbind(alllabels, allsubjects, allsets)


################################################################################

# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement. 

# reads the features that were measured are in the metadata file features.txt
featureslist <- fread("UCI HAR Dataset\\features.txt")

# mean and standard deviation are the features that contain either "mean()" or
# "std()" in the name, as per the file "features_info.txt".
# Therefore, we subset the features list for these desired features
featureslist <- featureslist[grepl("mean\\(\\)|std\\(\\)", V2)]

# as the first 2 columns of the merged data correspond to the subject and
# activity ids, respectively, those have to remain in the merged data. Therefore
# the features list is manipulated to reflect this:

# adds +2 to the ids of the features list
featureslist$V1 <- featureslist$V1 + 2

# adds the activity label id and subject id to the beginning of the features
# list
featureslist <- rbind(data.table(V1=1:2, V2 = c("activity_id", "subject")),
                      featureslist,
                      use.names=FALSE)

# subsets the columns of the merged data with only the desired measurements
# (mean and std), subject and activity label
mergeddata <- mergeddata[, featureslist$V1, with = FALSE]


################################################################################

# 3. Uses descriptive activity names to name the activities in the data set

# the names of the activities are in the metadata file activity_labels.txt
activitylabels <- fread("UCI HAR Dataset\\activity_labels.txt")
colnames(activitylabels) <- c("activity_id", "activity_label")

# merges activitylabels with the dataset, first by setting the appropriate keys
# in order to merge
setkey(activitylabels, activity_id)
setkey(mergeddata, activity_id)
mergeddata <- merge(mergeddata, activitylabels)


################################################################################

# 4. Appropriately labels the data set with descriptive variable names. 

# the column "V2" of featureslist contains the appropriate name of the
# variables. The previous step (the merge created an additional column called
# activity_label. Therefore, this is added to the end of featureslist

featureslist <- rbind(featureslist,
                      data.table(V1=0, V2 = c("activity_label")),
                      use.names=FALSE)

# attributes the appropriate name to the data
colnames(mergeddata) <- featureslist$V2

# To make the column names even more readable, we do the following substitutions
#
# Acc -> Accelerometer
# Gyro -> Gyroscope
#  f -> Frequency
#  t -> Time
# BodyBody -> Body
# Mag -> Magnitude
#  () -> "empty string"

names(mergeddata)<-gsub("Acc", "Accelerometer", names(mergeddata))
names(mergeddata)<-gsub("Gyro", "Gyroscope", names(mergeddata))
names(mergeddata)<-gsub("^t", "Time", names(mergeddata))
names(mergeddata)<-gsub("^f", "Frequency", names(mergeddata))
names(mergeddata)<-gsub("BodyBody", "Body", names(mergeddata))
names(mergeddata)<-gsub("Mag", "Magnitude", names(mergeddata))
names(mergeddata)<-gsub("\\(\\)", "", names(mergeddata))

# removes column "activity_id"
mergeddata[, activity_id:=NULL]


################################################################################

# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

# set subject as a factor
mergeddata$subject <- as.factor(mergeddata$subject)

# we create tidydata, which aggregates the data by subject and activity
tidydata <- aggregate(. ~subject + activity_label, mergeddata, mean)
tidydata <- tidydata[order(tidydata$subject, tidydata$activity_label),]
write.table(tidydata, file = "tidydata.txt", row.names = FALSE)


