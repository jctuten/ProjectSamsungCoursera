##The following program combines data from the UCI HAR test and training datasets
##It then extracts measurements on the mean and standard deviation only
##Descriptive activity and variable names are applied
##Finally, a tidy data set is generated with the average of each variable for each activity & subject


test_data<-read.table("./UCI HAR Dataset/test/X_test.txt") ## Read in the raw test data
train_data<-read.table("./UCI HAR Dataset/train/X_train.txt")## Read in the raw training data

##The following lines of code read in most of the raw data

clnames<-t(read.table("./UCI HAR Dataset/features.txt")) ##Read in and transpose the list of names for features
cnames<-cbind("Subject","Activity",clnames) ## Add column names for Subject and Activity to the start of the column names
all_data<-rbind(test_data,train_data) ## Append the training data to the test data to produce a complete data set
test_activity<-read.table("./UCI HAR Dataset/test/y_test.txt") ##Read in the activity names for the test data
train_activity<-read.table("./UCI HAR Dataset/train/y_train.txt") ##Read in the activity names for the training data
test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt") ##Read in the subject values for the test data
train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt") ##Read in the subject values for the training data

##The following lines of code combine the data that has been read in, attaching column names and labels

all_activity<-rbind(test_activity,train_activity) ##Append the training activity data to the test activity data
all_subject<-rbind(test_subject, train_subject) ##Append the training subject data to the test subject data
all_data<-cbind(all_subject,all_activity,all_data) ##Add the complete subject and activity data columns to the existing complete data set
colnames(all_data)<-cnames[2,] ##-Add the second row of the cnames data (this contains the feature descriptions) as column headers for the complete data set
activity_label<-read.table("./UCI HAR Dataset/activity_labels.txt") ## Read in the activity labels data
colnames(activity_label)<-c("Activity","Activity_Label") ##Give meaningful titles to the data columns for the activity labels data
all_data<-merge(activity_label,all_data) ## Merges the activity labels with the combined data set -providing descriptive names in addition to id numbers for the activities


##The following lines of code filter the columns leaving only those relating to mean or standard deviations
##THen calculate a mean for each activity/subject combination and then perform some tidying

filtered_data <- all_data[,grep("[Mm]ean|[Ss][Tt][Dd]|Activity_Label|Subject", names(all_data))] ##Creates a filtered data set from the combined data with only mean and standard deviation measures included
attach(filtered_data)
tidy_data <- aggregate(filtered_data, by=list(Activity_Label, Subject), FUN = "mean") ##creates a tidy data set that groups the filtered data by subject/activity combination and calculates the mean for each aggregate
detach(filtered_data)
tidy_data <- subset(tidy_data, select = -c(Group.2,Activity_Label)) ##removes the duplicated activity labels created by the aggregate function in the preceding step
colnames(tidy_data)[1]<-"Activity" ##Renames the first column to 'Activity'

##The remaining lines of code below are a series of steps to replace the column names representing the features with a 'friendlier'
##and more easy to read set of names, using gsub to find and replace various character strings

names(tidy_data)<-gsub("_|-|\\(|\\)|,", "", names(tidy_data));names(tidy_data)<-gsub("tGravity", "Timegravity", names(tidy_data))
names(tidy_data)<-gsub("Acc", "Acceleration", names(tidy_data));names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("Freq", "Frequency", names(tidy_data));names(tidy_data)<-gsub("std", "StandardDeviation", names(tidy_data))
names(tidy_data)<-gsub("tB", "TimeB", names(tidy_data));names(tidy_data)<-gsub("fB", "FrequencyB", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data));names(tidy_data)<-gsub("mean", "Mean", names(tidy_data))
names(tidy_data)<-gsub("angle", "Angle", names(tidy_data));names(tidy_data)<-gsub("gravity", "Gravity", names(tidy_data))

##Finally the data set is exported into the working directory as a space delimited text file named 'tidy_data'
write.table(tidy_data,file="tidy_data.txt",row.names=FALSE)