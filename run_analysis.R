# Objectives of this Script as per the given problem includes the following steps :
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

# Loaded the reshape library to be used for file manipulation later in the stage.
library(reshape2)

# Objective 1 : Merges the training and the test sets to create one data set.

# Start reading the data


# train dataset from UCI HAR Dataset/train/*
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
# test dataset from UCI HAR Dataset/test/*
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# features dataset from UCI HAR Dataset/
features <- read.table("UCI HAR Dataset/features.txt")



#add labels in the read files

names(subject_train) <- "subject_id"
names(x_train) <- features$V2
names(y_train) <- "activity"

names(subject_test) <- "subject_id"
names(x_test) <- features$V2
names(y_test) <- "activity"

# Merge the training and test data set

merged_train <- cbind(subject_train, y_train, x_train)
merged_test <- cbind(subject_test, y_test, x_test)
merged_all <- rbind(merged_train, merged_test)

#############################################################
################## Objective 1 Completed ####################
#############################################################

# Objective 2 : Extracts only the measurements on the mean and standard 
#               deviation for each measurement.

# find the required columns to be considered 
# (mean and standard deviation columns)
mean_std_col <- grepl("mean\\(\\)", names(merged_all)) | 
        grepl("std\\(\\)", names(merged_all))
# keep the id and activity column as a part of filtered column
mean_std_col[1:2] <- TRUE

# extract required subset of all merged data
clean_data <- merged_all[,mean_std_col]

#############################################################
################## Objective 2 Completed ####################
#############################################################

# Objective 3 : Uses descriptive activity names to name the activities in the data set

# Convert to factor from integer
clean_data$activity <- factor(clean_data$activity, labels=c("Walking",
                                                        "Walking Upstairs", 
                                                        "Walking Downstairs", 
                                                        "Sitting", "Standing", 
                                                        "Laying"))

# Objective 4 : Appropriately labels the data set with descriptive variable names.
#               As a part of Objective 3 is taken care.

#############################################################
################# Objective 3,4 Completed ###################
#############################################################


# Objective 5. From the data set in step 4, creates a second, independent 
# tidy data set with the average of each variable for each activity and each subject.

data <- melt(clean_data, id=c("subject_id","activity"))
tidy <- dcast(data, subject_id+activity ~ variable, mean)

# write the tidy data set to a file barring the row names
write.csv(tidy, "tidy.txt", row.names=FALSE)

#write.csv(tidy, "tidy.csv", row.names=FALSE)

#############################################################
################## Objective 5 Completed ####################
#############################################################