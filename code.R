setwd('E:/Statistics 1/assignment 2')
library(tidyverse)
library(gridExtra)
Drugs <- read.delim("Drugs.txt", sep=",")

#1

Drugs <- Drugs[-6]

#2

length(unique(Drugs$LOCATION))
(sorted <- sort(table(Drugs$LOCATION)))


#3


(top25 <- subset(sorted, sorted > quantile(sorted,probs=0.75)))


#4

top25all <- subset(Drugs,  Drugs$LOCATION %in% names(top25))
p1 <- ggplot(top25all, aes(TIME, PC_HEALTHXP, col=top25all$LOCATION, legend="col"))+geom_line()+ggtitle("Drug spending in Health Spending")+xlim(min(top25all$TIME), max(top25all$TIME))
p2 <- ggplot(top25all, aes(TIME, PC_GDP, col=top25all$LOCATION, legend="col"))+geom_line()+ggtitle("Drug spending in GDP")+xlim(min(top25all$TIME), max(top25all$TIME))
p3 <- ggplot(top25all, aes(TIME, USD_CAP, col=top25all$LOCATION, legend="col"))+geom_line()+ggtitle("Drug spending in USD per capita")+xlim(min(top25all$TIME), max(top25all$TIME))
p4 <- ggplot(top25all, aes(TIME, TOTAL_SPEND, col=top25all$LOCATION, legend="col"))+geom_line()+ggtitle("Drug spending in Total Spending")+xlim(min(top25all$TIME), max(top25all$TIME))
grid.arrange(p1,p2,p3,p4, ncol=2)


#5

subset(Drugs, Drugs$TIME == max(Drugs$TIME[Drugs$LOCATION=="GRC"]) & Drugs$LOCATION == "GRC")
df5 <- Drugs[which(Drugs$LOCATION=="GRC"),]
sum(dbinom(4:5,5,(sum(diff(df5$PC_HEALTHXP)>0)/(nrow(df5)-1))))
(reqlist <- list("Data"= df5, 
                "Years"=range(df5$TIME),
                "Data.points"=nrow(df5), 
                "YearlyProbs"=c("PC_HEALTHXP"= length(which(diff(df5$PC_HEALTHXP)>0))/(nrow(df5)-1),
                                "PC_GDP"=length(which(diff(df5$PC_GDP)>0))/(nrow(df5)-1),
                                "USD_CAP"=length(which(diff(df5$USD_CAP)>0))/(nrow(df5)-1),
                                "TOTAL_SPEND"=length(which(diff(df5$TOTAL_SPEND)>0))/(nrow(df5)-1)),
                "FiveYeProbs"=c("PC_HEALTHXP"= sum(dbinom(4:5,5,(sum(diff(df5$PC_HEALTHXP)>0)/(nrow(df5)-1)))),
                                "PC_GDP"=sum(dbinom(4:5,5,(sum(diff(df5$PC_GDP)>0)/(nrow(df5)-1)))),
                                "USD_CAP"=sum(dbinom(4:5,5,(sum(diff(df5$USD_CAP)>0)/(nrow(df5)-1)))),
                               "TOTAL_SPEND"=sum(dbinom(4:5,5,(sum(diff(df5$TOTAL_SPEND)>0)/(nrow(df5)-1)))))
               )
)



#6


func6 <- function(DATA, j=USD_CAP, nofY=5){
  j <- deparse(substitute(j))
  METRIC <- DATA[[j]]
  minYear <- min(DATA$TIME)
  maxYear <- max(DATA$TIME)
  est <- sum(dbinom((nofY-1):nofY,nofY,(sum(diff(METRIC)>0)/(nrow(DATA)-1))))
  if (nrow(DATA)>=10) {
    result <- message(paste("Based on ",(nrow(DATA)), " datapoints from years ", minYear, "to ", maxYear, ", the probability that ", unique(DATA$LOCATION), " will increase its drug expenditure, in terms of ", j,", in at least ", (nofY-1), " years in the period ", (maxYear+1), " to", (maxYear+1+nofY), " is ", est))
    return(result)}
  else{
    return(message(paste("Unable to calculate probability (n< 10)")))
  }
}
