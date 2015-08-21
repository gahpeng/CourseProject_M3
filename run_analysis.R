install.packages("reshape2")
require(reshape2)
setwd("C:\gahpeng/coursera/03_Getting and Cleaning Data")
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, mode="wb")
  unzip(filename) 
}

##Read lables of dataset
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

##Take dataset lables which contain only mean or standard deviation
myFeatures <- grep(".*mean.*|.*std.*", features[,2])
myFeatures.names <- features[myFeatures,2]

##Rename the lable to more meaningful name
myFeatures.names = gsub('-mean', 'Mean', myFeatures.names)
myFeatures.names = gsub('-std', 'Std', myFeatures.names)
myFeatures.names <- gsub('[-()]', '', myFeatures.names)

# Load the training datasets for column contain mean or standard deviation 
train <- read.table("UCI HAR Dataset/train/X_train.txt")[myFeatures]
trainY <- read.table("UCI HAR Dataset/train/Y_train.txt")

##Read subject training dataset and merge them
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects,trainY,train)

# Load the test datasets for column contain mean or standard deviation
test <- read.table("UCI HAR Dataset/test/X_test.txt")[myFeatures]
testY <- read.table("UCI HAR Dataset/test/Y_test.txt")

##Read subject test dataset and merge them
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects,testY, test)

#Merge required training and test dataset, and rename column
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", myFeatures.names)

# turn activities & subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData.melted <- melt(data=allData, id = c("subject", "activity"))

#average of each variable for each activity and each subject
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

#create independent tidy data set and write to text
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)