#Simple Linear Regression on the diamond market in Singapore
diamond <- read.table(header = F, text = "
                      0.3  D VS2  GIA  1302
0.3  E VS1  GIA  1510
                      0.3  G VVS1 GIA  1510
                      0.3  G VS1  GIA  1260
                      0.31 D VS1  GIA  1641
                      0.31 E VS1  GIA  1555
                      0.31 F VS1  GIA  1427
                      0.31 G VVS2 GIA  1427
                      0.31 H VS2  GIA  1126
                      0.31 I VS1  GIA  1126
                      0.32 F VS1  GIA  1468
                      0.32 G VS2  GIA  1202
                      0.33 E VS2  GIA  1327
                      0.33 I VS2  GIA  1098
                      0.34 E VS1  GIA  1693
                      0.34 F VS1  GIA  1551
                      0.34 G VS1  GIA  1410
                      0.34 G VS2  GIA  1269
                      0.34 H VS1  GIA  1316
                      0.34 H VS2  GIA  1222
                      0.35 E VS1  GIA  1738
                      0.35 F VS1  GIA  1593
                      0.35 G VS1  GIA  1447
                      0.35 H VS2  GIA  1255
                      0.36 F VS1  GIA  1635
                      0.36 H VVS2 GIA  1485
                      0.37 F VS2  GIA  1420
                      0.37 H VS1  GIA  1420
                      0.4  F VS1  GIA  1911
                      0.4  H VS1  GIA  1525
                      0.41 F VS1  GIA  1956
                      0.43 H VVS2 GIA  1747
                      0.45 I VS1  GIA  1572
                      0.46 E VVS2 GIA  2942
                      0.48 G VVS2 GIA  2532
                      0.5  E VS1  GIA  3501
                      0.5  E VS1  GIA  3501
                      0.5  F VVS2 GIA  3501
                      0.5  F VS1  GIA  3293
                      0.5  G VS1  GIA  3016
                      0.51 F VVS2 GIA  3567
                      0.51 G VS1  GIA  3205
                      0.52 D VS2  GIA  3490
                      0.52 E VS1  GIA  3635
                      0.52 F VVS2 GIA  3635
                      0.52 F VS1  GIA  3418
                      0.53 D VS1  GIA  3921
                      0.53 F VVS2 GIA  3701
                      0.53 F VS1  GIA  3480
                      0.53 G VVS2 GIA  3407
                      0.54 E VS1  GIA  3767
                      0.54 F VVS1 GIA  4066
                      0.55 E VVS2 GIA  4138
                      0.55 F VS1  GIA  3605
                      0.55 G VVS2 GIA  3529
                      0.56 F VS1  GIA  3667
                      0.56 I VVS2 GIA  2892
                      0.57 G VVS2 GIA  3651
                      0.59 G VVS2 GIA  3773
                      0.6  F VS1  GIA  4291
                      0.62 E VVS1 GIA  5845
                      0.63 G VVS2 GIA  4401
                      0.64 G VVS1 GIA  4759
                      0.66 H VVS1 GIA  4300
                      0.7  F VS1  GIA  5510
                      0.7  G VS1  GIA  5122
                      0.7  H VVS2 GIA  5122
                      0.7  I VS2  GIA  3861
                      0.71 F VVS2 GIA  5881
                      0.71 F VS1  GIA  5586
                      0.71 F VS2  GIA  5193
                      0.71 H VVS2 GIA  5193
                      0.72 F VS2  GIA  5263
                      0.8  I VVS2 GIA  5441
                      0.82 I VS2  GIA  4948
                      0.84 H VS2  GIA  5705
                      0.85 F VS2  GIA  6805
                      0.86 H VVS2 GIA  6882
                      0.89 H VS1  GIA  6709
                      0.9  I VVS2 GIA  6682
                      0.5  E VS1  GIA  3501
                      0.5  G VVS1 GIA  3432
                      0.51 F VVS1 GIA  3851
                      0.55 H IF   GIA  3605
                      0.56 E VS1  GIA  3900
                      0.57 H VVS1 GIA  3415
                      0.6  H IF   GIA  4291
                      0.63 E IF   GIA  6512
                      0.7  E VS1  GIA  5800
                      0.7  F VVS1 GIA  6285
                      0.7  F VS2  GIA  5122
                      0.7  F VS2  GIA  5122
                      0.7  G VS1  GIA  5122
                      0.7  H VVS2 GIA  5122
                      0.71 D VS1  GIA  6372
                      0.71 E VS1  GIA  5881
                      0.71 H VVS2 GIA  5193
                      0.72 E VS1  GIA  5961
                      0.72 H VVS1 GIA  5662
                      0.73 E VS2  GIA  5738
                      0.73 H VS1  GIA  5030
                      0.73 H VS1  GIA  5030
                      0.73 I VVS1 GIA  4727
                      0.73 I VS1  GIA  4221
                      0.74 G VVS2 GIA  5815
                      0.74 H VS2  GIA  4585
                      0.75 D VVS2 GIA  7368
                      0.75 I VVS2 GIA  4667
                      0.75 I VS1  GIA  4355
                      0.76 D IF   GIA  9885
                      0.77 F VVS1 GIA  6919
                      0.78 H VS1  GIA  5386
                      0.8  I VS2  GIA  4832
                      0.83 E VS2  GIA  7156
                      0.9  F VS1  GIA  7680
                      1    D VVS1 GIA 15582
                      1    D VS1  GIA 11419
                      1    E VS1  GIA 10588
                      1    E VS2  GIA  9757
                      1    F IF   GIA 13913
                      1    F VVS2 GIA 10588
                      1    F VS1  GIA 10713
                      1    F VS2  GIA  9480
                      1    G VVS2 GIA  9896
                      1    G VS1  GIA  9619
                      1    G VS2  GIA  9169
                      1    G VS2  GIA  9203
                      1    H VS2  GIA  8788
                      1    I VS1  GIA  8095
                      1    I VS2  GIA  7818
                      1.01 D VVS1 GIA 16008
                      1.01 E VS1  GIA 10692
                      1.01 E VS2  GIA  9853
                      1.01 F VS1  GIA 10272
                      1.01 F VS2  GIA  9573
                      1.01 H VS1  GIA  9153
                      1.01 H VS2  GIA  8873
                      1.01 I VVS1 GIA  8873
                      1.01 I VVS2 GIA  8455
                      1.01 I VS2  GIA  7895
                      1.02 F VS1  GIA 10372
                      1.02 F VS2  GIA  9666
                      1.02 G VVS2 GIA 10090
                      1.03 E VS1  GIA 10900
                      1.04 F VS1  GIA 10571
                      1.04 I IF   GIA  9563
                      1.05 I VVS2 GIA  8781
                      1.06 G VS2  GIA  9743
                      1.06 H VS2  GIA  9302
                      1.07 I VVS2 GIA  8945
                      1.1  H VS2  GIA  9646
                      0.18 F VVS1 IGI   823
                      0.18 F VVS2 IGI   765
                      0.18 G IF   IGI   803
                      0.18 G IF   IGI   803
                      0.18 G VVS2 IGI   705
                      0.18 H IF   IGI   725
                      0.19 D VVS2 IGI   967
                      0.19 E IF   IGI  1050
                      0.19 F IF   IGI   967
                      0.19 F VVS1 IGI   863
                      0.19 F VVS2 IGI   800
                      0.19 G IF   IGI   842
                      0.19 G VVS1 IGI   800
                      0.19 H IF   IGI   758
                      0.2  D VS1  IGI   880
                      0.2  G IF   IGI   880
                      0.2  G VS1  IGI   705
                      0.2  G VS2  IGI   638
                      0.21 D VS1  IGI   919
                      0.21 E IF   IGI  1149
                      0.21 F IF   IGI  1057
                      0.21 G IF   IGI   919
                      0.22 E IF   IGI  1198
                      0.23 E IF   IGI  1248
                      0.23 F IF   IGI  1147
                      0.23 G IF   IGI   995
                      0.24 H IF   IGI  1108
                      0.25 F IF   IGI  1485
                      0.25 G IF   IGI  1283
                      0.25 H IF   IGI  1149
                      0.25 I IF   IGI  1082
                      0.26 F IF   IGI  1539
                      0.26 F VVS1 IGI  1365
                      0.26 F VVS2 IGI  1260
                      0.26 I IF   IGI  1121
                      0.27 F IF   IGI  1595
                      0.27 H IF   IGI  1233
                      0.28 I IF   IGI  1199
                      0.29 G IF   IGI  1471
                      0.29 I IF   IGI  1238
                      0.3  E VVS2 IGI  1580
                      0.3  F VVS2 IGI  1459
                      0.3  G VVS1 IGI  1459
                      0.3  H VVS2 IGI  1218
                      0.3  I IF   IGI  1299
                      0.31 E VVS2 IGI  1628
                      0.31 F VVS1 IGI  1628
                      0.31 I IF   IGI  1337
                      0.32 H IF   IGI  1462
                      0.33 H IF   IGI  1503
                      0.34 F VVS1 IGI  1773
                      0.34 F VVS2 IGI  1636
                      0.35 F VVS1 IGI  1821
                      0.35 G VVS2 IGI  1540
                      0.4  G IF   IGI  2276
                      0.41 I VVS1 IGI  1616
                      0.41 I VVS2 IGI  1506
                      0.47 F VVS2 IGI  2651
                      0.48 F VS1  IGI  2383
                      0.5  G IF   IGI  3652
                      0.51 E VVS2 IGI  3722
                      0.51 F VVS1 IGI  3722
                      0.52 I IF   IGI  3095
                      0.55 F VVS2 IGI  3706
                      0.56 E VVS2 IGI  4070
                      0.56 G VVS2 IGI  3470
                      0.58 E VVS1 IGI  4831
                      0.58 F VVS1 IGI  4209
                      0.58 G VVS1 IGI  3821
                      0.7  G VVS1 IGI  5607
                      0.7  G VVS2 IGI  5326
                      0.71 D VS1  IGI  6160
                      0.76 F VVS2 IGI  6095
                      0.78 G VVS2 IGI  5937
                      1    H VVS2 IGI  9342
                      1.01 G VS1  IGI  9713
                      1.01 H VS2  IGI  8873
                      1.01 I VS1  IGI  8175
                      0.5  F VVS1 HRD  3778
                      0.5  G VVS1 HRD  3432
                      0.51 F VVS1 HRD  3851
                      0.52 E VS2  HRD  3346
                      0.52 H VVS1 HRD  3130
                      0.53 F VVS1 HRD  3995
                      0.53 F VVS2 HRD  3701
                      0.55 G VVS2 HRD  3529
                      0.56 F VS1  HRD  3667
                      0.56 F VS2  HRD  3202
                      0.57 F VS2  HRD  3256
                      0.57 H VVS1 HRD  3415
                      0.58 H IF   HRD  3792
                      0.6  G VS1  HRD  3925
                      0.6  G VS2  HRD  3421
                      0.6  H VVS1 HRD  3925
                      0.61 H VVS2 HRD  3616
                      0.62 I VVS2 HRD  3615
                      0.64 H VVS2 HRD  3785
                      0.65 I VVS2 HRD  3643
                      0.66 H VVS1 HRD  4300
                      0.7  E VVS1 HRD  6867
                      0.7  E VVS2 HRD  6285
                      0.7  G VVS1 HRD  5800
                      0.7  G VVS2 HRD  5510
                      0.7  H VS2  HRD  4346
                      0.71 G IF   HRD  6372
                      0.71 H VVS2 HRD  5193
                      0.72 H VVS1 HRD  5662
                      0.73 F VS2  HRD  5333
                      0.73 G VVS1 HRD  6041
                      0.74 H VVS1 HRD  5815
                      0.8  F IF   HRD  8611
                      0.8  F VS1  HRD  6905
                      0.8  G VVS2 HRD  6905
                      0.8  H VVS2 HRD  6416
                      0.8  H VS1  HRD  6051
                      0.81 E VVS1 HRD  8715
                      0.81 E VS2  HRD  6988
                      0.81 F VS1  HRD  6988
                      0.81 G VS1  HRD  6495
                      0.81 H IF   HRD  7358
                      0.82 F VS2  HRD  6572
                      0.82 G VVS2 HRD  7072
                      0.85 F VVS1 HRD  8359
                      0.85 F VS2  HRD  6805
                      0.85 G VVS1 HRD  7711
                      0.86 H VS2  HRD  5835
                      1    D VVS2 HRD 13775
                      1    E VVS1 HRD 14051
                      1    E VVS2 HRD 11419
                      1    E VS1  HRD 10588
                      1    F VVS1 HRD 11696
                      1    F VVS2 HRD 10588
                      1    G VVS1 HRD 10450
                      1    G VVS2 HRD  9896
                      1    G VS2  HRD  9203
                      1    H VVS1 HRD  9480
                      1    H VS1  HRD  9065
                      1    H VS2  HRD  8788
                      1    I VVS1 HRD  8788
                      1    I VVS2 HRD  8372
                      1    I VS1  HRD  8095
                      1    I VS2  HRD  7818
                      1.01 D VVS2 HRD 13909
                      1.01 E VVS2 HRD 11531
                      1.01 E VS1  HRD 10692
                      1.01 F VVS1 HRD 11811
                      1.01 F VS1  HRD 10272
                      1.01 G VVS2 HRD  9993
                      1.01 G VS2  HRD  9293
                      1.01 H VVS2 HRD  9433
                      1.01 H VS1  HRD  9153
                      1.01 I VVS1 HRD  8873
                      1.01 I VS1  HRD  8175
                      1.02 F VVS2 HRD 10796
                      1.06 H VVS2 HRD  9890
                      1.02 H VS2  HRD  8959
                      1.09 I VVS2 HRD  9107
                      ")
#label the columns of the data frame
names(diamond)<-c("Carat","Color","Clarity","Cert","Price")
#plot carat and price naturally
library(ggplot2)
qplot(Carat, Price, data = diamond,
     geom = "point",
     ylab = "Price (Singapore $)")
#the plot seems to be following a curve

#take the ln of the data and then plot again
diamond$ln_Carat <- log(diamond$Carat)
diamond$ln_Price <- log(diamond$Price)
qplot(ln_Carat, ln_Price, data = diamond, 
     geom = "point",
     xlab = "Natural Log of Carat",
     ylab = "Natural Log of Price (Singapore $)")
#The data now meets the assumptions of a linear model

#Analysis:
#The response variable is the ln of the Price of the diamond, and the explanatory variable is the ln of the Carat of the diamond
#We will be using the log data so  the model is:
#ln(Price) = Beta0 + Beta1ln(Carat) + epsilon ~ N(0, sigma^2)
#fit the model:
out.diamond <- lm(ln_Price~ln_Carat, data = diamond)
summary(out.diamond)
#95% Confidence Interval for Beta1
confint(out.diamond)
#We are 95% confident that when Carat is increase by 1 percent, the true mean percent increase in Price 
#is between 1.5 and 1.57. Thus Carat is useful in predicting Price, as 0 is not in our inteval. 

#the value beta1_hat = 1.53726 means that for a one percent increase in Carat size we would expect
#a 1.537 percent increase in the price.
qplot(ln_Carat, ln_Price, data = diamond,
      geom = "smooth", formula = y~x, method = "lm", se = T,
      xlab = "ln Diamond Carat",
      ylab = "ln Diamond Price (Singapore $)")

#Predict price of a 1 carat diamond, in our current model that would be ln(1) which is just 0, so this will just
#be the exponentiation of the y-intercept
exp(9.13)
#95% prediction interval at carat = 1 which means the ln of the Carat would be 0
exp(predict(out.diamond, newdata = data.frame(ln_Carat = 0), interval = "prediction"))

#model for estimated price: ln(price_hat) = beta0_hat + ln(Carat)beta1_hat

#Create publication quality graphic
plot.df <- cbind(diamond, exp(predict(out.diamond, interval = "prediction")))
ggplot(plot.df,aes(Carat,Price))+
  xlab("Carat of Diamond")+
  ylab("Price of Diamond (Singapore $)") +
  geom_point() +
  geom_line(aes(y=fit),color = "green") +
  geom_line(aes(y =lwr), color = "red", linetype = "dashed") +
  geom_line(aes(y = upr), color = "red", linetype = "dashed")

#The real R^2 (not the fake R^2)
1- sum((diamond$Price - exp(predict(out.diamond)))^2) / sum((diamond$Price - mean(diamond$Price))^2)
#R^2 is .905 which means the model accounts for 90% percent of the variation in the respone variable, so it predicts
#fairly well

#summary statistics of the absolute prediction error
summary(abs(diamond$Price   - exp(predict(out.diamond))))
#The model predicts very well for lower values of Carat, and predits poorly for higher values of Carat.
#This is because there are other factors in play, we are only examining Carat, only one of the 4 C's. 
#Cut, for example, makes a huge difference in the price of the diamond, even for the same carat. 
