# GetData_Project
This is the repository for the Course Project for Getting and Cleaning Data course, part of the Data Science Specialization. 
The purpose is to deliver a tidy data set of measurements collected from a Galaxy S II smartphone. The measurements are
tagged with the activity being done when the value was collected. The primary purpose of the data set is to assist in
machine learning applications.

## Raw Data
The data are available are available from this 
[link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). For the purposes of this
project, the source files are assumed to be unzipped and available in a /data folder of the current working directory.

The original data had been split into two sets, one for training and a second for testing. The focus of this analysis is
six space-delimited text files and two space-delimited files containing label information.

* *subject_test.txt*, *subject_train.txt* hold an identifier of the experiment participant
* *y_test.txt*, *y_train.txt* hold an identifier for the activity being performed
* *X_test.txt*, *X_train.txt* hold 561 measurements

* *activity_labels.txt* holds a text label for each activity identifier.
* *features.txt* holds a text label for each of the 561 measurements.

The raw data zip file contains a file called *feature_info.txt* which give more information on the actual measurements
and how they were gathered and computed. 

The focus of this analysis is 33 measurements upon which some aggregations were applied. In particular, the mean and std
of the measurements will be addressed.

Measurements were done with both Time Domain and Frequency Domain analysis.


## Tidy Data
The tidy data set is not included in this repository, but can be generated with the code included in run_analysis.R and 
has been attached to the project submission.

The result of the processing is a tall tidy data set consisting of both the training and test collections combined.
It is organized around three identifying columns

* Subject

* Activity

* Measure

And provides values for the AverageMean and AverageSTD.

This interpretation of the project requirements conform to my experience with data warehouses where aggregates of 
measures exist as available facts. It caters to analyses where one or more aggregate statistics are needed at the same time.

Additional information is available in the [code book]()

## Overview of Processing
To produce the final tidy data set a series of steps had to be applied. Both the *dplyr* and *tidyr* packages are used.

### Column Name Grooming
A key step is loading the measurement column names from the *features.txt* file and the activity descriptions 
from *activity_labels.txt*.

From the entire list of column names, 66 are targeted -- 33 mean measures and 33 std measures. The column numbers 
are selected by name matching. This is used later to select the corresponding columns from the measures data set.

The column names are also reformatted to extract the aggregate (mean or std) and use it to prefix the measurement. This
makes it easier to organize the final data set. This is done with regular expression matching and the *gsub()* function.

At this point, the measurement names are further groomed to produce consistent, clean, readable names.

The activity names are also groomed to provide nicely formatted values.

### Read and Assemble the Raw Data Set
The same steps are performed for the training and test data files to produce combined raw data sets.

* Read the subject data file and assign it a column heading.
* Read the activity data file and assign it a column heading.
* Read the measurement data file, select the columns of interest, and assign column headings.
* Bind the three data sets on a column basis.

Finally, the training and test sets are combined on a row basis to create the merged set.

### Produce the Final Tidy Data Set
The merge data set is produced through a series of transformations.

* Turn the columns into key values pairs
* Further split the keys into an aggregate and a measure
* Compute the average for each aggregate and measure by subject and activity
* Reshape the data to make columns of the aggregate averages.\
* Convert activity identifiers into activity names
* Make readable Subject identifiers
* Make final edits to the column names

Once all the processing is complete, the data set is written to a text file named *getdata-activity-measure-values.txt*
in the current working directory.


