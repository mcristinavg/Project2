Project2
========

Getting and cleaning data project
=================================

Files needed for the Data_cleaning_project were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Refer to initial readme.txt, features.txt and features_info.txt for experiments, full decription of variables. In brief, 30 volunteers performed 6 activities (walking, walking_upstairs, walking_downstairs,sitting, standing, laying) while having different body accelerations and gravity recorded in 3 dimensions -x,y,z - by a smartphone they carried.

wd was set as the downloaded file (UCI HAR Dataset) Files used for the analysis (read into R using read.table()):

x_train
y_train
subject_train
x_test
y_test
subject_test
Test_data was obatined by cbinding subject_test (training subjects), y_test (test labels) and x_test (training set). Same for train_data. Columns were named subject, activity and measurement. Rbind was used to bring together test_data and train_data. Resulted data.frame was called "data".

From data, by subsetting by columns I extracted only the columns that contained mean() or std() in their name (features.txt was used to identify the number of those columns). First 3 columns (subject, activity and measurement) from data were extracted in the new dataframe, too. The new dataframe was called "extracted_data).(Note: columns numbering seems deviated from features.txt because my "data" dataframe had the first 3 columns "subject","activity","measurement". When subsetting the columns by their number, the numbers are deviated by 3.)

Names of the columns in extracted_data were set using setattr from bit package to select only the names containing "mean()" or "std()". These names were found in features.txt. Again first three columns were kept as "subject", "activity", "measurement". Names were cleaned up by using gsub ("-" was changed into "_" and "()" were deleted).

I set up the column "activity" assigning "walking" where "1" was, "walking_upstairs" instead of "2", "walking_downstairs" instead of "3", "sitting" instead of "4", "standing" instead of "5" and "laying" instead of "6". The names of activities were obtained from the "activity_labels.txt" from the UCI HAR Dataset.

"data2" dataframe was created by melting "extracted_data" dataframe. "subject" and "activity" were kept as id variables, measurement was dropped, all other variables (the ones including mean and std in their name) became measure variables.

final dataframe called "data_final" was obtained from "data2" using dcast keeping "subject" and "activity" and calculating the mean for all other variables. This final dataframe is a tidy dataframe because it meets all requirements: each variable in 1 column, each observation in 1 row and the table only contains the means of previously identified variables containing mean() and std().

The dataframe was saved in txt format using write.table(), sep=",", rownames=FALSE, colnames=TRUE. It contains 180 observations (30 subjects with 6 activities each) and mean measurements for 65 variables that were initially selected based on including "mean()" or "std()" in their name. The tidy dataframe can be read in R using read.table.

The Data_cleaning_project contains:

README.md explaining the changes done on the initial files
CodeBook.md detailing the variables in the final dataframe
data_final.txt that contains the final dataframe with averages for each subject and eacg activity
run_analysis.R with the R script that shows how to obtain the final dataframe from initial dataframes in the UCI HAR Dataset folder.
