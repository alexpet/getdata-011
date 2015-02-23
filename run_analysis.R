#
# ------------------------------------------------------------------------------
#
# Getting and Cleaning Data Course Project
#
# ------------------------------------------------------------------------------
#
# written by: Alexander Petkovski
# 
# Description:
# Run analysis of test data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# as per the following requirements.
# Requirements:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#
# WARNING: Script will clear all local variables
#

# Clear local variables
print("Clear local variables")
rm(list = ls())

# Load any required libraries
# The following packages are assumed to be installed:
# 1. dplyr
# 2. stringi
# 3. reshape2
print("Loading required libraries...")
library(dplyr)
library(stringi)
library(reshape2)

# URL variable for files to download and filename
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFileName <- "./UCI_HAR_Dataset.zip"
destFolder <- "./UCI HAR Dataset"
outputFile <- "./output.txt"

# Delete destination files and folders if they exist
print("Deleting files and folders if they exist")
if(file.exists(destFileName)) {file.remove(destFileName)}
if(file.exists(outputFile)) {file.remove(outputFile)}
if(file.exists(destFolder)) {unlink(destFolder, recursive = TRUE)}

# Create local variables for the extracted files.
activityLabelsFile <- "./UCI HAR Dataset/activity_labels.txt"
featureLabelsFile <- "./UCI HAR Dataset/features.txt"

trainSubjectLabelsFile <- "./UCI HAR Dataset/train/subject_train.txt"
train_X_vectorFile <- "./UCI HAR Dataset/train/X_train.txt"
train_y_vectorFile <- "./UCI HAR Dataset/train/y_train.txt"

testSubjectLabelsFile <- "./UCI HAR Dataset/test/subject_test.txt"
test_X_vectorFile <- "./UCI HAR Dataset/test/X_test.txt"
test_y_vectorFile <- "./UCI HAR Dataset/test/y_test.txt"

# Download and unzip file
print("Dowloading file...")
download.file(fileUrl, destFileName)
unzip(destFileName)

# Load training and test data into separate dataframes
print("Load initial data frames...")
trainSubjectLabels <- read.table(trainSubjectLabelsFile)
train_X_vector <- read.table(train_X_vectorFile)
train_y_vector <- read.table(train_y_vectorFile)

testSubjectLabels<- read.table(testSubjectLabelsFile)
test_X_vector <- read.table(test_X_vectorFile)
test_y_vector <-read.table(test_y_vectorFile)

# Merge training and test data to finish Part 1.
print("Merge data frames...")
subjectLabels <- rbind(trainSubjectLabels,testSubjectLabels)
X_vector <- rbind(train_X_vector,test_X_vector)
y_vector <- rbind(train_y_vector,test_y_vector)

# Load featureLabels
featureLabels <- read.table(featureLabelsFile)

# Label X_vector
names(X_vector)[1:length(names(X_vector))] <- as.character(featureLabels[,2])

# Set a boolean for columns with either mean() or std()
X_vector.out.bool <- stri_detect_fixed(names(X_vector),"mean") | 
        stri_detect_fixed(names(X_vector),"std")

# As per Part 2, extract the mean and standard deviations into a data frame
print("Extract required mean and standard deviation columns")
X_vector.extract <- X_vector[,X_vector.out.bool]

# Import activity labels
print("Apply activity labels...")
activityLabels <- read.table(activityLabelsFile)

# Add descriptions to the activities as per Part 3
Y_vector <- merge(y_vector, activityLabels)

# Merge all data into a final output data table
print("Create single output table with all required data...")
output <- cbind(subjectLabels,Y_vector[,2],X_vector.extract)
names(output)[1:2] <- c("subject","activity")

# Clean up the labels from parenthesis and dashes
output_labels <- gsub("\\()","",gsub("-","_",names(output)))
names(output) <- output_labels

# Set the subject as a factor
output <- mutate(output, subject = as.factor(subject))

# Create a melted output with subject and activity as factors, i.e. a narrow table
output.melt <- melt(output, id = c("subject", "activity"), measure.vars = 3:ncol(output))

# Group the data
print("Group the data")
output.group <- output.melt %>% group_by(subject, activity, variable)

# Create the tidy summary
print("Create the final ouptput summary")
tidy <- summarize(output.group, mean = mean(value))

# Write output to a datafile
print("Extract into output.txt file")
write.table(tidy, outputFile, row.names = FALSE)
        
# Clear all local variables
rm(list = ls())

print("All done!")
