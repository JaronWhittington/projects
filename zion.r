
#Zion NP,Bookmark this report: https://irma.nps.gov/Stats/SSRSReports/Park%20Specific%20Reports/Annual%20Park%20Recreation%20Visitation%20(1904%20-%20Last%20Calendar%20Year)
#Forecast to predict annual number of visitors to zion national park
#Data retrieved on January 8 2018

zion <- read.csv(header = TRUE, text = '
Year,RecreationVisitors,TotalRecreationVisitors
1919,"1,814","111,311,078"
1920,"3,692","111,311,078"
1921,"2,937","111,311,078"
1922,"4,109","111,311,078"
1923,"6,408","111,311,078"
1924,"8,400","111,311,078"
1925,"16,817","111,311,078"
1926,"21,964","111,311,078"
1927,"24,303","111,311,078"
1928,"30,016","111,311,078"
1929,"33,383","111,311,078"
1930,"55,297","111,311,078"
1931,"59,186","111,311,078"
1932,"51,650","111,311,078"
1933,"48,763","111,311,078"
1934,"68,801","111,311,078"
1935,"97,280","111,311,078"
1936,"124,393","111,311,078"
1937,"137,404","111,311,078"
1938,"149,075","111,311,078"
1939,"158,063","111,311,078"
1940,"165,029","111,311,078"
1941,"192,805","111,311,078"
1942,"68,797","111,311,078"
1943,"44,089","111,311,078"
1944,"42,243","111,311,078"
1945,"78,280","111,311,078"
1946,"212,280","111,311,078"
1947,"273,953","111,311,078"
1948,"297,571","111,311,078"
1949,"307,881","111,311,078"
1950,"323,402","111,311,078"
1951,"331,079","111,311,078"
1952,"352,921","111,311,078"
1953,"389,445","111,311,078"
1954,"416,800","111,311,078"
1955,"406,800","111,311,078"
1956,"421,200","111,311,078"
1957,"525,100","111,311,078"
1958,"590,700","111,311,078"
1959,"585,000","111,311,078"
1960,"575,800","111,311,078"
1961,"604,700","111,311,078"
1962,"622,100","111,311,078"
1963,"681,100","111,311,078"
1964,"705,200","111,311,078"
1965,"763,600","111,311,078"
1966,"815,200","111,311,078"
1967,"788,400","111,311,078"
1968,"877,100","111,311,078"
1969,"904,300","111,311,078"
1970,"903,600","111,311,078"
1971,"897,000","111,311,078"
1972,"889,417","111,311,078"
1973,"993,800","111,311,078"
1974,"859,300","111,311,078"
1975,"1,055,200","111,311,078"
1976,"1,090,000","111,311,078"
1977,"1,105,900","111,311,078"
1978,"1,193,212","111,311,078"
1979,"1,040,528","111,311,078"
1980,"1,123,846","111,311,078"
1981,"1,288,808","111,311,078"
1982,"1,246,290","111,311,078"
1983,"1,273,030","111,311,078"
1984,"1,377,254","111,311,078"
1985,"1,503,272","111,311,078"
1986,"1,670,503","111,311,078"
1987,"1,777,619","111,311,078"
1988,"1,948,332","111,311,078"
1989,"1,998,856","111,311,078"
1990,"2,102,400","111,311,078"
1991,"2,236,997","111,311,078"
1992,"2,390,626","111,311,078"
1993,"2,392,580","111,311,078"
1994,"2,270,871","111,311,078"
1995,"2,430,162","111,311,078"
1996,"2,498,001","111,311,078"
1997,"2,445,534","111,311,078"
1998,"2,370,048","111,311,078"
1999,"2,449,664","111,311,078"
2000,"2,432,348","111,311,078"
2001,"2,217,779","111,311,078"
2002,"2,592,545","111,311,078"
2003,"2,458,792","111,311,078"
2004,"2,677,342","111,311,078"
2005,"2,586,665","111,311,078"
2006,"2,567,350","111,311,078"
2007,"2,657,281","111,311,078"
2008,"2,690,154","111,311,078"
2009,"2,735,402","111,311,078"
2010,"2,665,972","111,311,078"
2011,"2,825,505","111,311,078"
2012,"2,973,607","111,311,078"
2013,"2,807,387","111,311,078"
2014,"3,189,696","111,311,078"
2015,"3,648,846","111,311,078"
2016,"4,295,127","111,311,078"
')

#check the data was read in correctly
tail(zion)

#calculate summary statistics

#first convert visitors to numerical

zion$RecreationVisitors<-as.numeric(gsub(',','',zion$RecreationVisitors))

mean(zion$RecreationVisitors)
sd(zion$RecreationVisitors)

#change visitors units to millions
zion$RecreationVisitors <- zion$RecreationVisitors / 10^6

#EDA

#plot the time series

plot(RecreationVisitors~Year, data = zion, type = 'b', ylab = "Zion NP Annual Visitors (in millions)")

#observed curvature so we are going to do a log transformation
#this will make the multiplicative effect become an additive effect. 

zion$logvisitors <- log(zion$RecreationVisitors)

#plot the transformation to confirm the relationship appears more additive

plot(logvisitors~Year, data = zion, type = 'b', ylab = "Zion NP Log-Annual Visiotrs (in millions)")

#There appears to be a non-constant mean change
#This is mostl likely due to very early years being less popular 
#and a large drop-off during WWII
#After WWII Zion's became a more popular destination 
#After this there appears to be a much more constant mean change
#Let's filter to the recent past, say since 1960

zion_recent <- subset(zion, Year>1960)

#now lets plot the recent past log transformation to confirm conditions are now met

plot(logvisitors~Year, data = zion_recent, type = 'b', ylab = "Zion NP Log-Annual Visitors (in millions)")

#It looks pretty good now! 
#A note of interest correlation coefficient is now at .974

#Let's talk about our model
#We need to take in to account "short memory" and "long memory"
#We'll be ignoring cross correlation for sake of simplicity
#We'll use an ARIMA(1,1,1) model 
#We're modeling the change from year to year (yt+1 - yt) = some average (mu) + some info from last years data 
#plus error for next year + error from last year
#We'll estimate our parameters by maximum likelihood 
#To fit our model we will download the astsa and use the sarima function 
#Estimate the ARIMA(1,1,1) parameters and standard errors 
#We need mu, phi, and theta estimates 

library(astsa)
zion_recent.out<-sarima(zion_recent$logvisitors,1,1,1)
zion_recent.out

#predict using the estimated model and prediction intervals (the next 5 years)

zion_recent.future <- sarima.for(zion_recent$logvisitors,n.ahead = 5, 1,1,1)
zion_recent.future

#compute prediction intervals

zion_recent.L <- zion_recent.future$pred - qnorm(.975)*zion_recent.future$se
zion_recent.U <- zion_recent.future$pred + qnorm(.975)*zion_recent.future$se

#uNtransform

zion_recent.yhat <- exp(zion_recent.future$pred)
zion_recent.yhat.L <- exp(zion_recent.L)
zion_recent.yhat.U <- exp(zion_recent.U)

cbind(zion_recent.yhat,zion_recent.yhat.L,zion_recent.yhat.U)

#create graphic showing our final results and forecast
 
plot(RecreationVisitors~Year,data=zion,type="b",
     ylab="Zion NP Annual Visitors (in millions)",
     xlim=c(1990,2021),ylim=c(1,6.7))
lines(2017:2021,exp(zion_recent.future$pred),col="darkorange2",type="b",pch=19)
lines(2017:2021,zion_recent.yhat.L,col="darkorange2",lty=2)
lines(2017:2021,zion_recent.yhat.U,col="darkorange2",lty=2)

# Research Task: Predict Future Values
# Data Features: Time Series, Correlation observed in past is expected to continue next 5 years

# Analysis Weaknesses: No examination of "why" ... that is, no explanatory variables

#Challenge: Predicting future values of annual visitors to Golden Spike
