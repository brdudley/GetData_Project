## Pull in the required packages for the manipulations
suppressWarnings(require(dplyr))
suppressWarnings(require(tidyr))


## Read in the column names
features<-read.table("data/features.txt", stringsAsFactors=FALSE)$V2

## Select the desired columns -- containing -mean() or -std()
col.numbers<-c(grep("-(mean|std)\\(", features))

## Pull the names for the selected columns and clean them up.
col.names<-features[col.numbers]
col.names<-gsub("^t", "TimeDomain.", col.names)
col.names<-gsub("^f", "FrequencyDomain.", col.names)
col.names<-gsub("-(X|Y|Z)",".\\1Axis", col.names)
col.names<-gsub("BodyBody", "Body", col.names)
col.names<-gsub("BodyAcc", "BodyAccelerometer", col.names)
col.names<-gsub("BodyGyro", "BodyGyroscope", col.names)
col.names<-gsub("Mag", "Magnitude", col.names)
col.names<-gsub("GravityAcc", "GravityAccelerometer", col.names)

## Move the mean or std aggregate to the beginning to split it out later.
col.names<-gsub("(^.*)(-)(std|mean)(\\(\\))(.*)","\\3_\\1\\5",col.names)



## Function to capitalize the component words of the activities.
capitalize<-function(phrase, sep="_"){
        words<-strsplit(phrase, sep)[[1]]
        paste( toupper( substring( words, 1, 1)), tolower(substring( words, 2)),
               sep="", collapse="")
}

## Read and groom the activity list
activities<-read.table("data/activity_labels.txt", stringsAsFactors=FALSE)$V2
activities<-unlist(lapply(activities, capitalize))



## Pull in all the Training Data, combine, and label
train.subject<-tbl_df(read.table("data/subject_train.txt"))
names(train.subject)<-"Subject"

train.activity<-tbl_df(read.table("data/y_train.txt"))
names(train.activity)<-"Activity"

train.data<-tbl_df(read.table("data/X_train.txt"))
train.select<-select(train.data, col.numbers)
names(train.select)<-col.names

train.full<-tbl_df(bind_cols(train.select, train.subject, train.activity))


## Pull in all the Test Data and combine
test.subject<-tbl_df(read.table("data/subject_test.txt"))
names(test.subject)<-"Subject"

test.activity<-tbl_df(read.table("data/y_test.txt"))
names(test.activity)<-"Activity"

test.data<-tbl_df(read.table("data/X_test.txt"))
test.select<-select(test.data, col.numbers)
names(test.select)<-col.names

test.full<-tbl_df(bind_cols(test.select, test.subject, test.activity))


merged.full<-bind_rows(train.full, test.full)

## Make recods of each measure column, split records by aggregate type, then average
activity.measures.tidy<-merged.full %>%
        gather(agg_measure, value, -c(Subject,Activity))%>%
        separate(agg_measure, into=c("Aggregate","Measure"), sep="_") %>%
        group_by(Subject, Activity, Aggregate, Measure) %>%
        summarize(AvgValue=mean(value, na.rm=TRUE))

## Make the aggregates into columns
activity.measures.tidy<-activity.measures.tidy %>%
        spread(Aggregate, AvgValue)

## Assign proper activity names and clean up the subject
activity.measures.tidy<-activity.measures.tidy %>%
        mutate(Activity=activities[Activity], Subject=sprintf("Subject_%02d", Subject))

## Final name cleaning
names(activity.measures.tidy)<-gsub("mean", "AverageMean", names(activity.measures.tidy))
names(activity.measures.tidy)<-gsub("std", "AverageStd", names(activity.measures.tidy))

## Ouput the Tidy Data Set
write.table(activity.measures.tidy, 
            "getdata-activity-measure-values.txt", 
            sep=",",
            row.name=FALSE)
        
