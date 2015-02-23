###------------------------------------------------------------------------------

###Getting and Cleaning Data Course Project

###------------------------------------------------------------------------------

written by: Alexander Petkovski
 
##Description:
Run analysis of test data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip as per the following requirements.
Requirements:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each 
   measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set 
   with the average of each variable for each activity and each subject.
   
   
##Data description:
Output of run_analysis.R R script to create output.txt
subject - The subject number of the experiment. See downloaded file "./UCI HAR Dataset/README.txt" for more description regarding the study and details regarding the data.
activity - One of six activities. See downloaded file "./UCI HAR Dataset/activity_labels.txt" for a list.
variable - One of several input variable means and standard deviations. A full description of these is available in downloaded file "./UCI HAR Dataset/features_info.txt" NOTE: Only the variable names with words "mean" and "std" were used.
value - the mean of the value grouped by subject, activity and variable

##Detail data processing and analysis description:

The loading, extracting and analysis is completed in a single script "run_analysis.R" using R. There are no additional steps required to process the data other than running the script in any R working directory of your choice. All files will be downloaded and created within the same folder. The description of what the R script does is as follows:

#1. Clear local variables

#2. Load any required libraries

#3. The following packages are assumed to be installed:
 1. dplyr
 2. stringi
 3. reshape2
 
#4. Set URL variable for files to download and file names to create
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFileName <- "./UCI_HAR_Dataset.zip"
destFolder <- "./UCI HAR Dataset"
outputFile <- "./output.txt"

#5. Delete destination files and folders if they exist

#6. Create local variables for the extracted files.

#7. Download and unzip file

#8. Load training and test data into separate dataframes

#9. Merge training and test data to finish Part 1.

#10. Collect feature labels for the dataset

#11. Label the X vector

#12. Set a boolean for columns with either mean() or std()

#13.  As per Part 2, extract the mean and standard deviations into a data frame

#14. Import activity labels

#15. Add descriptions to the activities as per Part 3

#16. Merge all data into a final output data table

#17. Clean up the labels from parenthesis and dashes

#18. Set the subject as a factor

#19. Create a melted output with subject and activity as factors, i.e. a narrow table

#20. Group the data by subject, activity and variable

#21. Create the tidy summary

#22. Write output to a datafile
        
#23. Clear all local variables and complete the analysis
