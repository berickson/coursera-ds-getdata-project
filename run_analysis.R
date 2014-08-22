# You should create one R script called run_analysis.R that does the following. 
# (steps out of order for simplified processing) 

# 4. Appropriately labels the data set with descriptive variable names. 
features <- read.table('features.txt',row.names=1,col.names=c('number','feature'))

# get rid of funny characters in feature names
#features$name = gsub("[\\(\\)\\.\\-\\,]","",features$feature,fixed=FALSE)
features$name = gsub("[^a-zA-Z0-9 ]","",features$feature,fixed=FALSE)

X_test <- read.table('test/X_test.txt', col.names=features$name)
X_train <- read.table('train/X_train.txt', col.names=features$name)

subject_train <- read.table('train/subject_train.txt', col.names='subject')
subject_test <- read.table('test/subject_test.txt', col.names='subject')


Y_test <- read.table('test/Y_test.txt', col.names='activity')
Y_train <- read.table('train/Y_train.txt', col.names='activity')

# 1. Merges the training and the test sets to create one data set.
X <- rbind(X_test,X_train)
Y <- rbind(Y_test,Y_train)
subject <- rbind(subject_test,subject_train)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
stds <- lapply(features$feature,grepl,pattern='std\\(')
means <- lapply(features$feature,grepl,pattern='mean\\(') # puposely excluding meanFreq
stdsOrMeans <- means==TRUE | stds== TRUE
subFeatures = features[stdsOrMeans,]
Xsub <- X[,subFeatures$name]

D <- cbind(subject,Y,Xsub)

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table('activity_labels.txt',col.names=c('activity','activity_label'))
D<-merge(activity_labels,D)
D <- subset(D, select = -c(activity))

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

library(plyr)
averages_wide <- ddply(D,c('activity_label','subject'),function(x) colMeans(x[,subFeatures$name]))

library(reshape)
averages <- melt(averages_wide,id=c('activity_label','subject'), variable_name='name')
averages <- rename(averages,c('value'='average'))
averages <- merge(averages,features)
averages <- averages[,c('subject','activity_label','feature','average')]
# Please upload the tidy data set created in step 5 of the instructions. 
# Please upload your data set as a txt file created with write.table() 
# using row.name=FALSE (do not cut and paste a dataset directly into the
# text box, as this may cause errors saving your submission).
write.csv(averages, file='averages.txt', row.names=FALSE)
