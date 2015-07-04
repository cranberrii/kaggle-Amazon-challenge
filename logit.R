#http://www.ats.ucla.edu/stat/r/dae/logit.htm


#read data
data <- read.csv("train.csv")
data2 <- read.csv("test.csv")

#logistic regression
mylogit <- glm(ACTION ~ RESOURCE + MGR_ID + ROLE_ROLLUP_1 + ROLE_ROLLUP_2 + ROLE_DEPTNAME + ROLE_TITLE + ROLE_FAMILY_DESC + ROLE_FAMILY + ROLE_CODE, data = data, family = binomial (link="logit"))

P <- predict.glm(mylogit, newdata = data2)
predictdata2 <- cbind(data2, plogis(P))

summary(predictdata2)
head(predictdata2)

#save submission			
ID <- data2[,1]
ACTION <- predictdata2[,11]
submit_file = cbind(ID, ACTION)
write.table(submit_file, file="jerm.csv",row.names=FALSE, col.names=TRUE, sep=",")