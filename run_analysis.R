library(plyr)
#Setting the working directory
setwd("d:/Data Science/data/UCI HAR Dataset/")
#reading all files
feature <- read.table("features.txt",header=F)
activitylab <- read.table("activity_labels.txt",header=F)
subjecttrain <- read.table("train/subject_train.txt",header=F)
xtrain <- read.table("train/x_train.txt", header=F)
ytrain <- read.table("train/y_train.txt",header=F)
subjecttest <- read.table("test/subject_test.txt",header=F)
xtest <- read.table("test/x_test.txt",header=F)
ytest <- read.table("test/y_test.txt", header=F)
#Giving proper column names for further analysis
colnames(activitylab) <- c("activityID","activity")
colnames(subjecttrain) <- c("subjectID")
colnames(xtrain) <- feature[,2]
colnames(ytrain) <- "activityID"
colnames(subjecttest) <- "subjectID"
colnames(xtest) <- feature[,2]
colnames(ytest) <- "activityID"
#creating test and training data sets and combinig them to make 1 Data
trainingData <- cbind(ytrain, subjecttrain, xtrain)
testData <- cbind(ytest,subjecttest,xtest)
Data <- rbind(trainingData,testData)
colname <- colnames(Data)
#logical vector to select just the means and stddevs
logicalV = (grepl("activity..",colname) | grepl("subject..",colname) | grepl("-mean..",colname) & !grepl("-meanFreq..",colname) & !grepl("mean..-",colname) | grepl("-std..",colname) & !grepl("-std()..-",colname))
#subsetting using the above logical vector
Data <- Data[logicalV==TRUE]
#merging the above data set with the activity_labels to give discriptive activity names
Data <- merge(Data,activitylab,by='activityID',all.x=TRUE)
#colname vector to include new column names after the data has been merged
colname <- colnames(Data)
#check the present colnames for further analysis
colname
#loop for changing the variable name to much understandable format
#cleaning the varible names using a loop
for (i in 1:length(colname)) 
{
  colname[i] = gsub("\\()","",colname[i])
  colname[i] = gsub("-std$","StdDev",colname[i])
  colname[i] = gsub("-mean","Mean",colname[i])
  colname[i] = gsub("^(t)","Time",colname[i])
  colname[i] = gsub("^(f)","freq",colname[i])
  colname[i] = gsub("([Gg]ravity)","Gravity",colname[i])
  colname[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colname[i])
  colname[i] = gsub("[Gg]yro","Gyro",colname[i])
  colname[i] = gsub("AccMag","AccMagnitude",colname[i])
  colname[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colname[i])
  colname[i] = gsub("JerkMag","JerkMagnitude",colname[i])
  colname[i] = gsub("GyroMag","GyroMagnitude",colname[i])
}
#changing the column names in the Data
colnames(Data) <- colname
#removing the activity column in the Data set
Data_no_act <- Data[,names(Data)!='activity']
#creating an independent tidy data set with the average of each variable for each activity and each subject.
Tidy_Data <- aggregate(Data_no_act[,names(Data_no_act)!= c('activityID','subjectID')],by=list(activityID=Data_no_act$activityID,subjectID=Data_no_act$subjectID),mean)
View(Tidy_Data)
#creating tidyData.txt for uploading
write.table(Tidy_Data, 'tidyData.txt',row.name=FALSE,sep='\t');