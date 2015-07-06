#http://cran.r-project.org/web/packages/randomForest/randomForest.pdf
#http://trevorstephens.com/post/73770963794/titanic-getting-started-with-r-part-5-random

#library(randomForest)
library(party)

#read data
data <- read.csv("train.csv")
data2 <- read.csv("test.csv")

#random forest
set.seed(5)
fit <- randomForest(as.factor(ACTION) ~ RESOURCE + MGR_ID + ROLE_ROLLUP_1 + ROLE_ROLLUP_2 + ROLE_DEPTNAME + ROLE_TITLE + ROLE_FAMILY_DESC + ROLE_FAMILY + ROLE_CODE, 
                    data = data, importance = TRUE, ntree = 400)

Prediction <- predict(fit, newdata = data2)

#save submission			

submit_file = data.frame(ID = data2$id, ACTION = Prediction)
write.table(submit_file, file="RF_soln.csv", row.names = FALSE, col.names=TRUE, sep=",")
