library(plyr)
setwd("d:/Data Science/data/UCI HAR Dataset/")
feature <- read.table("features.txt",header=F)
activitylab <- read.table("activity_labels.txt",header=F)
subjecttrain <- read.table("train/subject_train.txt",header=F)
xtrain <- read.table("train/x_train.txt", header=F)
ytrain <- read.table("train/y_train.txt",header=F)
subjecttest <- read.table("test/subject_test.txt",header=F)
xtest <- read.table("test/x_test.txt",header=F)
ytest <- read.table("test/y_test.txt", header=F)
colnames(activitylab) <- c("activityID","activity")
colnames(subjecttrain) <- c("subjectID")
colnames(xtrain) <- feature[,2]
colnames(ytrain) <- "activityID"
colnames(subjecttest) <- "subjectID"
colnames(xtest) <- feature[,2]
colnames(ytest) <- "activityID"
trainingData <- cbind(ytrain, subjecttrain, xtrain)
testData <- cbind(ytest,subjecttest,xtest)
Data <- rbind(trainingData,testData)
colname <- colnames(Data)
logicalV = (grepl("activity..",colname) | grepl("subject..",colname) | grepl("-mean..",colname) & !grepl("-meanFreq..",colname) & !grepl("mean..-",colname) | grepl("-std..",colname) & !grepl("-std()..-",colname))
Data <- Data[logicalV==TRUE]
Data <- merge(Data,activitylab,by='activityID',all.x=TRUE)
colname <- colnames(Data)
colname
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
colnames(Data) <- colname
Data_no_act <- Data[,names(Data)!='activity']
Tidy_Data <- aggregate(Data_no_act[,names(Data_no_act)!= c('activityID','subjectID')],by=list(activityID=Data_no_act$activityID,subjectID=Data_no_act$subjectID),mean)
View(Tidy_Data)
write.table(Tidy_Data, 'tidyData.txt',row.name=FALSE,sep='\t');