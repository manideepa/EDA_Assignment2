#Load libraries
library(data.table)
library(dplyr)

#Read supporting metadata
featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

#Read training data

subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

#Read test data

subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

#Merge dataset - Part 1
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

#Name columns

colnames(features) <- t(featureNames[2])

#Merge everything

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)

#Mean and Std Dev columns - Part 2

columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

#Reqd columns
requiredColumns <- c(columnsWithMeanSTD, 562, 563)

#Extract Reqd data

allData <- completeData[,requiredColumns]

#Descriptions - Part 3
allData$Activity <- as.character(allData$Activity)
for (i in 1:6){
  allData$Activity[allData$Activity == i] <- as.character(activityLabels[i,2])
}

allData$Activity <- as.factor(allData$Activity)

#Appropriate labels - Part 4



names(allData)<-gsub("Acc", "Accelerometer", names(allData))
names(allData)<-gsub("Gyro", "Gyroscope", names(allData))
names(allData)<-gsub("BodyBody", "Body", names(allData))
names(allData)<-gsub("Mag", "Magnitude", names(allData))
names(allData)<-gsub("^t", "Time", names(allData))
names(allData)<-gsub("^f", "Frequency", names(allData))
names(allData)<-gsub("tBody", "TimeBody", names(allData))
names(allData)<-gsub("-mean()", "Mean", names(allData), ignore.case = TRUE)
names(allData)<-gsub("-std()", "STD", names(allData), ignore.case = TRUE)
names(allData)<-gsub("-freq()", "Frequency", names(allData), ignore.case = TRUE)
names(allData)<-gsub("angle", "Angle", names(allData))
names(allData)<-gsub("gravity", "Gravity", names(allData))



#Average of each variable for each activity and each subject - Part 5


allData$Subject <- as.factor(allData$Subject)
allData <- data.table(allData)
tidyData <- aggregate(. ~Subject + Activity, allData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
