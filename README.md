##ProjectSamsungCoursera
=====================
This repo contains a single R script 'run_analysis.R' written as a project for the Coursera 'Getting and Cleaning Data' course.

The script assumes that there is a folder/directory called 'UCI HAR Dataset' in the user's working directory containing the file structure and contents downloaded from the following location provided by the course tutors:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#The script imports and manipulates the following files from the above mentioned directory:

- 'features_info.txt': information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

#The script runs through a series of steps to:

- Import the raw training and test data sets into data frames in R and combine them into one
- Import the training and test label data sets into data frames in R and combine them into one
- Append the labels to the raw data sets
- Import the list of features and add it to the combined data set as column headings
- Import the labels for the activities and replace the activity IDs with these descriptive lables in the combined data set
- Filter the feature columns to a subset of the full list, including only the mean and standard deviation features
- For each combination of subject (count = 30) and activity (count = 6) to calculate an average of the grouped record set. 

I chose to use a wide format for the data output as I believe this maintained flexibility, was a tidy format and was easy to understand on viewing the data. 
