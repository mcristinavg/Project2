x_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/y_test.txt")
subject_test<-read.table("./test/subject_test.txt")
x_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/y_train.txt")
subject_train<-read.table("./train/subject_train.txt")
test_data<-cbind(subject_test,y_test,x_test)
train_data<-cbind(subject_train,y_train,x_train)
names(test_data)<-c("subject","activity","measurement")
names(train_data)<-c("subject","activity","measurement")
data<-rbind(test_data,train_data)

extracted_data<-data[,c(1:9,44:49,84:89,124:129,164:169,204,205,217,218,230,231,243,244,256,257,269:274,348:353,427:432,506,507,519,520,532,533,545,546)]

setattr(extracted_data,'names',c('subject','activity','measurement','tBodyAcc-mean()-X','tBodyAcc-mean()-Y','tBodyAcc-mean()-Z','tBodyAcc-std()-X','tBodyAcc-std()-Y','tBodyAcc-std()-Z',' tGravityAcc-mean()-X','tGravityAcc-mean()-Y','tGravityAcc-mean()-Z','tGravityAcc-std()-X','tGravityAcc-std()-Y','tGravityAcc-std()-Z','tBodyAccJerk-mean()-X','tBodyAccJerk-mean()-Y','tBodyAccJerk-mean()-Z','tBodyAccJerk-std()-X','tBodyAccJerk-std()-Y','tBodyAccJerk-std()-Z','tBodyGyro-mean()-X','tBodyGyro-mean()-Y','tBodyGyro-mean()-Z','tBodyGyro-std()-X','tBodyGyro-std()-Y','tBodyGyro-std()-Z','tBodyGyroJerk-mean()-X','tBodyGyroJerk-mean()-Y
','tBodyGyroJerk-mean()-Z','tBodyGyroJerk-std()-X','tBodyGyroJerk-std()-Y','tBodyGyroJerk-std()-Z','tBodyAccMag-mean()','tBodyAccMag-std()','tGravityAccMag-mean()','tGravityAccMag-std()','tBodyAccJerkMag-mean()','tBodyAccJerkMag-std()','tBodyGyroMag-mean()','tBodyGyroMag-std()','tBodyGyroJerkMag-mean()','tBodyGyroJerkMag-std()','fBodyAcc-mean()-X','fBodyAcc-mean()-Y','fBodyAcc-mean()-Z','fBodyAcc-std()-X','fBodyAcc-std()-Y','fBodyAcc-std()-Z','fBodyAccJerk-mean()-X','fBodyAccJerk-mean()-Y','fBodyAccJerk-mean()-Z','fBodyAccJerk-std()-X','fBodyAccJerk-std()-Y','fBodyAccJerk-std()-Z','fBodyGyro-mean()-X','fBodyGyro-mean()-Y','fBodyGyro-mean()-Z','fBodyGyro-std()-X','fBodyGyro-std()-Y','fBodyGyro-std()-Z','fBodyAccMag-mean()','fBodyAccMag-std()','fBodyBodyAccJerkMag-mean()','fBodyBodyAccJerkMag-std()','fBodyBodyGyroMag-mean()','fBodyBodyGyroMag-std()','fBodyBodyGyroJerkMag-mean()','fBodyBodyGyroJerkMag-std()'))

names(extracted_data)<-gsub("-","_",names(extracted_data))
names(extracted_data)<-gsub("()","",names(extracted_data),fixed=TRUE)

extracted_data$activity[extracted_data$activity==1]<-"walking"
extracted_data$activity[extracted_data$activity==2]<-"walking_upstairs"
extracted_data$activity[extracted_data$activity==3]<-"walking_downstairs"
extracted_data$activity[extracted_data$activity==4]<-"sitting"
extracted_data$activity[extracted_data$activity==5]<-"standing"
extracted_data$activity[extracted_data$activity==6]<-"laying"

data2<-melt(extracted_data,id=c("subject","activity"),measure.vars=c("tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z","tBodyAcc_std_X","tBodyAcc_std_Y","tBodyAcc_std_Z","tGravityAcc_mean_Y","tGravityAcc_mean_Z","tGravityAcc_std_X","tGravityAcc_std_Y","tGravityAcc_std_Z","tBodyAccJerk_mean_X","tBodyAccJerk_mean_Y","tBodyAccJerk_mean_Z","tBodyAccJerk_std_X","tBodyAccJerk_std_Y","tBodyAccJerk_std_Z","tBodyGyro_mean_X","tBodyGyro_mean_Y","tBodyGyro_mean_Z","tBodyGyro_std_X","tBodyGyro_std_Y","tBodyGyro_std_Z","tBodyGyroJerk_mean_X","tBodyGyroJerk_mean_Y\n","tBodyGyroJerk_mean_Z","tBodyGyroJerk_std_X","tBodyGyroJerk_std_Y","tBodyGyroJerk_std_Z","tBodyAccMag_mean","tBodyAccMag_std","tGravityAccMag_mean","tGravityAccMag_std","tBodyAccJerkMag_mean","tBodyAccJerkMag_std","tBodyGyroMag_mean","tBodyGyroMag_std","tBodyGyroJerkMag_mean","tBodyGyroJerkMag_std","fBodyAcc_mean_X","fBodyAcc_mean_Y","fBodyAcc_mean_Z","fBodyAcc_std_X","fBodyAcc_std_Y","fBodyAcc_std_Z","fBodyAccJerk_mean_X","fBodyAccJerk_mean_Y","fBodyAccJerk_mean_Z","fBodyAccJerk_std_X","fBodyAccJerk_std_Y","fBodyAccJerk_std_Z","fBodyGyro_mean_X","fBodyGyro_mean_Y","fBodyGyro_mean_Z","fBodyGyro_std_X","fBodyGyro_std_Y","fBodyGyro_std_Z","fBodyAccMag_mean","fBodyAccMag_std","fBodyBodyAccJerkMag_mean","fBodyBodyAccJerkMag_std","fBodyBodyGyroMag_mean","fBodyBodyGyroMag_std","fBodyBodyGyroJerkMag_mean","fBodyBodyGyroJerkMag_std"))

data_final<-dcast(data2,subject+activity~variable,mean)