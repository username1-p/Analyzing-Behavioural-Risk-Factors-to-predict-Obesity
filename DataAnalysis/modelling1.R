library(tidyverse)
library(rms)

#modelling
datamodel <- read.csv("F:/sta304/final/dataset1.csv", stringsAsFactors = T)
#datamodel[] <- lapply( datamodel, factor)

str(datamodel)
#take out the wrong factors, need >2
datamodel<- datamodel[-c(2,37,38,40,63,64)]

set.seed(1005245879)
#sample is too big, take sample
datamodelsample<-datamodel[sample(seq_len(nrow(datamodel)), size = 20000),]

## Create training and test set 
set.seed(1005245879)

datamodelsample$ID <- seq.int(nrow(datamodelsample))

#80%
train <- datamodelsample[sample(seq_len(nrow(datamodelsample)), size = 16000),]


nrow(train)

length(unique(train$ID))



#20%

test <- datamodelsample[!datamodelsample$ID %in% train$ID,]
nrow(test)
length(unique(test$ID))



#full model
#traintry <- datamodel[sample(seq_len(nrow(datamodel)), size = 10),]
#traintry<- as.data.frame(traintry)

#traintry[] <- lapply( traintry, factor)
#traintry<-  traintry[-c(2,8,17,40,57)]

#is.na(traintry)


#traintry <- train[sample(seq_len(nrow(train)), size = 10),]


model1<-glm(formula = as.factor(obese) ~ . -ID
 
                    , family="binomial",data=train)
summary(model1)





#aic
## Stepwise elimination based on AIC ##
aic <- step(model1, trace = 1, k=2)


# BIC
n <- nrow(train)
bic<- step(model1, trace = 1, k = log(n), direction = "both") 
bic<-attr(terms(bic), "term.labels")   
bic










#models




model1<-glm(formula = as.factor(obese) ~ . -ID
            
            , family="binomial",data=train)
summary(model1)


#height and weight should be removed if want more behavioural predictors, seems to causes 
#perfect seperation

model2 <-  glm(formula = as.factor(obese) ~ nummen+numwomen+
                 genhlth+
                 persdoc2+
                 bphigh4+bloodcho+toldhi2+asthma3+chccopd1+
                 addepev2+diabete3+educa+employ1+sex+diffwalk+
                 smoke100+ alcday5+avedrnk2+drnk3ge5+maxdrnks+
                 fruitju1+fruit1+fvbeans+fvgreen+fvorang+vegetab1+exerany2+
                 exract11+sleptim1+physhlth+menthlth+marital+children+income2
               
               
               , family="binomial",data=train)


#aic
## Stepwise elimination based on AIC ##
aic <- step(model1, trace = 1, k=2)

length(which(train$obese==1))

# BIC
n <- nrow(train)
bic <- step(model2, trace = 1, k = log(n), direction = "both") 
bic<-attr(terms(bic), "term.labels")   
bic

#after bic



model3<- glm(formula = as.factor(obese) ~ numwomen + genhlth + bphigh4 + 
               bloodcho + toldhi2 + asthma3 + chccopd1 + 
               addepev2 + diabete3 + 
               educa + employ1 + sex + diffwalk + 
               smoke100 + exerany2 + 
               marital + children
             
             
             , family = "binomial", data = train)

#variables add


model4<- glm(formula = as.factor(obese) ~ numwomen + genhlth + bphigh4 + 
               bloodcho + toldhi2 + asthma3 + chccopd1 + 
               addepev2 + diabete3 + 
               educa + employ1 + sex + diffwalk + 
               smoke100 + exerany2 + 
               marital + children +alcday5+
               fruitju1+fruit1+fvbeans+fvgreen+fvorang+vegetab1+
               exract11+sleptim1+physhlth+menthlth+income2
             
             
             , family = "binomial", data = train)

bic02 <- step(model4, trace = 1, k = log(n), direction = "both")

#bic again


#aic 18920






model5<-  glm(formula = as.factor(obese) ~ numwomen + genhlth + bphigh4 + 
                fruitju1+fruit1+fvbeans+fvgreen+vegetab1+
                exract11+sleptim1+physhlth+menthlth+income2+
                educa + employ1 + sex + diffwalk + smoke100 + exerany2 + 
                marital + children, family = "binomial", data = train)

#aic
## Stepwise elimination based on AIC ##
aic <- step(model5, trace = 1, k=2)

step(model5, trace = 1, k = log(n), direction = "both")

model6 <- glm(formula = as.factor(obese) ~ numwomen + genhlth + bphigh4 + 
             bloodcho + toldhi2 + asthma3 + chccopd1 + addepev2 + diabete3 + 
             educa + employ1 + sex + diffwalk + smoke100 + exerany2 + 
             marital + children, family = "binomial", data = train)


mymodel7 <-  glm(formula = as.factor(obese) ~ 
                    genhlth  + 
                    toldhi2  + chccopd1 + 
                   
                   educa + employ1 + sex + diffwalk + smoke100 + exerany2 + 
                   marital + children + +vegetab1+
                   +sleptim1, 
                 
                 family = "binomial", data = train)
aic <- step(mymodel7, trace = 1, k=2)

aic1<-
glm(formula = as.factor(obese) ~ genhlth + toldhi2 + chccopd1 + 
      educa + employ1 + sex + diffwalk + smoke100 + exerany2 + 
      marital + children + +vegetab1 + +sleptim1, family = "binomial", 
    data = train)

#bic
 bicnew<- step(mymodel7, trace = 1, k = log(n), direction = "both") 
 
 bic1<- 
   
   glm(formula = as.factor(obese) ~ genhlth + toldhi2 + chccopd1 + 
                educa + employ1 + sex + diffwalk + smoke100 + exerany2 + 
                marital, family = "binomial", data = train)

 
 
 #final  model
 newmodel<-
   glm(formula = as.factor(obese) ~ genhlth + toldhi2 + chccopd1 + 
         educa + employ1 + sex + diffwalk + smoke100 + exerany2 + 
         marital   +vegetab1  , family = "binomial", 
       data = train) 

 
 anova(aic1, newmodel, test = "Chisq")
 
 bicnew2<- step(newmodel, trace = 1, k = log(n), direction = "both") 
 summary(newmodel)

 
 #prediction error
 pred.aic <- predict(newmodel, newdata = test, type = "response")
 test$prob<- pred.aic
 test$obesepredict[test$prob>0.5]<-1
 test$obesepredict[test$prob<0.5]<-0
 
 

z<-which(test$obese==test$obesepredict)
length(z)/4000
#67.2% accurate
 
 
 
 ## Fit the model with lrm 
 #train,test, and full datamodel set
 lrm.final <- lrm(formula = as.factor(obese) ~ genhlth + toldhi2 + chccopd1 + 
                           educa + employ1 + sex + diffwalk + smoke100 + exerany2 + 
                           marital   +vegetab1 , 
                         data = test ,
                  
                  x =TRUE, y = TRUE, model= T)
 cross.calib <- rms::calibrate(lrm.final, method="crossvalidation", B=10) 
 par(family = 'serif')
 plot(cross.calib, las=1, xlab = "Predicted Probability")
 
 
 #plots
 
 
 library(ggplot2)
 datamodelsample %>% 
    ggplot(aes(y= obese, x = exeroft1)) +
    geom_boxplot() +ggtitle("Exercise vs Obesity") +labs(y= "Obese", x = "Exercise Often")
 
 
 
 datamodelsample %>% 
    ggplot(aes(y=obese, x = X_age_g)) +
    geom_boxplot() +ggtitle("Obese vs Age")+labs(y="obese", x="age groups")
 
 
 datamodelsample %>% 
   ggplot(aes(y= obese, x = bphigh4)) +
   geom_boxplot() +ggtitle("Exercise vs Obesity") +labs(y= "Obese", x = "Exercise Often")
 
 
 datamodelsample %>% 
   ggplot(aes(y= obese, x = marital)) +
   geom_point() +ggtitle("Exercise vs Obesity") +labs(y= "Obese", x = "Exercise Often")
 
 
 

 
 
 g1 <- ggplot(datamodelsample, aes(marital, obese))
 
 
 g1 + geom_point() + 
   geom_smooth(method="lm", se=F) +
   labs(
        y="y", 
        x="x", 
        title="y vs x", 
       )
 
 
 

 
 
 
 g2 <- ggplot(datamodelsample, aes(exerany2, obese))
 
 g2 + geom_jitter(width = .5, size=1) +
   labs( 
        y="y", 
        x="x", 
        title="title")
 
 g3 <- ggplot(datamodelsample, aes(employ1, obese))
 
 g3 + geom_jitter(width = .5, size=1) +
   labs(
        y="y", 
        x="x", 
        title="title")+theme(axis.text.x = element_text(size = 7, angle = 90, hjust = 1))
 
 #genhlth + toldhi2 + chccopd1 + 
  # educa + employ1 + sex + diffwalk + smoke100 + exerany2 + 
   #marital   +vegetab1  , family = "binomial", 
 
 g4 <- ggplot(datamodelsample, aes(fruitju1, obese))
 
 g4 + geom_jitter(width = .5, size=1) +
   labs(
        y="y", 
        x="x", 
        title="title")+theme(axis.text.x = element_text(size = 7, angle = 90, hjust = 1))
 
 