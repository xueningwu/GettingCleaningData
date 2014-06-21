Code Book

# STEP 1: read data training,test,subject
trainingX: training data X
trainingY: training data Y
trainingSubject:training data Subject

testX: test data X
testY: test data y
testSubject: test data subject

# STEP 1: read data features and activity lable
features: feature data
activity: activity labels

# merge training and test data on X,Y and subject 
allX: merge training data X #10299*561
allY: merge training data Y   #10299*1
allSubject: merge subject data #10299*1

# STEP 2: Find the mean() and std() features and flag them and subset 
features$flag: flag all mean and std features
features_mean_std: select mean and std features only

mean_std_X: reduced allX to only mean and std features      #10299*66

Y_Subject: combine ally and subject          #10299*2   

# STEP 3:
rowname: get activity labeled 
final: final reduced data set include subject, activity #merge with X  10299*69

#STEP 5

melt.final: melted final data 
cast.final: reshaped according to subject and activity
