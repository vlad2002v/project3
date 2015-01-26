
## Script name: run_analysis.R

## PA 1 - Course Project
## Getting and Cleaning Data

## Course ID: getdata-010

## https://class.coursera.org/getdata-010/human_grading
## Go to assignment -> https://class.coursera.org/getdata-010/human_grading/view/courses/973497/assessments/3/submissions


## --------------------------------------------------
## --------------------------------------------------


## PREPARATION of the environment: RStudio software and the computer: 

## Open RStudio

## remove/delete all currently running objects in R 
rm(list = ls())

## set "working directory" ("WD") for this Assignment/Quiz as follows: 
setwd("C:/Users/.../edu-COURSERA - Data Science 3 Getting and Cleaning Data/Coursera-WD - Getting and Cleaning Data/PA 1 - Course Project")
## getwd()


## 
## CREATE FOLDER FOR DATA IN WORKING DIRECTORY 
## 

if (!file.exists("data")) {     ## check if "data" folder does NOT exist in WD 
        dir.create("data")      ## if doesn't exist there 
}                               ## then create "data" folder in WD 

## file.exists("data") ## check if "data" folder does exist in WD 

## --------------------------------------------------
## --------------------------------------------------


## --------------------------------------------------
## --------------------------------------------------

## 
## The purpose of this project is to demonstrate your ability to 
## collect, work with, and clean a data set. 
## The goal is to prepare tidy data that can be used for later analysis. 
## You will be graded by your peers on a series of yes/no questions 
## related to the project. 
## You will be required to submit: 
## 1) a tidy data set as described below, 
## 2) a link to a Github repository with your script for performing the analysis, and 
## 3) a code book that describes the variables, the data, and any transformations or 
## work that you performed to clean up the data called CodeBook.md. 
## You should also include a README.md in the repo with your scripts. This repo 
## explains how all of the scripts work and how they are connected.  
## 
## One of the most exciting areas in all of data science right now is 
## wearable computing - see for example this article. 
## Companies like Fitbit, Nike, and Jawbone Up are racing to 
## develop the most advanced algorithms to attract new users. 
## The data linked to from the course website represent data 
## collected from the accelerometers from the Samsung Galaxy S smartphone. 
## 
## A full description is available at the site where the data was obtained: 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## 
## Here are the data for the project: 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## 
## You should create one R script called run_analysis.R that does the following. 
## 
## 1. Merges the training and the test sets to create one data set. 
## 
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 
## 3. Uses descriptive activity names to name the activities in the data set. 
## 
## 4. Appropriately labels the data set with descriptive variable names. 
## 
## 5. From the data set in step 4, creates a second, independent 
## tidy data set with the average of each variable for each activity and each subject. 
## 
## Good luck!
## 

## --------------------------------------------------
## --------------------------------------------------


fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/UCI_HAR_Dataset.zip", method = "auto")
dateDownloaded <- date()

## ?unzip ## get help on zipfiles
## http://stat.ethz.ch/R-manual/R-devel/library/utils/html/unzip.html
## http://www.r-bloggers.com/read-compressed-zip-files-in-r/

unzip("./data/UCI_HAR_Dataset.zip", exdir = "./data/UCI_HAR_Dataset") ## extract contents from single zip file into "UCI_HAR_DatasetA" folder in WD

## Check contents of the unziped folder 
list.files("./data/UCI_HAR_Dataset/UCI HAR Dataset")


## Review data files: 


## Read in the "activity_labels" file: 
labels <- read.table(paste("./data/UCI_HAR_Dataset/UCI HAR Dataset", 
                                "activity_labels.txt", sep="/"),
                                      col.names=c("labelcode","label"))
## > labels
##   labelcode              label
## 1         1            WALKING
## 2         2   WALKING_UPSTAIRS
## 3         3 WALKING_DOWNSTAIRS
## 4         4            SITTING
## 5         5           STANDING
## 6         6             LAYING
## > 


## Read in the "features.txt" file: 
features <- read.table(paste("./data/UCI_HAR_Dataset/UCI HAR Dataset", 
                                "features.txt", sep="/"))
## > head(features)
##   V1                V2
## 1  1 tBodyAcc-mean()-X
## 2  2 tBodyAcc-mean()-Y
## 3  3 tBodyAcc-mean()-Z
## 4  4  tBodyAcc-std()-X
## 5  5  tBodyAcc-std()-Y
## 6  6  tBodyAcc-std()-Z
## >


## Establish important features: 
importantFeatureIndex <- grep("mean\\(|std\\(", features[,2])


## 
## Read in the files from "train" folder:

trainFolder <- paste("./data/UCI_HAR_Dataset/UCI HAR Dataset", 
                                                "train", sep="/")

trainingSubject <- read.table(paste(trainFolder, 
                                "subject_train.txt", sep="/"),
                                        col.names = "subject")

trainingData <- read.table(paste(trainFolder, 
                                "X_train.txt", sep="/"),
                                        col.names = features[ , 2], 
                                                check.names=FALSE)

trainingData <- trainingData[ , importantFeatureIndex]
## head(trainingData)


trainingLabels <- read.table(paste(trainFolder, 
                                "y_train.txt", sep="/"), 
                                        col.names = "labelcode")
## head(trainingLabels)


df_training <- cbind(trainingLabels, trainingSubject, trainingData)
## head(df_training)


## 
## Read in the files from "test" folder:

testFolder <- paste("./data/UCI_HAR_Dataset/UCI HAR Dataset", 
                                                "test", sep="/")


testSubject <- read.table(paste(testFolder, 
                                "subject_test.txt", sep="/"), 
                                        col.names = "subject")


testData <- read.table(paste(testFolder, 
                                "X_test.txt", sep="/"),
                                        col.names = features[ , 2], 
                                                check.names=FALSE)

testData <- testData[ , importantFeatureIndex]
## head(testData)


testLabels <- read.table(paste(testFolder, 
                                "y_test.txt", sep="/"),
                                        col.names = "labelcode")


df_test <- cbind(testLabels, testSubject, testData)
## head(df_test)

## 
## Merge the "test" folder data = "df_test" object and the "train" folder data = "df_training" object 
## 

DataFrame <- rbind(df_training, df_test)
## head(DataFrame)

## Replace "labelcode" variable in "DataFrame" object with the text labels["labels"]

df <- merge(labels, DataFrame, by.x="labelcode", by.y="labelcode")
df <- df[ , -1]


## Transform the dataset to use label and subject as identifiers

install.packages("reshape2")
library(reshape2)

## ?melt ## get help on melt()
dfMelt <- melt(df, id = c("label", "subject"))


## Produce the tidy dataset with means of each variable for each activitt and each subject 
## ?dcast ## get help on dcast()
dfTidy <- dcast(dfMelt, label + subject ~ variable, mean)
## head(dfTidy)


## temp <- data.frame(features[, 2])
write.table(paste("* ", names(dfTidy), sep=""), 
            file="CodeBook.md", 
            quote = FALSE,
            row.names = FALSE, 
            col.names = FALSE, 
            sep = "\t")



## --------------------------------------------------
## --------------------------------------------------



