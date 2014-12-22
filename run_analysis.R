### Run analysi
### To merge data
setwd("D:/Rworking/work/Data_cleaning/work/UCI HAR Dataset")
train_set <- read.table("./train/X_train.txt", header = F)
train_label <- read.table("./train/y_train.txt", header = F)
train_subject <- read.table("./train/subject_train.txt", header = F)
test_set <- read.table("./test/X_test.txt", header = F)     
test_label <- read.table("./test/y_test.txt", header = F)
test_subject <- read.table("./test/subject_test.txt", header = F)
## bind the data
join_set <- rbind(train_set, test_set)
join_label <- rbind(train_label, test_label)
join_subject <- rbind(train_subject, test_subject)

### task-2 
##Extracts only the measurements on the mean and standard deviation for each measurement. 
features <- read.table("features.txt", header = F)
head(features)
mean_Std_Indices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
mean_Std_Indices

### Task-3
# Uses descriptive activity names to name the activities in the data set.
activity_names <- read.table("activity_labels.txt")
join_label[,1] <- activity_names[join_label[,1],2]
names(join_label) <- "activity"

### Task-4
#Appropriately label the data set with descriptive variable names
names(join_subject) <- "subject"
final_data <- cbind(join_set, join_label, join_subject)
write.table(final_data, "final_data_set.txt")

### Task-5
# Step 5
# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
mean_data <- ddply(final_data, .(subject,activity), function(x)colMeans(x[,1:66]))
write.table(mean_data, "mean_data.txt")
