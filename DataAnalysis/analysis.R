#data analysis work
library(kableExtra)
library(imputeMissings)
library(tidyverse)


survey_data <- read.csv("F:/sta304/final/survey1.csv")

survey_data <- as.data.frame(survey_data)
#checking missing values

is.na(survey_data)
(colSums(is.na(survey_data)))

miss<- (colSums(is.na(survey_data)))/491775*100
miss<- as.data.frame(miss)
miss

survey_data2<- survey_data[!is.na(survey_data$obese), ]

miss<- (colSums(is.na(survey_data2)))/465046*100
miss<- as.data.frame(miss)
miss

survey_data3<- survey_data2[-c(3,16,24,44,45,46,63,64,66,68,69,70,71,72,73,74,
                               79,80,81,82,83,84,85,86,87,88,89,90,91,
                               92,93,94,95,96,97,98,99,100,101,102,103,104,
                               105)]

miss<- (colSums(is.na(survey_data3)))/465046*100
miss<- as.data.frame(miss)
miss

#if omit rows with NA values
#survey_data4 <- na.omit(survey_data3)

#only removed >50%,  poor health 49% also remove it

survey_data4 <- survey_data3[-c(8)]

#impute missing variables
data<- impute(survey_data4,object=NULL, method="median/mode") #median mode imputation

#write_csv(data, "dataset1.csv")









