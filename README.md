# This is what the R script, run_analysis.R does: 

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# The tidy.txt is the result of tidy dataset.

#Pseudo code of the script:
1. Download and unzip the dataset:
2. Read lables of dataset
3. Take dataset lables which contain only mean or standard deviation
4. Rename the lable to more meaningful name
5. Load the training datasets for column contain mean or standard deviation 
6. Read subject training dataset and merge them
7. Load the test datasets for column contain mean or standard deviation
8. Read subject test dataset and merge them
9. Merge required training and test dataset, and rename column
10. turn activities & subjects into factors
11. average of each variable for each activity and each subject
12. create independent tidy data set and write to text