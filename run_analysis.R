
#0-Download the data

#String variables to download the data

fileFA <- "getdata_projectfiles_UCI HAR Dataset.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "getdata_projectfiles_UCI HAR Dataset"

#Checks if the zip file is already in the WD and dowloads it.

if(!file.exists(fileFA)){
       download.file(url, fileFA)

}

#Checks if the unzipped file exists and unzips it. 

if(!file.exists(dir)){
       unzip("getdata_projectfiles_UCI HAR Dataset.zip")
}

#Reads the tables in the unziped file

X_test <-read.table("UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")


#1-Creates one data set from from the tables

#Merging of training and testing tables into data sets. 

datasetx <- rbind(X_train,X_test)
datasety <- rbind(y_train, y_test)
subject <-  rbind(subject_train,subject_test)

#Merging of the previously formed data sets into one. 

DataSet1 <- cbind(subject,datasety,datasetx)


#2-Apart from the first and second column, removes all variables that don't contain mean or standard deviation values and
#stores the result in a new data frame.

#Identifies which names in  "features" contain  "std" or "mean" in their names.
MeanandStd <- grep("mean|std", features[, 2]) 

#"Features" contains the column names for the "X" data sets, not the whole data frame. So to get the location of the variables that are
#means and std in "DataSet1", all values in "MeanandStd" had to be increased by 2. 
DSmeanstd <- MeanandStd + (ncol(DataSet1) - ncol(datasetx))

#Saves the new data set with only the "mean" and "std" columns in 'DataSet2'.
DataSet2 <- DataSet1[,c(1,2,DSmeanstd)]



#3-Changes the numeric value in column 2 into character factors.
activity <- as.factor(DataSet2[,2])
levels(activity) <- activity_labels[,2]
DataSet2[,2] <- activity


#4-Assigns names to all the columns.
names(DataSet2)[1] <- "subject"
names(DataSet2)[2] <- "activity"
names(DataSet2)[3:ncol(DataSet2)]<- as.character(features[MeanandStd,2])
#Result:
#DataSet2
#5 - Melt data to four column and cast the means. 

library(reshape2)
SecondData1 <- melt(DataSet2,(id.vars=c("subject","activity")))
SecondData2<-dcast(SecondData1, subject + activity ~ variable, mean )
#Result:
#SecondData2
