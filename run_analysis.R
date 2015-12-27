#1.Merges the training and the test sets to create one data set.
train <- read.table("X_train.txt", header=F)
test <- read.table("X_test.txt", header=F)
all_data <- merge(train,test,all.x=T,all.y=T)

#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
library(dplyr)
features <- read.table("features.txt", header=F, col.names=c("col_no","feature"))
field <- features[["feature"]]
#field_valid <- make.names(names=field, unique=TRUE, allow_ = TRUE)
colnames(all_data) <- field
all_data_rd <- all_data[, !duplicated(colnames(all_data))]
mean_std_field <- grep("mean\\(\\)|std", colnames(all_data_rd))
mean_std_data <- select(all_data_rd, mean_std_field)

#3.Uses descriptive activity names to name the activities in the data set
library(plyr)
#prepare all activity data
activity_train <- read.table("y_train.txt")
activity_test <- read.table("y_test.txt")
all_activity <- c(unlist(activity_train), unlist(activity_test))
activities <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
all_activity_f <- factor(all_activity, labels=activities)
#prepare all subject data
subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")
all_subject <- c(unlist(subject_train), unlist(subject_test))
#add activity and subject column to the table
mean_std_data_2 <- mutate(mean_std_data, activity = all_activity_f, subject = all_subject)

#4.Appropriately labels the data set with descriptive variable names. 
colnames(mean_std_data_2) <- gsub("^t", "Time", colnames(mean_std_data_2))
colnames(mean_std_data_2) <- gsub("Acc", "Accelerometer", colnames(mean_std_data_2))
colnames(mean_std_data_2) <- gsub("mean", "Mean", colnames(mean_std_data_2))
colnames(mean_std_data_2) <- gsub("std", "Std", colnames(mean_std_data_2))
colnames(mean_std_data_2) <- gsub("Gyro", "Gyroscope", colnames(mean_std_data_2))
colnames(mean_std_data_2) <- gsub("Mag", "Magnitude", colnames(mean_std_data_2))
colnames(mean_std_data_2) <- gsub("^f", "Frequency", colnames(mean_std_data_2))
colnames(mean_std_data_2) <- gsub("\\.", "", colnames(mean_std_data_2))

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(reshape2)
activity_subject_f <- interaction(mean_std_data_2$activity, mean_std_data_2$subject)
mean_std_data_3 <- mutate(mean_std_data_2, activity_subject_f = activity_subject_f)
data_melt <- melt(mean_std_data_3, id = c("subject", "activity", "activity_subject_f"), measure.vars = c(colnames(mean_std_data_3)[1:66]))
activity_subject_mean <- dcast(data_melt, activity_subject_f ~ variable, mean)
rownames(activity_subject_mean) <- activity_subject_mean$activity_subject_f
activity_subject_mean <- activity_subject_mean[,2:67]

#write result table to file
write.table(activity_subject_mean, file="result_mean.txt", row.names=F)
