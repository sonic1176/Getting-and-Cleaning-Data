library(reshape2)
library(dplyr)

run_analysis <- function() {
    # load relevant Labels from csv-Files for activities and features
    activityLabel <- read.csv("./UCI HAR Dataset/activity_labels.txt", header=F, sep=" ")
    names(activityLabel) <- c("activityID", "activityText")
    activityLabel$activityText <- sub("_", " ", activityLabel$activityText)
    activityLabel$activityText <- tolower(activityLabel$activityText)
    featureLabel <- read.csv("./UCI HAR Dataset/features.txt", header=F, sep=" ")
    names(featureLabel) <- c("featureID", "featureText")
    
    # load test datasets for allocation of activity type and subject
    testActivity <- read.csv("./UCI HAR Dataset/test/y_test.txt", header=F)
    names(testActivity) <- c("activityID")
    testActivity <- merge(testActivity, activityLabel)
    testSubject <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header=F)
    names(testSubject) <- c("subjectID")
    
    # load test data, name them and keep only relevant columns
    testData <- read.table("./UCI HAR Dataset/test/x_test.txt", header=F)
    names(testData) <- featureLabel$featureText
    testData <- testData[, grep("std\\(\\)|mean\\(\\)", names(testData))]
    
    # merge tables to a complete table for Test Data
    testActivity <- cbind(datasource=c("Test Data"), testActivity, testSubject, testData)
    
    # repeat for train data - load test datasets for allocation of activity type and subject
    trainActivity <- read.csv("./UCI HAR Dataset/train/y_train.txt", header=F)
    names(trainActivity) <- c("activityID")
    trainActivity <- merge(trainActivity, activityLabel)
    trainSubject <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header=F)
    names(trainSubject) <- c("subjectID")
    
    trainData <- read.table("./UCI HAR Dataset/train/x_train.txt", header=F)
    names(trainData) <- featureLabel$featureText
    trainData <- trainData[, grep("std\\(\\)|mean\\(\\)", names(trainData))]
    
    trainActivity <- cbind(datasource=c("Train Data"), trainActivity, trainSubject, trainData)
    
    # concat datasets
    cdata <- rbind(trainActivity, testActivity)
    

    # reshape data
    cdata <- melt(cdata, id.vars=c(1:4), measure.vars=(5:70))
    
    # aggregate data
    gb <- group_by(cdata, variable, activityID, activityText, subjectID)
    result <- summarize(gb, meanValue=mean(value))
    
    # write to file
    write.table(result, "output.txt", row.names = F)
}
