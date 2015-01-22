# ReadMe

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

The data are described by the following files :
- 'features.txt' : list of all variables data set (X_test and X_train)
- 'X_test.txt' and 'X_train.txt' : data sets for test and training
- 'subject_test.txt' and 'subject_train.txt' : each row identify the subject who performed the activity for each window sample. Range from 1 to 30
- 'y_test.txt' and 'y_train.txt' : activity labels

The R script (run_analysis.R) merge all these files in one big data sets and extract only the mean and the standard deviation of each variables recorded.

Furthermore, it renames and reorganizes (reshape) the data set in order to have a tidy data in a txt file that can be read with the write.table() command (tidyData.txt).
