# Code Book

This code book describes 
 - the data used in this project
 - processing required to create the resulting tidy data set

### Data Used
 - features.txt
 - activity_labels.txt
 - subject_train.txt
 - X_train.txt
 - y_train.txt
 - subject_test.txt
 - X_test.txt
 - y_test.txt
 
For details on the used data please refer features_info.txt and README.txt available inside "UCI HAR Dataset" directory

> Any data not mentioned above was not considered during the course project.

### Processing Steps

- train dataset, test dataset and feature data set got read into respective variables from UCI HAR Dataset directory.
- appropriate column name were added.
- activity columns converted from integer to factor, appropriate labels used to describe the activities.
- tidy set is created and written to .csv file in the working directory.

