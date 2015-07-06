#http://cran.r-project.org/web/packages/party/party.pdf
#http://trevorstephens.com/post/73770963794/titanic-getting-started-with-r-part-5-random

library(party)

#read data
data <- read.csv("train.csv")
data2 <- read.csv("test.csv")

#conditional random forest
set.seed(5)
fit <- cforest(as.factor(ACTION) ~ RESOURCE + MGR_ID + ROLE_ROLLUP_1 + ROLE_ROLLUP_2 + ROLE_DEPTNAME + ROLE_TITLE + ROLE_FAMILY_DESC + ROLE_FAMILY + ROLE_CODE, 
              data = data, controls = cforest_unbiased(ntree = 20, mtry = 3))

Prediction <- predict(fit, newdata = data2, OOB = TRUE, type = "response")

#save submission			

submit_file = data.frame(ID = data2$id, ACTION = Prediction)
write.table(submit_file, file="cRF_soln.csv", row.names = FALSE, col.names = TRUE, sep = ",")
