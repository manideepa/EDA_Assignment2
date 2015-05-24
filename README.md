# EDA_Assignment2
Description

The requirements are:

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive activity names.
    Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Process    
    The file is downloaded to the R working directory and extracted here under the folders UCI HAR Dataset. 
    The data in the text file is read into R with data.table
    The data is merged with the rbind and cbind functions
    The grep function is used to extract columns which have Mean or STD in their names
    The write.table function is used to write a text file which is uploaded. 
