# Script for the Coursera's "Getting and Cleaning Data" course project
#
library('tidyr')
library('dplyr')

# prepare the column names for the data
features <- read.csv2('dataset/features.txt', sep="", header=FALSE)[, -1]
# replace the unwanted characters from the features (beautify the colum names)
features <- gsub('[^a-zA-Z0-9]+', '_', features)
colNames <- c('subject', 'activity', as.character(features))

raw.test <- cbind(read.csv2('dataset/test/subject_test.txt', sep='', header=FALSE), 
                        read.csv2('dataset/test/y_test.txt', sep='', header=FALSE),
                        read.csv2('dataset/test/X_test.txt', sep='', header=FALSE, stringsAsFactors=FALSE))

raw.train <- cbind(read.csv2('dataset/train/subject_train.txt', sep='', header=FALSE), 
                  read.csv2('dataset/train/y_train.txt', sep='', header=FALSE),
                  read.csv2('dataset/train/X_train.txt', sep='', header=FALSE, stringsAsFactors=FALSE))

# apply the column names to the data frames
colnames(raw.test) <- colNames
colnames(raw.train) <- colNames

# after removing the unwanted column, wrap the filtered data frames into table data frames
raw.test <- tbl_df(raw.test[, colNames[grep('subject|activity|mean|std', colNames)]])
raw.train <- tbl_df(raw.train[, colNames[grep('subject|activity|mean|std', colNames)]])

# convert the data columns to numeric
dataCols <- colnames(raw.test)[-(1:2)]
for(col in dataCols) {
  raw.test[[col]] <- as.numeric(raw.test[[col]])
  raw.train[[col]] <- as.numeric(raw.train[[col]])
}

# combine the test and train data frames
raw.all <- rbind.data.frame(raw.test, raw.train)

raw.all %>%
  group_by(activity, subject) %>%
  summarise_each('mean') %>%
  write.table(file='tidy.txt')
