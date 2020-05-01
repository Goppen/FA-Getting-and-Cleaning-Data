# 0) Read data 

This will check if the datafile is in the wd and or if it has to be downloaded. Once the datafile is in the wd, the tables are loaded:

X_test: values for the "test" variables.
subject_test: Id's of the "test" subjects.
y_test: Id's of the "test" activities.

X_train: values for the "train" variables.
subject_train: Id's of the "train" subjects.
y_train: Id's of the "train" activities.

activity_labels: describes activity Id's in X_test and X_train.
features: describes variables in X_test and X_train.

# 1) Merge tables.
Merge the different tables into one data set. 

datasetx: binds X_train with X_test by the rows.
datasety: binds y_train with y_test by the rows.
subject:  binds subject_train with subject_test by the rows.
DataSet1: binds the previosly created data set: subject, datasety, datasetx (in that order) by the columns. Finally creating
one data set.

# 2) Identify and keep only the variables mean() and std().


MeanandStd: Identifies the location of the mean and std variables in the "features" table.
DSmeanstd:  Since the feature file is for the "X" tables, all values have to be shifted by two, in order to match
the position in DataSet1.
DataSet2: New data set with only the mean and std variable.

# 3) Changes numeric into descriptive values.

The second column has numeric values referring to the activities.

Firts the values were changed into factors:

activity: contains the activities column as factors.

After that, the numeric factors were renamed into descriptive ones with the data in 
the "activity_labels" data set.

DataSet2: Now contains the values of the activity variable as descriptive factors.

# 4) Assing names to all columns

This step will assign names to all columns of DataSet2.

Column 1: Is renamed as "subject"
Column 2: Is renamed as "activity" 
Columns 3+: After their corresponding variable name in the "features" data set. 

# 5) Second data set

This is an independent tidy data set. "It has the average of each variable for each activity and each subject".

SecondData1: Stores the result of the melt of the Dataset2 with the id.vars of subject and activity.
SecondData2: Stores the result of casting on subject and activity the mean of the variable column.
SecondData2: Contains the second data set.
