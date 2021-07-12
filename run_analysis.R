#
# This script:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
install.packages("data.table")
library(data.table)

# reads test set and training set
testset <- fread("UCI HAR Dataset\\test\\X_test.txt")
trainingset <- fread("UCI HAR Dataset\\train\\X_train.txt")

# reads test and training activity labels
testlabels <- fread("UCI HAR Dataset\\test\\y_test.txt")
traininglabels <- fread("UCI HAR Dataset\\train\\y_train.txt")

# reads the test and training subjects
testsubj <- fread("UCI HAR Dataset\\test\\subject_test.txt")
trainingsubj <- fread("UCI HAR Dataset\\train\\subject_train.txt")


################################################################################

# 1. Merges the training and the test sets to create one data set

# put all test and training sets into one object 
allsets <- rbind(testset, trainingset)
# Correct the name of each column (the measurements) using the features list

# put all test and training labels into one object
alllabels <- rbind(testlabels, traininglabels)
setnames(alllabels, "V1", "activity_id")

# put all test and training subjects into one object
allsubjects <- rbind(testsubj, trainingsubj)
setnames(allsubjects, "V1", "subject")

# merges all sets, subjects and labels data into one set
mergeddata <- cbind(alllabels, allsubjects, allsets)


################################################################################

# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement. 

# features that were measured are in the file features.txt
featureslist <- fread("UCI HAR Dataset\\features.txt")

# mean and standard deviation are the features that contain either "mean" or
# "std" in the column name, as per the file "features_info.txt"
# Therefore, we subset the features list for the desired features mean and std:
featureslist <- featureslist[grepl("mean\\(\\)|std\\(\\)", V2)]

# as the first 2 columns of the merged data correspond to the subject and
# activity ids, respectively, those have to remain in the final data. Therefore
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
tidydata <- mergeddata[, featureslist$V1, with = FALSE]



################################################################################

# 3. Uses descriptive activity names to name the activities in the data set

# the names of the activities are in the file activity_labels.txt
activitylabels <- fread("UCI HAR Dataset\\activity_labels.txt")
colnames(activitylabels) <- c("activity_id", "activity_label")

# merge activitylabels with the dataset, first by setting the appropriate keys
# in order to merge
setkey(activitylabels, activity_id)
setkey(tidydata, activity_id)
tidydata <- merge(tidydata, activitylabels)



################################################################################

# 4. Appropriately labels the data set with descriptive variable names. 

# the column "V2" of featureslist contains the appropriate name of the
# variables. The previous step (the merge created an additional column called
# activity_label. Therefore, this is added to the end of featureslist

featureslist <- rbind(featureslist,
                      data.table(V1=0, V2 = c("activity_label")),
                      use.names=FALSE)

# attributes the appropriate name to the data
colnames(tidydata) <- featureslist$V2




################################################################################

# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

tidydata2

