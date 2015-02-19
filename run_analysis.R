#Getting and Cleaning Data Jan-Feb 2015 - Coursera course project 

setwd("C:\\Users\\asnaghip\\Desktop\\In treno\\Getting and Cleaning Data\\Course Project")

# url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(url,"dati.zip")
# dateDownload<-date()

library(data.table)
library(dplyr)
library(reshape2)

zipdir <- tempfile()
# Create the dir using that name
dir.create(zipdir)
# Unzip the file into the dir
unzip("dati.zip", exdir=zipdir)


files <- list.files(paste(zipdir,"\\UCI HAR Dataset",sep=""))
activity_labels <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\activity_labels.txt",sep=""),
                                         stringsAsFactor=F))
features        <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\features.txt",sep=""),
                                         stringsAsFactor=F))

#TRAIN

files <- list.files(paste(zipdir,"\\UCI HAR Dataset\\train",sep=""))

X_train         <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\X_train.txt",sep="")))
subject_train   <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\subject_train.txt",sep="")))
y_train         <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\y_train.txt",sep="")))

# files <- list.files(paste(zipdir,"\\UCI HAR Dataset\\train\\Inertial Signals",sep=""))
# 
# body_acc_x_train        <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\Inertial Signals\\body_acc_x_train.txt",sep="")))
# body_acc_y_train        <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\Inertial Signals\\body_acc_y_train.txt",sep="")))
# body_acc_z_train        <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\Inertial Signals\\body_acc_z_train.txt",sep="")))
# 
# body_gyro_x_train       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_x_train.txt",sep="")))
# body_gyro_y_train       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_y_train.txt",sep="")))
# body_gyro_z_train       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_z_train.txt",sep="")))
# 
# total_acc_x_train       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\Inertial Signals\\total_acc_x_train.txt",sep="")))
# total_acc_y_train       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\Inertial Signals\\total_acc_y_train.txt",sep="")))
# total_acc_z_train       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\train\\Inertial Signals\\total_acc_z_train.txt",sep="")))


#TEST

files <- list.files(paste(zipdir,"\\UCI HAR Dataset\\test",sep=""))

X_test         <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\X_test.txt",sep="")))
subject_test   <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\subject_test.txt",sep="")))
y_test         <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\y_test.txt",sep="")))

# files <- list.files(paste(zipdir,"\\UCI HAR Dataset\\test\\Inertial Signals",sep=""))
# 
# body_acc_x_test        <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\Inertial Signals\\body_acc_x_test.txt",sep="")))
# body_acc_y_test        <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\Inertial Signals\\body_acc_y_test.txt",sep="")))
# body_acc_z_test        <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\Inertial Signals\\body_acc_z_test.txt",sep="")))
# 
# body_gyro_x_test       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_x_test.txt",sep="")))
# body_gyro_y_test       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_y_test.txt",sep="")))
# body_gyro_z_test       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_z_test.txt",sep="")))
# 
# total_acc_x_test       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\Inertial Signals\\total_acc_x_test.txt",sep="")))
# total_acc_y_test       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\Inertial Signals\\total_acc_y_test.txt",sep="")))
# total_acc_z_test       <- data.table(read.table(paste(zipdir,"\\UCI HAR Dataset\\test\\Inertial Signals\\total_acc_z_test.txt",sep="")))


unlink(zipdir, recursive = T)
rm(list=c("files","zipdir"))





#1. Merges the training and the test sets to create one data set.

tables()
#561 features
#30 volunteers
#128 readings/window
#each coloumn of X_train is a feature

ls()
X       <- rbind(X_train,X_test)
y       <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test)

# body_acc_x <- rbind(body_acc_x_train,body_acc_x_test)
# body_acc_y <- rbind(body_acc_y_train,body_acc_y_test)
# body_acc_z <- rbind(body_acc_z_train,body_acc_z_test)
# 
# body_gyro_x <- rbind(body_gyro_x_train,body_gyro_x_test)
# body_gyro_y <- rbind(body_gyro_y_train,body_gyro_y_test)
# body_gyro_z <- rbind(body_gyro_z_train,body_gyro_z_test)
# 
# total_acc_x <- rbind(total_acc_x_train,total_acc_x_test)
# total_acc_y <- rbind(total_acc_y_train,total_acc_y_test)
# total_acc_z <- rbind(total_acc_z_train,total_acc_z_test)

rm(list=c("body_acc_x_test","body_acc_x_train","body_acc_y_test",
          "body_acc_y_train","body_acc_z_test","body_acc_z_train","body_gyro_x_test", 
          "body_gyro_x_train","body_gyro_y_test","body_gyro_y_train","body_gyro_z_test", 
          "body_gyro_z_train","subject_test","subject_train","total_acc_x_test",
          "total_acc_x_train","total_acc_y_test","total_acc_y_train",
          "total_acc_z_test","total_acc_z_train","X_test","X_train","y_test","y_train"))

#2. Appropriately labels the data set with descriptive variable names. 
features[,names:=gsub("\\(","",V2)]
features[,names:=gsub("\\)","",names)]
features[,names:=gsub("-|,","",names)]
setnames(X,names(X),features$names)


#3. Extracts only the measurements on the mean and standard deviation for each measurement.
subset<-select(X, grep("mean\\()|std\\()",features$V2))


#4. Uses descriptive activity names to name the activities in the data set
y[,V1:=factor(V1)]
levels(y$V1)<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
               "SITTING","STANDING","LAYING")

 

#5. From the data set in step 4, creates a second, independent tidy data 
#   set with the average of each variable for each activity and each subject
setnames(subject,names(subject),"subject")
setnames(y,names(y),"activity")
data<-cbind(subject, y, subset)

tidyDT<-data[,lapply(.SD, mean),by=.(subject,activity)]

melt<-melt(tidyDT,id=c("subject","activity"),measure.vars=names(tidyDT)[-c(1,2)])
setnames(melt, names(melt)[3:4], c("feature","mean"))
melt<-arrange(melt,subject, activity)

write.table(melt, file="tidyDT.txt", row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
