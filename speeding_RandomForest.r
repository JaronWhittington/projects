#Jaron Whittington
#Montgomery County Traffic Stops Data
#Random Forest model to predict how fast we can go over the speed limit and how to only get a warning 

stops.full<-read.csv("http://data.montgomerycountymd.gov/api/views/4mse-ku6q/rows.csv?accessType=DOWNLOAD",
                     header=TRUE,as.is=TRUE)

# subset to last year
last.year<-2017
stops.full$AutoYear<-as.numeric(stops.full$Year)
stops.full$Year<-as.numeric(substr(stops.full$Date.Of.Stop,7,10))
stops.last<-subset(stops.full,Year==last.year)
# delete the really big data set 
rm(stops.full)

# Create Month and Hour variables
stops.last$Month<-as.numeric(substr(stops.last$Date.Of.Stop,1,2))
stops.last$Hour<-as.numeric(substr(stops.last$Time.Of.Stop,1,2))

# clean up dataset
stops.last$AutoState<-stops.last$State
stops.last$Out.of.State<-(stops.last$AutoState!="MD")

stops.last$Color<-as.character(stops.last$Color)
stops.last$Color[stops.last$Color %in% c("CAMOUFLAGE","CHROME","COPPER","CREAM","MULTICOLOR","N/A","PINK")]<-"OTHER"
stops.last$Color<-factor(stops.last$Color)

# other filters
stops.last<-subset(stops.last,Color != "N/A")
stops.last<-subset(stops.last,Color != "")
stops.last<-subset(stops.last,Gender != "U")
stops.last<-subset(stops.last,HAZMAT == "No")
stops.last<-subset(stops.last,AutoYear > 1990 & AutoYear < last.year+2)

# convert character variables to factors
stops.last$SubAgency<-factor(stops.last$SubAgency)
stops.last$Accident<-factor(stops.last$Accident)
stops.last$Belts<-factor(stops.last$Belts)
stops.last$Personal.Injury<-factor(stops.last$Personal.Injury)
stops.last$Property.Damage<-factor(stops.last$Property.Damage)
stops.last$Commercial.License<-factor(stops.last$Commercial.License)
stops.last$Commercial.Vehicle<-factor(stops.last$Commercial.Vehicle)
stops.last$Alcohol<-factor(stops.last$Alcohol)
stops.last$Work.Zone<-factor(stops.last$Work.Zone)
stops.last$Contributed.To.Accident<-factor(stops.last$Contributed.To.Accident)
stops.last$Race<-factor(stops.last$Race)
stops.last$Gender<-factor(stops.last$Gender)
stops.last$Out.of.State<-factor(stops.last$Out.of.State)


# Create dataset for Speeding
#  example: EXCEEDING MAXIMUM SPEED: 49 MPH IN A POSTED 40 MPH ZONE
speed.last1<-subset(stops.last,substr(Description,1,23)=="EXCEEDING MAXIMUM SPEED")
# difference between cited speed and posted speed limit
speed.last1$speed<-as.numeric(substr(speed.last1$Description,26,27))-as.numeric(substr(speed.last1$Description,45,46))
speed.last1<-subset(speed.last1,!is.na(speed))
#  example: EXCEEDING POSTED MAXIMUM SPEED LIMIT: 39 MPH IN A POSTED 30 MPH ZONE
speed.last2<-subset(stops.last,substr(Description,1,30)=="EXCEEDING POSTED MAXIMUM SPEED")
# difference between cited speed and posted speed limit
speed.last2$speed<-as.numeric(substr(speed.last2$Description,39,40))-as.numeric(substr(speed.last2$Description,58,59))
speed.last2<-subset(speed.last2,!is.na(speed))
# combine and subset to columns of interest
speed.last<-rbind(speed.last1,speed.last2)
speed.last<-speed.last[,c(4,9:12,14,16:18,24,28:30,36:38,40,41)]



# Create dataset for Ticket/Warning
ticket.last<-subset(stops.last,Violation.Type %in% c("Citation","Warning") )
ticket.last$Ticket<-factor(ticket.last$Violation.Type=="Citation")
# subset to columns of interest
ticket.last<-ticket.last[,c(4,9:12,14,17,18,24,28:30,36:38,40,41)]


# make a prediction at a new observation
#  note: grab an observation in the dataset that is very similar to my situation and change it
new.obs<-speed.last[25,]
new.obs$AutoYear<-2017
new.obs$Month<-8
new.obs$Hour<-18

#compute summary statistics
mean(speed.last$speed)
sd(speed.last$speed)
median(speed.last$speed)

#examine shape of the response variable
hist(speed.last$speed, breaks = c(0,5,10,15,20,25,30,35,40,45,50,55,60,65), xlab = "Difference in cited speed and posted speed limit", 
     main = "Speed over the limit in Montgomery County", ylab = "Number of Citations")
#Thd data looks bimodal so we need a flexible model 
#We want to find the 'best' explanatory variables 
#We'll create a train and test data set to estimate and then test or model.
set.seed(12) 
train.rows<-sample(9773, 8000)
speed.train <- speed.last[train.rows,]
speed.test<-speed.last[-train.rows,]

#confirm train and test are similar
summary(speed.train$speed)
summary(speed.test$speed)
  
#random Forest model
library(randomForest)

out.speed<-randomForest(x = speed.train[, -18], y = speed.train$speed,
                        xtest = speed.test[, -18], ytest = speed.test$speed, 
                        replace = TRUE, #bootsrap sample
                        keep.forest=TRUE,
                        ntree = 50, mtry = 5, nodesize = 30)

#predict a new observation
predict(out.speed, newdata = new.obs)
  
#compare train prediction error and test prediction error (compare RMSE's)
#these should be about the same size, if train's is too small we have overfit the model
out.speed
train_RMSE <- sqrt(49.06669)
test_RMSE <- sqrt(50.27)
#They are very similar


#model interpretability (how often were explanatory variables used)
importance(out.speed)
varImpPlot(out.speed)
#the most important effects are:
#SubAgency, color, and time of day

#TICKET OR WARNING CLASSIFICATION

#Class particiption 2
summary(ticket.last)
total <- length(ticket.last$Ticket)
#frequency table and proportion table
table(ticket.last$Ticket)
table(ticket.last$Ticket) / total

#Create dataset with half goods (warnings) and half bads (tickets)
all.bad <- subset(ticket.last, Ticket == "TRUE")
n.bad <- dim(all.bad)[1]
#SRS without replacement of the goods
all.good <- subset(ticket.last, Ticket == "FALSE")
n.good <- dim(all.good)[1]
set.seed(12)
rows.good <- sample(n.good, n.bad)
sample.good <- all.good[rows.good,]

#combine
ticket.model <- rbind(all.bad, sample.good)

#create train and test datasets
ticket.train.rows <- sample(159182, 128000)
ticket.train <- ticket.model[ticket.train.rows,]
ticket.test <- ticket.model[-ticket.train.rows,]
#confirm they are similar
summary(ticket.train$Ticket)
summary(ticket.test$Ticket)
#the datasets are indeed similar

#fit the random forest model
library(RandomForest)
out.ticket<-randomForest(x = ticket.train[, -17], y = ticket.train$Ticket,
                        xtest = ticket.test[, -17], ytest = ticket.test$Ticket, 
                        replace = TRUE, #bootsrap sample
                        keep.forest=TRUE,
                        ntree = 50, mtry = 5, nodesize = 30)
#report misclassification rates
out.ticket
#predict with new observation
predict(out.ticket, newdata = new.obs)
#Prediction was to get a warning

#identify important explanatory variables
importance(out.ticket)
varImpPlot(out.ticket)
#the three most important were color, hour of the day, and year of the car


