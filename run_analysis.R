# load the train data from the UCI HAR Dataset
x<-read.table("UCI HAR Dataset/train/X_train.txt")
y<-read.table("UCI HAR Dataset/train/y_train.txt")
trainsubjects<-read.table("UCI HAR Dataset/train/subject_train.txt")

# load the features table
features<-read.table("UCI HAR Dataset/features.txt",stringsAsFactors=F)

# designate the columns for extraction. This was determined
# by looking at the features.txt file 
statcols<-c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,
            125,126,161,161,163,164,165,166,201,202,214,215,227,228,240,241,
            253,254,255,266,267,268,269,270,271,345,346,347,348,349,350,
            424,425,426,427,428,429,503,504,516,517,529,530,542,543)

# Extract only those values that are a mean or std measurement. 
trainx<-NULL
for (a in 1:67){
  temp<-x[,statcols[a]]
  trainx<-cbind(trainx,temp)
}

# Merge the train files
train<-cbind(trainsubjects,y,trainx)

# load the test data from the UCI HAR Dataset
x<-read.table("UCI HAR Dataset/test/X_test.txt")
y<-read.table("UCI HAR Dataset/test/y_test.txt")
testsubjects<-read.table("UCI HAR Dataset/test/subject_test.txt")

# Extract only those values that are a mean or std measurement. 
testx<-NULL
for (a in 1:67){
  temp<-x[,statcols[a]]
  testx<-cbind(testx,temp)
}

# Merge the train files
test<-cbind(testsubjects,y,testx)

# Merge the train and test files
alldata<-rbind(train,test)

# load the labels for the activities
activities<-read.table("UCI HAR Dataset/activity_labels.txt")

# put a label in the merged dataset that identifies each activity type
for (a in 1:6){
  temp<-alldata[,2]==activities[a,1]
  alldata[temp,70]=activities[a,2]
}

# extract labels to use as column names
featurelabels<-NULL
for (a in 1:67){
  featurelabels[a]<-features[statcols[a],2]
}

# add names to featurelabels to account for y data added
featurelabels<-c("Subjects","activity_code",featurelabels,"activity_Label")

#assign column names to variables
colnames(alldata)<-featurelabels

# output the table of merged data to a text file  
write.table(alldata, file="merged_train_test_data.txt", sep=",", row.names=F)

# load the reshape2 library in order to melt data
library(reshape2)

# Extract the data by subject and activity
MeltData<-melt(alldata,id=c("Subjects", "activity_code","activity_Label"))

# Take the means of each subject by activity
DataMeans<-dcast(MeltData,Subjects + activity_Label ~variable, fun.aggregate=mean)

# output the data means in a table
write.table(DataMeans, file="Subject_Activity_Means.txt", sep=",", row.names=F)