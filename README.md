## run_analysis.R

This program:
1) merges the training and test datasets;
2) extracts only the mean and standard deviation measurements for each measurement;
3) updates the activity codes with descriptive names;
4) labels the measurments;
5) exports the data frame to the invoking environment as getdata014_merged variable; and
6) returns a dataframe with the average of each variable for each activity and each subject.

### Package Dependancies:
The following packages should be installed prior to executing run_analysis.R.

1) dplyr

### Data Source:

The following zip file must be downloaded and unpacked:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Input files relative to the working directory MUST be layed out as follows: 

```javascript
<working directory>
	activity.labels.txt
	features.txt
    test/
    	subject_test.txt
    	X_test.txt
    	Y_text.txt
    train/
    	subject_train.txt
       	X_train.txt
    	Y_train.txt
```
