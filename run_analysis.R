# STEP 1: read data training,test and features
trainingX <- read.table(".\\project\\train\\X_train.txt")
trainingY <- read.table(".\\project\\train\\y_train.txt")
trainingSubject <- read.table(".\\project\\train\\subject_train.txt")

testX <- read.table(".\\project\\test\\X_test.txt")
testY <- read.table(".\\project\\test\\y_test.txt")
testSubject <- read.table(".\\project\\test\\subject_test.txt")

features <- read.table(".\\project\\features.txt")
activity <- read.table(".\\project\\activity_labels.txt")

# merge training and test data  
allX <- rbind(trainingX,testX)
allY <- rbind(trainingY,testY)
allSubject <- rbind(trainingSubject,testSubject)

# STEP 2: Find the mean() and std() features and flag them and subset 
features$flag<-grepl('mean\\(\\)|std\\(\\)',features[,"V2"])
features_mean_std<-subset(features,features$flag==TRUE,select=c(V1,V2))

# select mean and std columns from features_mean_std with X,Y and Subject
mean_std_X<-allX[,features_mean_std$V2]
Y_Subject <- cbind(allY,allSubject)
colnames(Y_Subject)<-c("Y","subject")

# STEP 4:
colnames(mean_std_X)<-features_mean_std$V2

# STEP 3:

rowname=merge(Y_Subject,activity,by.x="Y",by.y="V1",all=FALSE)
rowname$SubjectActionID<-paste(as.factor(rowname$subject),as.factor(rowname$V2))
final<-cbind(rowname$SubjectActionID,mean_std_X)

#STEP 5

Molten <- melt(, id.vars=("activity","subject"))

#output
write.table(final,file=".\\project\\final.csv",sep=" ")