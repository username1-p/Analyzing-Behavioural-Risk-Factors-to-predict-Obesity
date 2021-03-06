#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from kaggle(originally BRFSS website )
# Author: Prinsa Gandhi
# Data: 22 December 2020
# Contact: prinsa.gandhi@mail.utoronto.ca
# License: MIT



#### Workspace setup ####
library(tidyverse)

setwd("F:/sta304/final")
# Read in the raw data (You might need to change this if you use a different dataset)
data1 <- read_csv("finaldata.csv")



data1


data2 <- 
  data1 %>% 
  select(X_state,
         pvtresd1,
         colghous,
         nummen,
         numwomen,
         genhlth,
         physhlth,
         menthlth,
         poorhlth,
         hlthpln1,
         persdoc2,
         medcost,
         checkup1,
         sleptim1,
         bphigh4,
         bpmeds,
         bloodcho,
         cholchk,
         toldhi2,
         cvdinfr4,
         cvdcrhd4,
         cvdstrk3,
         asthma3,
         asthnow,
         chccopd1,
         addepev2,
         diabete3,
         veteran3,
         marital,
         children,
         educa,
         employ1,
         income2,
         weight2,
         height3,
         renthom1,
         sex,
         qlactlm2,
         decide,
         diffwalk,
         diffdres,
         diffalon,
         smoke100,
         smokday2,
         stopsmk2,
         lastsmk2,
         usenow3,
         alcday5,
         avedrnk2,
         drnk3ge5,
         maxdrnks,
         fruitju1,
         fruit1,
         fvbeans,
         fvgreen,
         fvorang,
         vegetab1,
         exerany2,
         exract11,
         exeroft1,
         exerhmm1,
         exract21,
         exeroft2,
         exerhmm2,
         strength,
         pdiabtst,
         prediab1,
         diabage2,
         insulin,
         bldsugar,
         painact2,
         qlmentl2,
         qlstres2,
         qlhlth2,
         hlthcvrg,
         drvisits,
         medscost,
         medbills,
         ssbsugar,
         ssbfrut2,
         wtchsalt,
         longwtch,
         dradvise,
         cvdasprn,
         rlivpain,
         rrclass2,
         rrcognt2,
         rratwrk2,
         rrhcare3,
         rrphysm2,
         rremtsm2,
         misnervs,
         mishopls,
         misrstls,
         misdeprd,
         miseffrt,
         miswtles,
         misnowrk,
         mistmnt,
         mistrhlp,
         misphlpf,
         scntmony,
         scntmeal,
         scntwrk1,
         lsatisfy,
         mscode,
         X_bmi5cat,
         
         X_rfbmi5,
         X_age_g,
         )


data2<-
 data2 %>%
  mutate(obese = 
           ifelse( X_rfbmi5=="Yes", 1, 0))

# Saving the survey/sample data as a csv file in my
# working directory
#write_csv(data2, "survey1.csv")

