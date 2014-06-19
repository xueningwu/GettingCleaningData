# STEP 1: read data training,test,subject
trainingX <- read.table(".\\project\\train\\X_train.txt")
trainingY <- read.table(".\\project\\train\\y_train.txt")
trainingSubject <- read.table(".\\project\\train\\subject_train.txt")

testX <- read.table(".\\project\\test\\X_test.txt")
testY <- read.table(".\\project\\test\\y_test.txt")
testSubject <- read.table(".\\project\\test\\subject_test.txt")

# STEP 1: read data features and activity lable
features <- read.table(".\\project\\features.txt")
activity <- read.table(".\\project\\activity_labels.txt")

# merge training and test data on X,Y and subject 
allX <- rbind(trainingX,testX)   #10299*561
allY <- rbind(trainingY,testY)   #10299*1
allSubject <- rbind(trainingSubject,testSubject) #10299*1

# STEP 2: Find the mean() and std() features and flag them and subset 
features$flag<-grepl('mean\\(\\)|std\\(\\)',features[,"V2"])
#Only select features with mean and std
features_mean_std<-subset(features,features$flag==TRUE,select=c(V1,V2))
# remove "()" in the feature anem
features_mean_std$V2<-gsub("\\(\\)", "", features_mean_std$V2)   

# select mean and std columns from features_mean_std with X,Y and Subject to reduce column number to 66
mean_std_X<-allX[,features_mean_std$V1]      #10299*66

Y_Subject <- cbind(allY,allSubject)          #10299*2   
colnames(Y_Subject)<-c("Y","subject")        #change column name

# STEP 4:
colnames(mean_std_X)<-features_mean_std$V2   #change column name

# STEP 3:
# activity description
rowname=merge(Y_Subject,activity,by.x="Y",by.y="V1",all=FALSE)
colnames(rowname)<-c("Y","subject","activity")
final<-cbind(rowname,mean_std_X)     #merge with X  10299*69

#STEP 5

melt.final<-melt(final,id=c("subject","activity"),measure.vars=features_mean_std$V2)
cast.final <- dcast(melt.final,subject+activity ~variable,mean)
#output
write.table(cast.final,file=".\\project\\final.txt",sep=" ")