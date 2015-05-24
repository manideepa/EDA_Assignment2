Load the libraries data.table and dplyr

The files features.txt and activity_labels.txt contain the metadata about the data and are loaded first. featureNames and activityLabels are the datasets created.

Read the training and test data files one by one using read.table. Six datasets are created subjectTrain, activityTrain, featuresTrain, subjectTest, activityTest, featuresTest. 

Start by merging the datasets of subject, activity and features for training and test datasets. rbind is used. We have 3 datasets now - subject, activity and features

The column names of features are taken from the metadata file features.txt. The corresponding dataset is featureNames. There is only one column for activity and subject and hence named indivudually.

Once again now merge the datasets of subject, activity and features for training and test datasets using cbind. We have now one dataset completeData. 

Then extract only the columns which contain mean or STD data. We have one dataset now columnsWithMeanSTD. This is combined with the activity and subject colums. We have one new dataset now called requiredColumns.

Then we extract only the data corresponding the the columns in the step above. We have a new dataset allData now.

The allData's activity data is given meaningful names.

Appropiate labels are assigned.

Then average of each subject for each acivity is taken and written to a file tidyData.txt. 


