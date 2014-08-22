# Getting and Cleaning Data -Course Project
Brian Erickson

## Introduction
The data for the project was retrieved from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

See README.txt from the above zip file for a description of the source data including attribution.

It should be unzipped in the same folder as the data script run_analysis.R.

## Data Script

All data transformations are performed using the R script run_analysis.R.

This script will produce an average of key variables by subject and activity and output into the file averages.csv.

The script has the below flow:

* features are read from 'features.txt' and given R friendly names with gsub
* test and train data are read read.table and then combined with rbind
* columns are restricted to means and standard deviations by matching column names
* activty labels are added by reading and merging 'activity_labels.txt'
* ddply and colMeans are used to calculate means of features
* averages datatable is reshaped and given proper labels using melt, merge subset operators.
* final CSV is output as averages.csv

## Code Book
The code book is provided in the file [CodeBook.md](CodeBook.md) to define the output data set
