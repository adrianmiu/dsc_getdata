# Code Book

## Data import

Download the file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and copy the content of the `UCI HAR Dataset` folder from the archive into the `dataset` folder (the script expects the files there).


## Data summary

The raw data files containing the observations are organized in 2 folders:

- `dataset/train` containing the dataset for training
- `dataset/test` containing the dataset for testing

Each of these folders contain 3 files have the following data

1. The subjects for each observation
2. The activity ID for each observation
3. The observations

Important! The data for the observations (ie: the features) were normalized and bounded between [-1,1]

The features that are observed are listed in the `dataset/features.txt` file

The labels for the activities are listed in the `dataset/activity_labels.txt`

## Data processing steps

1. The columns for the tidy dataset are compiled from different sources
2. The test and training data files are read and combined into a single data frame
3. The test and train data frames are filtered. Only the subject, activity plus the mean and standard deviantion columns for all observations are preserved.
4. Data columns are converted to numeric (from character)
5. The test and train data are merged into the final data frame

