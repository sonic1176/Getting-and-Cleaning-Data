library(reshape2)
library(dplyr)

run_analysis <- function() {
    # 1. Load relevant Labels from csv-Files for activities and features
    activityLabel <- read.csv("./UCI HAR Dataset/activity_labels.txt", header=F, sep=" ")
    names(activityLabel) <- c("activityID", "activityText")
    activityLabel$activityText <- sub("_", " ", activityLabel$activityText)
    activityLabel$activityText <- tolower(activityLabel$activityText)
    featureLabel <- read.csv("./UCI HAR Dataset/features.txt", header=F, sep=" ")
    names(featureLabel) <- c("featureID", "featureText")
    
    # 2. Load test datasets for allocation of activity type and subject
    testActivity <- read.csv("./UCI HAR Dataset/test/y_test.txt", header=F)
    names(testActivity) <- c("activityID")
    testActivity <- merge(testActivity, activityLabel)
    testSubject <- read.csv("./UCI HAR Dataset/test/subject_test.txt", header=F)
    names(testSubject) <- c("subjectID")
    
    # 3. Load test data, name them and keep only relevant columns
    testData <- read.table("./UCI HAR Dataset/test/x_test.txt", header=F)
    names(testData) <- featureLabel$featureText
    testData <- testData[, grep("std\\(\\)|mean\\(\\)", names(testData))]
    
    # 4. Merge tables to a complete table for Test Data
    testActivity <- cbind(datasource=c("Test Data"), testActivity, testSubject, testData)
    
    # 5. Repeat for train data - load test datasets for allocation of activity type and subject
    trainActivity <- read.csv("./UCI HAR Dataset/train/y_train.txt", header=F)
    names(trainActivity) <- c("activityID")
    trainActivity <- merge(trainActivity, activityLabel)
    trainSubject <- read.csv("./UCI HAR Dataset/train/subject_train.txt", header=F)
    names(trainSubject) <- c("subjectID")
    
    trainData <- read.table("./UCI HAR Dataset/train/x_train.txt", header=F)
    names(trainData) <- featureLabel$featureText
    trainData <- trainData[, grep("std\\(\\)|mean\\(\\)", names(trainData))]
    
    trainActivity <- cbind(datasource=c("Train Data"), trainActivity, trainSubject, trainData)
    
    # 6. Concat datasets
    cdata <- rbind(trainActivity, testActivity)
    

    # 7. Reshape data
    cdata <- melt(cdata, id.vars=c(1:4), measure.vars=(5:70))
    
    # 8. Aggregate data
    gb <- group_by(cdata, variable, activityID, activityText, subjectID)
    result <- summarize(gb, meanValue=mean(value))
    
    # 9. Write to file
    write.table(result, "output.txt", row.names = F)
}
