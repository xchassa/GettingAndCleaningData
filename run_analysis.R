# Retrieve all the labels from features.txt
features <- read.table("UCI HAR Dataset//features.txt",stringsAsFactors = FALSE, header = FALSE)
labels <- features[,2]

# Retrieve data for test and training
testData <- read.table("UCI HAR Dataset/test//X_test.txt",stringsAsFactors = FALSE, header = FALSE)
trainData <- read.table("UCI HAR Dataset/train//X_train.txt",stringsAsFactors = FALSE, header = FALSE)
# Create a unique data table from test and training
fullData <- rbind(testData,trainData)

# Create a comprehensive data table by applying correct labels
names(fullData) <- labels

# Retrieve subject for test and training
testSubject <- read.table("UCI HAR Dataset//test//subject_test.txt",stringsAsFactors = FALSE, header = FALSE)
trainSubject <- read.table("UCI HAR Dataset/train//subject_train.txt",stringsAsFactors = FALSE, header = FALSE)
# Merge subjects
fullSubject <- rbind(testSubject,trainSubject)
names(fullSubject) <- "Subject"

# Retrieve activity for test and training
testActivity <- read.table("UCI HAR Dataset//test//y_test.txt",stringsAsFactors = FALSE, header = FALSE)
trainActivity <- read.table("UCI HAR Dataset/train//y_train.txt",stringsAsFactors = FALSE, header = FALSE)
# Merge activities
fullActivity <- rbind(testActivity,trainActivity)
names(fullActivity) <- "Activity"

# Create the global dataset
globalDataset <- cbind(fullActivity,fullSubject,fullData)

# Select only columns mean() and std()
fullColumns <- names(globalDataset)
meanColumns <- grep('mean()',fullColumns)
stdColumns <- grep('std()',fullColumns)

selectedData <- globalDataset[,c(1,2,meanColumns,stdColumns)]

# activities labels
activitiesLabels <- read.table("UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE, header = FALSE)
names(activitiesLabels) <- c("ID","Activity")

# Factorize the Activity column with levels based on the ID and labels based
# on the Activities
selectedData$Activity<-factor(selectedData$Activity,levels = activitiesLabels$ID,labels = activitiesLabels$Activity)

# Reshape the names to have tidy data
names(selectedData) <- gsub("-mean\\(\\)","Mean",names(selectedData))
names(selectedData) <- gsub("-std\\(\\)","Std",names(selectedData))
names(selectedData) <- gsub("^t","time",names(selectedData))
names(selectedData) <- gsub("^f","frequency",names(selectedData))
names(selectedData) <- gsub("-X","X",names(selectedData))
names(selectedData) <- gsub("-Y","Y",names(selectedData))
names(selectedData) <- gsub("-Z","Z",names(selectedData))

# Load the package reshape2 that allow us to reshape the data in tidy data
library(reshape2)

# Reshape the data respect to Subject and Activity
var<-names(selectedData)[3:68]
mergedExtractedMelted <- melt(selectedData,id.vars=c("Subject","Activity"),
                              variable.name="Variable",
                              value.name="Average")

mergedExtractedTidy <- dcast(mergedExtractedMelted,Subject+Activity~Variable,
                             value.var="Average",mean)

# Write the tidy data in a file txt
write.table(mergedExtractedTidy,file="tidyData.txt")

