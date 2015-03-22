Code Book for Getdata-Activities-Measure-Values.txt
===================================================
The file getdata-activities-measure-values.txt is a comma delimited file containing
summary data originating from the [Human Activity Recognition database](
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). This file
was produced as a project for the Getting and Cleaning Data course.

#Column Information

### Subject
This is a character field representing the subject who participated in the original experiments. The 30
participants are identified as:

Subject_01 - Subject-30

### Activity
Character column representing what the Subject was doing while the measurements were collected.
It will have one of these values

* Walking
* WalkingUpstairs
* WalkingDownstairs
* Sitting
* Standing
* Laying

### Measure
This column comes from the features columns from the original study. The columns were selected
by being either the mean or std value of one of 33 features. 

It is a character column with one of the following values

* FrequencyDomain.BodyAccelerometer.XAxis
* FrequencyDomain.BodyAccelerometer.YAxis
* FrequencyDomain.BodyAccelerometer.ZAxis
* FrequencyDomain.BodyAccelerometerJerk.XAxis
* FrequencyDomain.BodyAccelerometerJerk.YAxis
* FrequencyDomain.BodyAccelerometerJerk.ZAxis
* FrequencyDomain.BodyAccelerometerJerkMagnitude
* FrequencyDomain.BodyAccelerometerMagnitude
* FrequencyDomain.BodyGyroscope.XAxis
* FrequencyDomain.BodyGyroscope.YAxis
* FrequencyDomain.BodyGyroscope.ZAxis
* FrequencyDomain.BodyGyroscopeJerkMagnitude
* FrequencyDomain.BodyGyroscopeMagnitude
* TimeDomain.BodyAccelerometer.XAxis
* TimeDomain.BodyAccelerometer.YAxis
* TimeDomain.BodyAccelerometer.ZAxis
* TimeDomain.BodyAccelerometerJerk.XAxis
* TimeDomain.BodyAccelerometerJerk.YAxis
* TimeDomain.BodyAccelerometerJerk.ZAxis
* TimeDomain.BodyAccelerometerJerkMagnitude
* TimeDomain.BodyAccelerometerMagnitude
* TimeDomain.BodyGyroscope.XAxis
* TimeDomain.BodyGyroscope.YAxis
* TimeDomain.BodyGyroscope.ZAxis
* TimeDomain.BodyGyroscopeJerk.XAxis
* TimeDomain.BodyGyroscopeJerk.YAxis
* TimeDomain.BodyGyroscopeJerk.ZAxis
* TimeDomain.BodyGyroscopeJerkMagnitude
* TimeDomain.BodyGyroscopeMagnitude
* TimeDomain.GravityAccelerometer.XAxis
* TimeDomain.GravityAccelerometer.YAxis
* TimeDomain.GravityAccelerometer.ZAxis
* TimeDomain.GravityAccelerometerMagnitude

###AverageMean
Numeric column containing the average of the mean values for each measure for a subject and activity. Values come from normalized measurements and will all fall between -1 and 1.

###AverageStd
Numeric column containing the average of the std values for each measure for a subject and activity. Values come from normalized measurements and will all fall between -1 and 1.

## Summary Applied
The original data contained records with 561 separate measurements tagged with a subject and an activity. From these, there were 33 for which several aggregate values had been computed including mean and std. These 66 columns were selected and converted into the measurements shown above and separated by aggregate type.

The values contained in the file represent the mean value for a subject, activity, and measure for either the mean or std aggregate.

## Original Experimental Study
The data all originates from experiments of 30 indivuals performing various activities with
measurements being collected on Samsung Galaxy S II smartphone.

The complete details of the study and the data collection and processing methodology are
available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).