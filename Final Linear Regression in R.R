#Importing 
require(MASS)
library(readxl)
require(car)
library(dplyr)

linear<-read_excel("Linear Regression Case.xlsx")

linear$TOTALSPEND<-linear$cardspent+linear$card2spent
linear$TOTALITEM = linear$carditems+linear$card2items
linear$TOTAL_CARDFEE = linear$cardfee +linear$card2fee
linear$LNTOTALSPEND = log(linear$TOTALSPEND)

#Understanding Data
str(linear)
head(linear)
tail(linear)
dim(linear)
nrow(linear)
summary(linear)

mystats <- function(x) {
  n <- length(x)
  nmiss <- sum(is.na(x))
  m <- mean(x,na.rm=T)
  s <- sd(x,na.rm=T)
  min <- min(x,na.rm=T)
  pctl <- quantile(x, na.rm=T, p=c(0.01,0.05,0.1,0.25,0.5,0.75,0.9, 0.95,0.99))
  max <- max(x,na.rm=T)
  UC <- m+3*s
  LC <- m-3*s
  return(c(n=n, nmiss=nmiss, mean=m, stdev=s,min = min, pctl=pctl, max=max, UC=UC, LC=LC))
}

vars <- c( "income",
           "lninc",
           "debtinc",
           "creddebt",
           "lncreddebt",
           "othdebt",
           "lnothdebt",
           "spoused",
           "reside",
           "pets",
           "pets_cats",
           "pets_dogs",
           "pets_birds",
           "pets_reptiles",
           "pets_small",
           "pets_saltfish",
           "pets_freshfish",
           "tenure",
           "longmon",
           "longten",
           "tollmon",
           "tollten",
           "equipmon",
           "equipten",
           "cardmon",
           "cardten",
           "wiremon",
           "wireten"
           )

?apply()
?t
stats<-t(apply(linear[vars], 2, FUN=mystats))
View(stats)

write.csv(stats, file = "D:/R/Linear Regression in R/Linear Regression/stats.csv")


## OUTLIERS
linear $age[linear $age>76]<-76;
linear $ed[linear $ed>20]<-20;
linear $employ[linear $employ>31]<-31;
linear $income[linear $income>147]<-147;
linear $lninc[linear $lninc>4.9904326]<-4.9904326;
linear $debtinc[linear $debtinc>22.2]<-22.2;
linear $creddebt[linear $creddebt>6.385992]<-6.385992;
linear $lncreddebt[linear $lncreddebt>1.856363]<-1.856363;
linear $othdebt[linear $othdebt>11.830208]<-11.830208;
linear $lnothdebt[linear $lnothdebt>2.4719916]<-2.4719916;
linear $spoused[linear $spoused>18]<-18;
linear $spousedcat[linear $spousedcat>4]<-4;
linear $reside[linear $reside>5]<-5;
linear $pets[linear $pets>10]<-10;
linear $pets_cats[linear $pets_cats>2]<-2;
linear $pets_dogs[linear $pets_dogs>2]<-2;
linear $pets_birds[linear $pets_birds>1]<-1;
linear $pets_reptiles[linear $pets_reptiles>0]<-0;
linear $pets_small[linear $pets_small>1]<-1;
linear $pets_saltfish[linear $pets_saltfish>0]<-0;
linear $pets_freshfish[linear $pets_freshfish>8]<-8;
linear $address[linear $address>40]<-40;
linear $addresscat[linear $addresscat>5]<-5;
linear $cars[linear $cars>4]<-4;
linear $carvalue[linear $carvalue>72]<-72;
linear $commute[linear $commute>8]<-8;
linear $commutecat[linear $commutecat>4]<-4;
linear $commutetime[linear $commutetime>35]<-35;
linear $polview[linear $polview>6]<-6;
linear $card[linear $card>4]<-4;
linear $cardtenure[linear $cardtenure>38]<-38;
linear $card2tenure[linear $card2tenure>29]<-29;
linear $carditems[linear $carditems>16]<-16;
linear $cardspent[linear $cardspent>782.545]<-782.545;
linear $card2items[linear $card2items>9]<-9;
linear $card2spent[linear $card2spent>419.51]<-419.51;
linear $tenure[linear $tenure>72]<-72;
linear $longmon[linear $longmon>36.825]<-36.825;
linear $lnlongmon[linear $lnlongmon>3.6061749]<-3.6061749;
linear $longten[linear $longten>2576.85]<-2576.85;
linear $lnlongten[linear $lnlongten>7.854323]<-7.854323;
linear $tollmon[linear $tollmon>43.5]<-43.5;
linear $lntollmon[linear $lntollmon>3.9269116]<-3.9269116;
linear $tollten[linear $tollten>2620.33]<-2620.33;
linear $lntollten[linear $lntollten>8.1084728]<-8.1084728;
linear $equipmon[linear $equipmon>49.075]<-49.075;
linear $lnequipmon[linear $lnequipmon>4.0656021]<-4.0656021;
linear $equipten[linear $equipten>2601.35]<-2601.35;
linear $lnequipten[linear $lnequipten>8.1177449]<-8.1177449;
linear $cardmon[linear $cardmon>42]<-42;
linear $lncardmon[linear $lncardmon>3.8394523]<-3.8394523;
linear $cardten[linear $cardten>2460]<-2460;
linear $lncardten[linear $lncardten>7.9247959]<-7.9247959;
linear $wiremon[linear $wiremon>51.35]<-51.35;
linear $lnwiremon[linear $lnwiremon>4.2675973]<-4.2675973;
linear $wireten[linear $wireten>2691.28]<-2691.28;
linear $lnwireten[linear $lnwireten>8.3113983]<-8.3113983;
linear $hourstv[linear $hourstv>28]<-28;
linear $age[linear $age<20]<-20;
linear $ed[linear $ed<9]<-9;
linear $income[linear $income<13]<-13;
linear $lninc[linear $lninc<2.5649494]<-2.5649494;
linear $debtinc[linear $debtinc<1.9]<-1.9;
linear $creddebt[linear $creddebt<0.101088]<-0.101088;
linear $lncreddebt[linear $lncreddebt<-2.2917639]<--2.2917639;
linear $othdebt[linear $othdebt<0.287353]<-0.287353;
linear $lnothdebt[linear $lnothdebt<-1.2457327]<--1.2457327;
linear $address[linear $address<1]<-1;
linear $commutetime[linear $commutetime<16]<-16;
linear $polview[linear $polview<2]<-2;
linear $cardtenure[linear $cardtenure<1]<-1;
linear $card2tenure[linear $card2tenure<1]<-1;
linear $carditems[linear $carditems<5]<-5;
linear $cardspent[linear $cardspent<91.255]<-91.255;
linear $card2items[linear $card2items<1]<-1;
linear $card2spent[linear $card2spent<14.815]<-14.815;
linear $tenure[linear $tenure<4]<-4;
linear $longmon[linear $longmon<2.9]<-2.9;
linear $lnlongmon[linear $lnlongmon<1.0647107]<-1.0647107;
linear $longten[linear $longten<12.5]<-12.5;
linear $lnlongten[linear $lnlongten<2.5257286]<-2.5257286;
linear $lntollmon[linear $lntollmon<2.5839976]<-2.5839976;
linear $lntollten[linear $lntollten<4.2046926]<-4.2046926;
linear $lnequipmon[linear $lnequipmon<3.1398326]<-3.1398326;
linear $lnequipten[linear $lnequipten<4.2492093]<-4.2492093;
linear $lncardmon[linear $lncardmon<1.9810015]<-1.9810015;
linear $lncardten[linear $lncardten<4.0943446]<-4.0943446;
linear $lnwiremon[linear $lnwiremon<2.9907197]<-2.9907197;
linear $lnwireten[linear $lnwireten<4.0968414]<-4.0968414;
linear $hourstv[linear $hourstv<12]<-12;



#DISTRIBUTION
hist(linear$TOTALSPEND)
hist(linear$LNTOTALSPEND)

#Missing Value imputation:
#REMOVING THESE LOG VARIABLES BECAUSE MORE THAN 50% DATA IS MISSING, THEREFORE OF NO USE.
linear$lnequipmon <- NULL
linear$lnequipten <- NULL
linear$lncardmon <- NULL
linear$lncardten <- NULL
linear$lnwiremon <- NULL
linear$lnwireten <- NULL
linear$lntollmon <- NULL
linear$lntollten <- NULL

#ANOVA
fit <- aov(linear$LNTOTALSPEND ~region+
             townsize+
             gender+
             age+
             agecat+
             ed+
             edcat+
             jobcat+
             union+
             employ+
             empcat+
             retire+
             inccat+
             default+
             jobsat+
             marital+
             spousedcat+
             homeown+
             hometype+
             address+
             addresscat+
             cars+
             carown+
             cartype+
             carvalue+
             carcatvalue+
             carbought+
             carbuy+
             commute+
             commutecat+
             commutetime+
             commutecar+
             commutemotorcycle+
             commutecarpool+
             commutebus+
             commuterail+
             commutepublic+
             commutebike+
             commutewalk+
             commutenonmotor+
             telecommute+
             reason+
             polview+
             polparty+
             polcontrib+
             vote+
             card+
             cardtype+
             cardbenefit+
             cardfee+
             cardtenure+
             cardtenurecat+
             card2+
             card2type+
             card2benefit+
             card2fee+
             card2tenure+
             card2tenurecat+
             active+
             bfast+
             churn+
             tollfree+
             equip+
             callcard+
             wireless+
             multline+
             voice+
             pager+
             internet+
             callid+
             callwait+
             forward+
             confer+
             ebill+
             owntv+
             hourstv+
             ownvcr+
             owndvd+
             owncd+
             ownpda+
             ownpc+
             ownipod+
             owngame+
             ownfax+
             news+
             response_01+
             response_02+
             response_03, data=linear)
ls(fit)
summary(fit)

# SIGNIFICANT CATEGORICAL variables

linear$region <- as.factor(linear$region)              
linear$gender <- as.factor(linear$gender)            
linear$agecat <- as.factor(linear$agecat)             
linear$ed <- as.factor(linear$ed)                
linear$union  <- as.factor(linear$union)               
linear$employ <- as.factor(linear$employ)              
linear$empcat <- as.factor(linear$empcat)           
linear$retire <- as.factor(linear$retire)              
linear$inccat <- as.factor(linear$inccat)
linear$carbought <- as.factor(linear$carbought)
linear$commutenonmotor <- as.factor(linear$commutenonmotor)
linear$card <- as.factor(linear$card)
linear$card2 <- as.factor(linear$card2)
linear$internet <- as.factor(linear$internet)
linear$ownvcr <- as.factor(linear$ownvcr)              
linear$owndvd <- as.factor(linear$owndvd)
linear$response_03 <- as.factor(linear$response_03)

################################## STEPWISE REGRESSION ON linear #####################
#linear<- na.omit(linear)

fit_reg <- lm(LNTOTALSPEND ~ region+               
              gender+             
              agecat+              
              ed+                 
              union+                
              employ+  
              empcat+           
              retire+              
              inccat+
              carbought+
              commutenonmotor+
              card+
              card2+
              internet+ 
              ownvcr+              
              owndvd+
              response_03+
              lninc+
              debtinc+
              creddebt+
              lncreddebt+
              othdebt+
              lnothdebt+
              spoused+
              reside+
              pets+
              pets_cats+
              pets_dogs+
              pets_birds+
              pets_reptiles+
              pets_small+
              pets_saltfish+
              pets_freshfish+
              tenure+
              longmon+
              longten+
              tollmon+
              tollten+
              equipten+
              cardmon+
              cardten+
              wiremon+
              wireten, linear)

summary(fit_reg)

step <- stepAIC(fit_reg,scale = 0, direction="both")

#display result
step$anova
summary(fit_reg)

#Final Model:
#  LNTOTALSPEND ~ gender + agecat + card + card2 + internet + 
 # ownvcr + response_03 + lninc + creddebt + cardmon + wiremon + 
  #wireten

##################################################################################
set.seed(1803)

#Splitting data into Training, Validaton and Testing Dataset
train_data<- sample(1:nrow(linear), size = floor(0.70 * nrow(linear)))

training<-linear[train_data,]
testing<-linear[-train_data,]

install.packages("car")
require(car)

install.packages("MASS")
library(MASS)

############################   REGRESSION ANALYSIS  
class(training$response_03)

train_fit <- lm(LNTOTALSPEND ~ gender + agecat  + card + card2 + 
                  internet + ownvcr + response_03 + lninc + creddebt + cardmon + 
                  wiremon + wireten, data=training)

train_step <- stepAIC(train_fit, direction="both")

step$anova # display results
summary(train_fit)

#REMOVING COOKS D VARS
training$cd<- cooks.distance(train_fit)
training2<- subset(training, cd< 4/3500)

train_fit <- lm(LNTOTALSPEND ~ gender + agecat + card + card2 + 
                  internet + ownvcr + response_03 + lninc + creddebt + cardmon + 
                  wiremon + wireten, data=training2)


train_step <- stepAIC(train_fit, direction="both")

training2$cd<- cooks.distance(train_fit)
training3<- subset(training2, cd< 4/3339)

#REMOVING COOKS D VARS
train_fit <- lm(LNTOTALSPEND ~ gender + agecat + card + card2 + 
                  internet + ownvcr + response_03 + lninc + creddebt + cardmon + 
                  wiremon + wireten, data=training3)

train_step <- stepAIC(train_fit, direction="both")

training3$cd<- cooks.distance(train_fit)
training4<- subset(training3, cd< 4/3206)

#REMOVING COOKS D VARS
train_fit <- lm(LNTOTALSPEND ~ gender + agecat + card + card2 + 
                  internet + ownvcr + response_03 + lninc + creddebt + cardmon + 
                  wiremon + wireten, data=training4)

train_step <- stepAIC(train_fit, direction="both")

training4$cd<- cooks.distance(train_fit)
training5<- subset(training4, cd< 4/3206)

#REMOVING COOKS D VARS
train_fit <- lm(LNTOTALSPEND ~ gender + agecat + card + card2 + 
                  internet + ownvcr + response_03 + lninc + creddebt + cardmon + 
                  wiremon + wireten, data=training5)

train_step <- stepAIC(train_fit, direction="both")
summary(train_fit)

#REMOVING COOKS D VARS
training5$cd<- cooks.distance(train_fit)
training6<- subset(training5, cd< 4/3063)

train_fit <- lm(LNTOTALSPEND ~ gender + agecat + card + card2 + 
                  internet + ownvcr + response_03 + lninc + creddebt + cardmon + 
                  wiremon + wireten, data=training6)

train_step <- stepAIC(train_fit, direction="both")

#FINAL WITHOUT COOKS D VARS 

training8$cd<- cooks.distance(train_fit)
training9<- subset(training8, cd< 4/3026)

train_fit <- lm(LNTOTALSPEND ~ gender + agecat  + card + card2 + 
                  internet + ownvcr + response_03 + lninc + creddebt + cardmon + 
                  wiremon + wireten, data=training9)

train_step <- stepAIC(train_fit, direction="both")

########Predict Function#######

t1<-cbind(training9, pred_spent=exp(predict(train_fit,newdata = training9)))

t2<-cbind(testing, pred_spent=exp(predict(train_fit,newdata = testing)))

##################################Decile Analysis Reports - t1(training)

# find the decile locations 
decile <- quantile(t1$pred_spent, probs = seq(0.1,0.9,by=0.1),na.rm=TRUE)

# use findInterval with -Inf and Inf as upper and lower bounds
t1$decile <- findInterval(t1$pred_spent,c(-Inf,decile, Inf))

install.packages("sqldf")
require(sqldf)

t1_Dev <- sqldf("select decile, avg(pred_spent) as avg_pre_spent,   
                avg(TOTALSPEND) as avg_Actual_spent
                from t1
                group by decile
                order by decile desc")

View(t1_Dev)

##################################Decile Analysis Reports - t2(testing)

# find the decile locations 
decile <- quantile(t2$pred_spent,probs = seq(0.1,0.9,by=0.1),na.rm = TRUE)

# use findInterval with -Inf and Inf as upper and lower bounds
t2$decile <- findInterval(t2$pred_spent,c(-Inf,decile, Inf))

require(sqldf)
t2_test <- sqldf("select decile, avg(pred_spent) as avg_pre_spent,   
                 avg(TOTALSPEND) as avg_Actual_spent
                 from t2
                 group by decile
                 order by decile desc")
View(t2_test)
