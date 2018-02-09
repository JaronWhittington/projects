#Midterm 1
#Jaron Whittington

#Get the Data

#Q1 example from Dr. Grimshaw
# webscraper for Q1 data from http://www.boxofficemojo.com/quarterly/?chart=byquarter&quarter=Q1

# function that allows reading in data of the form $xxx,xxx,xxx.xx
setClass("AccountingNumber")
setAs("character", "AccountingNumber", 
      function(from) as.numeric(gsub(",", "", gsub("[:$:]", "", from) ) ) )
# data from webpage
library(XML)
# Q1 box office url
q1boxoffice.url<-paste("http://www.boxofficemojo.com/quarterly/?chart=byquarter&quarter=Q1")
# read webpage and store in memory
q1boxoffice.webpage<-htmlParse(q1boxoffice.url)
# create R dataset from webpage contents
q1boxoffice<-readHTMLTable(q1boxoffice.webpage,
                           header=TRUE,which=4,
                           colClasses=c("numeric","AccountingNumber","Percent","numeric",
                                        "AccountingNumber","Percent","character",
                                        "AccountingNumber","Percent") )
# keep only year and gross
q1boxoffice<-q1boxoffice[,1:2]
# change variable name so it doesn't have a space
names(q1boxoffice)<-c("year","gross")

#Q2
# webscraper for Q2 data from http://www.boxofficemojo.com/quarterly/?chart=byquarter&quarter=Q2

# data from webpage
# Q2 box office url
q2boxoffice.url<-paste("http://www.boxofficemojo.com/quarterly/?chart=byquarter&quarter=Q2")
# read webpage and store in memory
q2boxoffice.webpage<-htmlParse(q2boxoffice.url)
# create R dataset from webpage contents
q2boxoffice<-readHTMLTable(q2boxoffice.webpage,
                           header=TRUE,which=4,
                           colClasses=c("numeric","AccountingNumber","Percent","numeric",
                                        "AccountingNumber","Percent","character",
                                        "AccountingNumber","Percent") )
# keep only year and gross
q2boxoffice<-q2boxoffice[,1:2]
# change variable name so it doesn't have a space
names(q2boxoffice)<-c("year","gross")

#Q3
# webscraper for Q3 data from http://www.boxofficemojo.com/quarterly/?chart=byquarter&quarter=Q3

# data from webpage
# Q3 box office url
q3boxoffice.url<-paste("http://www.boxofficemojo.com/quarterly/?chart=byquarter&quarter=Q3")
# read webpage and store in memory
q3boxoffice.webpage<-htmlParse(q3boxoffice.url)
# create R dataset from webpage contents
q3boxoffice<-readHTMLTable(q3boxoffice.webpage,
                           header=TRUE,which=4,
                           colClasses=c("numeric","AccountingNumber","Percent","numeric",
                                        "AccountingNumber","Percent","character",
                                        "AccountingNumber","Percent") )
# keep only year and gross
q3boxoffice<-q3boxoffice[,1:2]
# change variable name so it doesn't have a space
names(q3boxoffice)<-c("year","gross")

#Q4
# webscraper for Q2 data from http://www.boxofficemojo.com/quarterly/?chart=byquarter&quarter=Q4

# data from webpage
# Q4 box office url
q4boxoffice.url<-paste("http://www.boxofficemojo.com/quarterly/?chart=byquarter&quarter=Q4")
# read webpage and store in memory
q4boxoffice.webpage<-htmlParse(q4boxoffice.url)
# create R dataset from webpage contents
q4boxoffice<-readHTMLTable(q4boxoffice.webpage,
                           header=TRUE,which=4,
                           colClasses=c("numeric","AccountingNumber","Percent","numeric",
                                        "AccountingNumber","Percent","character",
                                        "AccountingNumber","Percent") )
# keep only year and gross
q4boxoffice<-q4boxoffice[,1:2]
# change variable name so it doesn't have a space
names(q4boxoffice)<-c("year","gross")

#add qtr to the dataframes
q1boxoffice$qtr <- 1
q2boxoffice$qtr <- 2
q3boxoffice$qtr <- 3
q4boxoffice$qtr <- 4
#create our datframe of all quarters
boxoffice <- rbind(q1boxoffice,q2boxoffice,q3boxoffice,q4boxoffice)

#order the data from oldest to newest
boxoffice <- boxoffice[order(boxoffice$year,boxoffice$qtr),]
#get rid of current quarter (it's not complete)
boxoffice <- boxoffice[-145,]
#plot the data
domain <- c(1:144)
plot(domain,boxoffice$gross, type = 'b', xlab = "Quarter", ylab = "Gross income (in millions)", 
     main = "Gross Box Office income by Quarter")
#fit the model
gross <- boxoffice$gross
library(astsa)
gross.out <- sarima(gross, 1,1,1,1,1,1,4)
gross.out$ttable
#forecast for the next 3 years (12 quarters)
gross.future <- sarima.for(gross, n.ahead = 12, 1,1,1,1,1,1,4)
#prediction intervals
L<- gross.future$pred - qnorm(.975)*gross.future$se
U<- gross.future$pred + qnorm(.975)*gross.future$se
#table of predictions
cbind(L,gross.future$pred,U)
#graphic
D_pred <- (145:156)
plot(gross~domain, ylab = "Gross Box Office Income (in millions)", main = "3 Year Gross Box Office Income Predction", 
     xlab = "Quarter", type = 'b',
     xlim=c(100,160), ylim = c(1000,4000))
lines(D_pred, gross.future$pred,col="darkorange2",type="b",pch=19)
lines(D_pred, L, col = "blue", lty = 2)
lines(D_pred, U, col = "blue", lty = 2)
legend(100, 1500, legend = c("Prediction","Prediction Bounds","Historic Data"), col = c("darkorange2","blue", "black"),
       lty = c(1,2,1))
