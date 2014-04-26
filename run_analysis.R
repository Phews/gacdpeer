

########################################################################33
## Prepare activity and feature data
##

activityLabels <- read.table("./activity_labels.txt", sep=" ",row.names=NULL)
colnames(activityLabels) <- c("activity_id", "activity")

features <- read.table("./features.txt", sep=" ")
colnames(features) <- c("feature_id", "feature")

##clean names of the attributes
features$feature <- gsub( "-", "_", gsub( "[(),]", "", features$feature ), fixed=TRUE )

##prepare to take only columns where std or mean is being used
includedFeatures <- grepl( "std|mean", features$feature, ignore.case=TRUE)
includedColumns <- ifelse( includedFeatures, as.character( features[[2]] ), "NULL" )

##null is used for excluding not-wanted columns
columnClasses <- ifelse( includedFeatures, "numeric", "NULL")

########################################################################33
## Read train data
##

trainSubjects <- read.csv( "train/subject_train.txt", row.names=NULL, col.names = c("subject_id"), header=FALSE)
trainActivityId <- read.csv( "train/Y_train.txt", row.names=NULL, col.names=c("activity_id"), header=FALSE)

trainFeatures <- read.table( "train/X_train.txt", header=FALSE, row.names=NULL, colClasses = columnClasses, col.names=includedColumns )

trainFeatures <- cbind( trainFeatures, trainSubjects )

trainData <- cbind( trainFeatures, trainActivityId )

########################################################################
## Read test data
##


testSubjects <- read.csv( "test/subject_test.txt", row.names=NULL, col.names = c("subject_id"), header=FALSE)
testActivityId <- read.csv( "test/Y_test.txt", row.names=NULL, col.names=c("activity_id"), header=FALSE)

testFeatures <- read.table( "test/X_test.txt", header=FALSE, row.names = NULL, colClasses = columnClasses, col.names=includedColumns )

testFeatures <- cbind( testFeatures, testSubjects )

testData <- cbind( testFeatures, testActivityId )


################################################################################
## Combine train and test data
##

traintestData <- rbind( trainData, testData )

finalData <- merge( traintestData, activityLabels )


################################################################################
## Create tidy data set
##

aggData <- aggregate(finalData[,2:87], by=list(finalData$activity,finalData$subject_id), FUN= mean)
colnames(aggData)[1:2]=c("Activity", "Subject_id")


write.table(aggData, "tidydata.txt", sep="\t")


