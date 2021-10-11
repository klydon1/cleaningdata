 ### load libraries
library(dplyr)


#load datasets
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

#set local directory
dest <- '~/Documents/5th Year/Getting and Cleaning Data/UCI.zip'

#download
download.file(url,dest,method='curl')

#assign tables
features <- read.table('~/Documents/5th Year/Getting and Cleaning Data/UCI/features.txt',col.names=c('count','functions'))
activity <- read.table('~/Documents/5th Year/Getting and Cleaning Data/UCI/activity_labels.txt',col.names=c('code','activity'))
subject_test <- read.table('~/Documents/5th Year/Getting and Cleaning Data/UCI/subject_test.txt', col.names = 'subject')
x_test <- read.table('~/Documents/5th Year/Getting and Cleaning Data/UCI/X_test.txt', col.names = features$functions)
y_test <- read.table('~/Documents/5th Year/Getting and Cleaning Data/UCI/y_test.txt', col.names = "code")
subject_train <- read.table('~/Documents/5th Year/Getting and Cleaning Data/UCI/subject_train.txt', col.names = "subject")
x_train <- read.table('~/Documents/5th Year/Getting and Cleaning Data/UCI/X_train.txt', col.names = features$functions)
y_train <- read.table('~/Documents/5th Year/Getting and Cleaning Data/UCI/y_train.txt', col.names = "code")


#now they're all read into our environment

###Step 1: Merge into one dataset

#merge the Xs (both test and train)
X_data <- rbind(x_test,x_train)

#merge the ys
y_data <- rbind(y_test,y_train)

#merge the subject
subject_data <- rbind(subject_test,subject_train)

#put it all together!
df <- cbind(X_data,y_data,subject_data)

### Step 2: Select Mean and Standard Deviation measures
#now we need to use the select function
#only want mean and std
df_tidier <- select(df,subject,code,contains('mean'),contains('std'))


### Steps 3 and 4: tidy up the variables
df_tidier$code <- activity[df_tidier$code, 2]

#ones starting with t should be 
names(df_tidier) <- gsub("^t", "Time", names(df_tidier))

#starting with f go to Freq
names(df_tidier) <- gsub("^f", "Freq", names(df_tidier))

#no double body
names(df_tidier) <- gsub("^BodyBody", "Body", names(df_tidier))

#set all to lowercase
names(df_tidier) <- tolower(names(df_tidier))


### Step 5: New dataset with means
df_tidiest <- df_tidier %>% group_by(subject,code) %>%
  summarize_all(funs(mean))




