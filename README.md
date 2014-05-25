CleanData
=========

Course Project from Coursera Getting and Cleaning Data
Harmon Brown
=========

The run_analysis.R program takes data downloaded from the UCI HAR Dataset.  The study details can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Once the data was input into the local directory the data from the training and testing set of subjects are loaded into R.
The columns containing only the means and standard deviations of each measurement were extracted and merged with their acitivy and subject ids.  The columns with means and standard deviations were determined by looking through the features table.  An activity label is added to the file as well.  I added column names extracted from the features table.  This merged data is then written out as a column-delimited text file named "merged_train_test_data.txt".  

Another table was needed to complete this project.  The merged data set is melted using subject id, activity id, and activity label and the means of the activity by subjects is calculated.  This table of means is then output as a comma-delimited text file named "Subject_Activity_Means.txt".
