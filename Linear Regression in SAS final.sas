libname linear '/folders/myfolders/BI/Linear Regression case/new';

proc import datafile='/folders/myfolders/BI/Linear Regression case/new/Linear Regression case.xlsx' 
out=linear.reg_data dbms=xlsx replace;
getnames=yes;
run;

proc contents data=linear.reg_data varnum;
run;

*LABEL CODE;
data linear.reg_data;
set linear.reg_data;
label
custid = "Customer ID"
region = "Geographic indicator"
townsize = "Size of hometown"
gender = "Gender"
age = "Age in years"
agecat = "Age category"
birthmonth = "Birth month"
ed = "Years of education"
edcat = "Level of education"
jobcat = "Job category"
union = "Union member"
employ = "Years with current employer" 
empcat = "Years with current employer"
retire = "Retired"
income = "Household income in thousands"
lninc = "Log-income"
inccat = "Income category in thousands"
debtinc = "Debt to income ratio (x100)"
creddebt = "Credit card debt in thousands"
lncreddebt = "Log-credit card debt"
othdebt = "Other debt in thousands"
lnothdebt = "Log-Other debt"
default = "Ever defaulted on a bank loan"
jobsat = "Job satisfaction"
marital = "Marital status"
spoused = "Spouse years of education"
spousedcat = "Spouse level of education"
reside = "Number of people in household"
pets = "Number of pets owned"
pets_cats = "Number of cats owned"
pets_dogs = "Number of dogs owned"
pets_birds = "Number of birds owned"
pets_reptiles = "Number of reptiles owned"
pets_small = "Number of small animals owned"
pets_saltfish = "Number of saltwater fish owned"
pets_freshfish = "Number of freshwater fish owned"
homeown = "Home ownership"
hometype = "Building type"
address = "Years at current address"
addresscat = "Years at current address"
cars = "Number of cars owned/leased"
carown = "Primary vehicle lease/own"
cartype = "Primary vehicle domestic/import"
carvalue = "Primary vehicle sticker price"
carcatvalue = "Primary vehicle price category"
carbought = "Primary vehicle bought/leased within last year"
carbuy = "Plan to purchase/lease vehicle within next year"
commute = "Primary commute transportation"
commutecat = "Commute category"
commutetime = "Commute time in minutes"
commutecar = "Used car to commute within last year"
commutemotorcycle = "Used motorcycle to commute within last year"
commutecarpool = "Used carpool to commute within last year"
commutebus = "Used bus to commute within last year"
commuterail = "Used train/subway to commute within last year"
commutepublic = "Used other public transport to commute within last year"
commutebike = "Used bike to commute within last year"
commutewalk = "Walked to commute within last year"
commutenonmotor = "Used other non-motorized transport to commute within last year"
telecommute = "Telecommuted within last year"
reason = "Primary reason for being a customer here"
polview = "Political outlook"
polparty = "Political party membership"
polcontrib = "Political contributions"
vote = "Voted in last election"
card = "Primary credit card"
cardtype = "Designation of primary credit card"
cardbenefit = "Benefit program for primary credit card"
cardfee = "Annual fee for primary credit card"
cardtenure = "Years held primary credit card"
cardtenurecat = "Years held primary credit card"
card2 = "Secondary credit card"
card2type = "Designation of secondary credit card"
card2benefit = "Benefit program for secondary credit card"
card2fee = "Annual fee for secondary credit card"
card2tenure = "Years held secondary credit card"
card2tenurecat = "Years held secondary credit card"
carditems = "Number of items on primary card last month"
cardspent = "Amount spent on primary card last month"
card2items = "Number of items on secondary card last month"
card2spent = "Amount spent on secondary card last month"
active = "Active lifestyle"
bfast = "Preferred breakfast"
tenure = "Number of months with service"
churn = "Switched providers within last month"
longmon = "Long distance last month"
lnlongmon = "Log-long distance last month"
longten = "Long distance over tenure"
lnlongten = "Log-long distance over tenure"
tollfree = "Toll free service"
tollmon = "Toll-free last month"
lntollmon = "Log-toll free last month"
tollten = "Toll-free over tenure"
lntollten = "Log-toll free over tenure"
equip = "Equipment rental"
equipmon = "Equipment last month"
lnequipmon = "Log-equipment last month"
equipten = "Equipment over tenure"
lnequipten = "Log-equipment over tenure"
callcard = "Calling card service"
cardmon = "Calling card last month"
lncardmon = "Log-calling card last month"
cardten = "Calling card over tenure"
lncardten = "Log-calling card over tenure"
wireless = "Wireless service"
wiremon = "Wireless last month"
lnwiremon = "Log-wireless last month"
wireten = "Wireless over tenure"
lnwireten = "Log-wireless over tenure"
multline = "Multiple lines"
voice = "Voice mail"
pager = "Paging service"
internet = "Internet"
callid = "Caller ID"
callwait = "Call waiting"
forward = "Call forwarding"
confer = "3-way calling"
ebill = "Electronic billing"
owntv = "Owns TV"
hourstv = "Hours spent watching TV last week"
ownvcr = "Owns VCR"
owndvd = "Owns DVD player"
owncd = "Owns stereo/CD player"
ownpda = "Owns PDA"
ownpc = "Owns computer"
ownipod = "Owns portable digital audio player"
owngame = "Owns gaming system"
ownfax = "Owns fax machine"
news = "Newspaper subscription"
response_01 = "Response to product offer 01"
response_02 = "Response to product offer 02"
response_03 = "Response to product offer 03";
run;

data linear.new_data;
set linear.reg_data;
TOTALSPENT = CARDSPENT+CARD2SPENT;
Total_fee = cardfee + card2fee;
run;

data linear.reg_data;
set linear.reg_data;
TOTALSPENT = CARDSPENT+CARD2SPENT;
Total_fee = cardfee + card2fee;
if townsize = . then townsize=3;
if longten=. then longten=642.7780768;
if cardten=. then cardten=670.2262905;
if lncreddebt=. then lncreddebt=-0.1304535;
if lnothdebt=. then lnothdebt=0.6969153;
if commutetime=. then commutetime=25.3455382;
lntotalspent = log(totalspent);
DROP CARDSPENT CARD2SPENT CARDITEMS CARD2ITEMS BIRTHMONTH cardfee card2fee; 
run;

data linear.reg_data;
set linear.reg_data;
drop lnlongmon
lnlongten
lntollmon
lntollten
lnequipmon
lnequipten
lncardmon
lncardten
lnwiremon
lnwireten;
run;

proc means data=linear.reg_data nmiss min p5 p99 max;
run;

data linear.without_outlier;
set linear.reg_data;
if age>79 then age=79;
if ed>21 then ed=21;
if employ>39 then employ=39;
if income>272.5 then income=272.5;
if lninc>5.6076369 then lninc=5.6076369;
if debtinc>29.2 then debtinc=29.2;
if creddebt>14.29792 then creddebt=14.29792;
if lncreddebt>2.6601133 then lncreddebt=2.6601133;
if othdebt>24.153048 then othdebt=24.153048;
if lnothdebt>3.1844035 then lnothdebt=3.1844035;
if spoused>20 then spoused=20;
if reside>6 then reside=6;
if pets>13 then pets=13;
if pets_cats>3 then pets_cats=3;
if pets_dogs>3 then pets_dogs=3;
if pets_birds>3 then pets_birds=3;
if pets_reptiles>2 then pets_reptiles=2;
if pets_small>3 then pets_small=3;
if pets_saltfish>2 then pets_saltfish=2;
if pets_freshfish>11 then pets_freshfish=11;
if address>48 then address=48;
if cars>6 then cars=6;
if carvalue>92.05 then carvalue=92.05;
if commutetime>40.5 then commutetime=40.5;
if longmon>65.25 then longmon=65.25;
if longten>4704.78 then longten=4704.78;
if tollmon>58.875 then tollmon=58.875;
if tollten>3983.18 then tollten=3983.18;
if equipmon>63.325 then equipmon=63.325;
if equipten>3679.83 then equipten=3679.83;
if cardmon>64.25 then cardmon=64.25;
if cardten>4030 then cardten=4030;
if wiremon>78.5 then wiremon=78.5;
if wireten>4534.4 then wireten=4534.4;
if hourstv>31 then hourstv=31;
if lntotalspent>7.4756929 then lntotalspent=7.4756929;

if age<20 then age=20;
if ed<9 then ed=9;
if income<13 then income=13;
if lninc<2.5649494 then lninc=2.5649494;
if creddebt<0.101088 then creddebt=0.101088;
if lncreddebt<-2.2916748 then lncreddebt=-2.2916748;
if othdebt<0.287353 then othdebt=0.287353;
if lnothdebt<-1.2444831 then lnothdebt=-1.2444831;
if address<1 then address=1;
if commutetime<16 then commutetime=16;
if polview<2 then polview=2;
if cardtenure<1 then cardtenure=1;
if card2tenure<1 then card2tenure=1;
if tenure<4 then tenure=4;
if longmon<2.9 then longmon=2.9;
if longten<12.575 then longten=12.575;
if hourstv<12 then hourstv=12;
if lntotalspent<4.8908753 then lntotalspent=4.8908753;
run;


proc means data=linear.without_outlier n nmiss;run;

/* DISTRIBUTION */

proc univariate data=linear.without_outlier;
var lntotalspent;
histogram;
run;

proc anova data=linear.without_outlier;
class response_01;
model lntotalspent = response_01; /* remove var*/
run;

proc anova data=linear.without_outlier;
class response_02;
model lntotalspent = response_02; /* select var*/
run;

proc anova data=linear.without_outlier;
class response_03;
model lntotalspent = response_03; /* select var*/
run;

proc anova data=linear.without_outlier;
class news;
model lntotalspent = news; /* select var*/
run;

proc anova data=linear.without_outlier;
class ownfax;
model lntotalspent = ownfax; /* select var*/
run;

proc anova data=linear.without_outlier;
class owngame;
model lntotalspent = owngame; /* select var*/
run;

proc anova data=linear.without_outlier;
class ownipod;
model lntotalspent = ownipod; /* select var*/
run;

proc anova data=linear.without_outlier;
class ownpc;
model lntotalspent = ownpc; /* select var*/
run;

proc anova data=linear.without_outlier;
class ownpda;
model lntotalspent = ownpda; /* select var*/
run;

proc anova data=linear.without_outlier;
class union;
model lntotalspent = union; /* remove var*/
run;

proc anova data=linear.without_outlier;
class owncd;
model lntotalspent = owncd; /* select var*/
run;

proc anova data=linear.without_outlier;
class owndvd;
model lntotalspent = owndvd; /* select var*/
run;

proc anova data=linear.without_outlier;
class ownvcr;
model lntotalspent = ownvcr; /* select var*/
run;

proc anova data=linear.without_outlier;
class region;
model lntotalspent = region; /* select var*/
run;

proc anova data=linear.without_outlier;
class townsize;
model lntotalspent = townsize; /* remove var*/
run;

proc anova data=linear.without_outlier;
class gender;
model lntotalspent = gender; /* select var*/
run;

proc anova data=linear.without_outlier;
class age;
model lntotalspent = age; /* select var*/
run;

proc anova data=linear.without_outlier;
class agecat;
model lntotalspent = agecat; /* select var*/
run;

proc anova data=linear.without_outlier;
class ed;
model lntotalspent = ed; /* select var*/
run;

proc anova data=linear.without_outlier;
class edcat;
model lntotalspent = edcat; /* select var*/
run;

proc anova data=linear.without_outlier;
class jobcat;
model lntotalspent = jobcat; /* select var*/
run;


proc anova data=linear.without_outlier;
class employ;
model lntotalspent = employ; /* select var*/
run;

proc anova data=linear.without_outlier;
class empcat;
model lntotalspent = empcat; /* select var*/
run;

proc anova data=linear.without_outlier;
class retire;
model lntotalspent = retire; /* select var*/
run;

proc anova data=linear.without_outlier;
class inccat;
model lntotalspent = inccat; /* select var*/
run;

proc anova data=linear.without_outlier;
class default;
model lntotalspent = default; /* remove var*/
run;

proc anova data=linear.without_outlier;
class jobsat;
model lntotalspent = jobsat; /* select var*/
run;

proc anova data=linear.without_outlier;
class marital;
model lntotalspent = marital; /* remove var*/
run;

proc anova data=linear.without_outlier;
class spousedcat;
model lntotalspent = spousedcat; /* select var*/
run;

proc anova data=linear.without_outlier;
class homeown;
model lntotalspent = homeown; /* select var*/
run;

proc anova data=linear.without_outlier;
class hometype;
model lntotalspent = hometype; /* select var*/
run;

proc anova data=linear.without_outlier;
class address;
model lntotalspent = address; /* select var*/
run;

proc anova data=linear.without_outlier;
class addresscat;
model lntotalspent = addresscat; /* select var*/
run;

proc anova data=linear.without_outlier;
class cars;
model lntotalspent = cars; /* remove var*/
run;

proc anova data=linear.without_outlier;
class carown;
model lntotalspent = carown; /* select var*/
run;

proc anova data=linear.without_outlier;
class cartype;
model lntotalspent = cartype; /* remove var*/
run;

proc anova data=linear.without_outlier;
class carvalue;
model lntotalspent = carvalue; /* select var*/
run;

proc anova data=linear.without_outlier;
class carcatvalue;
model lntotalspent = carcatvalue; /* select var*/
run;

proc anova data=linear.without_outlier;
class carbought;
model lntotalspent = carbought; /* remove var*/
run;

proc anova data=linear.without_outlier;
class carbuy;
model lntotalspent = carbuy; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commute;
model lntotalspent = commute; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commutecat;
model lntotalspent = commutecat; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commutetime;
model lntotalspent = commutetime; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commutecar;
model lntotalspent = commutecar; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commutemotorcycle;
model lntotalspent = commutemotorcycle; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commutecarpool;
model lntotalspent = commutecarpool; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commutebus;
model lntotalspent = commutebus; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commuterail;
model lntotalspent = commuterail; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commutepublic;
model lntotalspent = commutepublic; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commutebike;
model lntotalspent = commutebike; /* select var*/
run;

proc anova data=linear.without_outlier;
class commutewalk;
model lntotalspent = commutewalk; /* remove var*/
run;

proc anova data=linear.without_outlier;
class commutenonmotor;
model lntotalspent = commutenonmotor; /* remove var*/
run;

proc anova data=linear.without_outlier;
class telecommute;
model lntotalspent = telecommute; /* remove var*/
run;

proc anova data=linear.without_outlier;
class reason;
model lntotalspent = reason; /* select var*/
run;

proc anova data=linear.without_outlier;
class polview
polparty
polcontrib
;
model lntotalspent = polview
polparty
polcontrib
; /* remove var*/
run;

proc anova data=linear.without_outlier;
class vote;
model lntotalspent = vote; /* select var*/
run;

proc anova data=linear.without_outlier;
class card
cardtype
cardbenefit
cardtenure
cardtenurecat
card2
card2type
card2benefit
card2tenure
card2tenurecat
;
model lntotalspent = card
cardtype /* remove var*/
cardbenefit /* remove var*/
cardtenure
cardtenurecat
card2
card2type /* remove var*/
card2benefit /* remove var*/
card2tenure
card2tenurecat; 
run;

proc anova data=linear.without_outlier;
class active
bfast
churn
tollfree
equip
callcard
wireless;
model lntotalspent = active /* remove var*/
bfast
churn /* remove var*/
tollfree
equip
callcard /* remove var*/
wireless; 
run;

proc anova data=linear.without_outlier;
class multline
voice
pager
internet
callid
callwait
forward
confer
ebill
owntv
hourstv;
model lntotalspent = multline /*SELECT ALL VARS*/
voice
pager
internet
callid
callwait
forward
confer
ebill
owntv
hourstv; 
run;

/* Regression on whole dataset */
PROC REG DATA=linear.without_outlier;
MODEL LNTOTALSPENT = spousedcat
jobsat
employ
empcat
retire
inccat
age
agecat
ed
edcat
jobcat
owncd
owndvd
ownvcr
region
gender
news
ownfax
owngame
ownipod
ownpc
ownpda
response_02
response_03
homeown
hometype
address
addresscat
carown
cartype
carvalue
carcatvalue
reason
vote
card
cardtenure
cardtenurecat
card2tenure
card2tenurecat
voice
pager
internet
callid
callwait
forward
confer
ebill
owntv
hourstv
bfast
tollfree
equip
wireless
lninc
debtinc
lncreddebt
lnothdebt
spoused
reside
pets
pets_cats
pets_dogs
pets_birds
pets_reptiles
pets_small
pets_saltfish
pets_freshfish
tenure
longmon
longten
tollmon
tollten
equipmon
equipten
cardmon
cardten
wiremon
wireten / selection=stepwise slentry=0.1 slstay=0.1 VIF STB;
RUN;


data linear.without_outlier;
set linear.without_outlier;
if region= 1 then dummy_region1 = 1; else dummy_region1 = 0;
if region= 2 then dummy_region2 = 1; else dummy_region2 = 0;
if region= 3 then dummy_region3 = 1; else dummy_region3 = 0;
if region= 4 then dummy_region4 = 1; else dummy_region4 = 0;
if region= 5 then dummy_region5 = 1; else dummy_region5 = 0;

if internet= 0 then dummy_internet0 = 1; else dummy_internet0 = 0;
if internet= 1 then dummy_internet1 = 1; else dummy_internet1 = 0;
if internet= 2 then dummy_internet2 = 1; else dummy_internet2 = 0;
if internet= 3 then dummy_internet3 = 1; else dummy_internet3 = 0;
if internet= 4 then dummy_internet4 = 1; else dummy_internet4 = 0;

if card= 1 then dummy_card1 = 1; else dummy_card1 = 0;
if card= 2 then dummy_card2 = 1; else dummy_card2 = 0;
if card= 3 then dummy_card3 = 1; else dummy_card3 = 0;
if card= 4 then dummy_card4 = 1; else dummy_card4 = 0;
if card= 5 then dummy_card5 = 1; else dummy_card5 = 0;

if jobcat= 1 then dummy_jobcat1 = 1; else dummy_jobcat1 = 0;
if jobcat= 2 then dummy_jobcat2 = 1; else dummy_jobcat2 = 0;
if jobcat= 3 then dummy_jobcat3 = 1; else dummy_jobcat3 = 0;
if jobcat= 4 then dummy_jobcat4 = 1; else dummy_jobcat4 = 0;
if jobcat= 5 then dummy_jobcat5 = 1; else dummy_jobcat5 = 0;
if jobcat= 6 then dummy_jobcat6 = 1; else dummy_jobcat6 = 0;

if voice= 0 then dummy_voice = 1; else dummy_voice = 0;
if voice= 1 then dummy_voice_1 = 1; else dummy_voice_1 = 0;

if response_03= 0 then dummy_response_03 = 1; else dummy_response_03 = 0;
if response_03= 1 then dummy_response_03_1 = 1; else dummy_response_03_1 = 0;

if gender = 0 then dummy_gender = 1; else dummy_gender = 0;
if gender = 1 then dummy_gender1 = 1; else dummy_gender1 = 0;
run;

/* SPLITTING DATA */
proc surveyselect data=linear.without_outlier out=linear.regression outall samprate=0.7 seed=1803;
run;

data linear.dev linear.val;
set linear.regression;
if selected = 1 then output linear.dev;
else output linear.val;
run; 

/* REGRESSION ANALYSYS */
proc reg data=linear.dev OUTEST=linear.MODEL;
model lntotalspent =
age
lninc
lncreddebt
longmon
dummy_region1
dummy_region2
dummy_region3
dummy_region4
dummy_region5
dummy_jobcat1
dummy_jobcat2
dummy_jobcat3
dummy_jobcat4
dummy_jobcat5
dummy_jobcat6
dummy_internet0
dummy_internet1
dummy_internet2
dummy_internet3
dummy_internet4
dummy_card1
dummy_card2
dummy_card3
dummy_card4
dummy_card5
dummy_response_03
dummy_response_03_1
dummy_gender
dummy_gender1
dummy_voice
dummy_voice_1 / selection = stepwise slentry=0.1 slstay=0.1 vif stb;
output out=linear.dev1 predicted=newpred cookd=cd;
run;
                         
data linear.dev1; 
set linear.dev1; 
if cd< (4/3500);  /* (2*dpvars+2/no. of obs)*/
run;

/* EXECUTE AFTER REMOVING COOKS D */
proc reg data=linear.dev1 OUTEST=linear.MODEL;
model  lntotalspent =
age
lninc
lncreddebt
longmon
dummy_region1
dummy_region2
dummy_region3
dummy_region4
dummy_region5
dummy_jobcat1
dummy_jobcat2
dummy_jobcat3
dummy_jobcat4
dummy_jobcat5
dummy_jobcat6
dummy_internet0
dummy_internet1
dummy_internet2
dummy_internet3
dummy_internet4
dummy_card1
dummy_card2
dummy_card3
dummy_card4
dummy_card5
dummy_response_03
dummy_response_03_1
dummy_gender
dummy_gender1/  selection = stepwise slentry=0.1 slstay=0.1 vif stb;
output out=linear.dev2 predicted=newpred1 cookd=cd2;
run;

data linear.dev2; 
set linear.dev2; 
if cd2< (4/3350);  
run;

/* EXECUTE AFTER REMOVING COOKS D */
proc reg data=linear.dev2 OUTEST=linear.MODEL;
model  lntotalspent =
age
lninc
lncreddebt
longmon
dummy_region1
dummy_region2
dummy_region3
dummy_region4
dummy_region5
dummy_jobcat1
dummy_jobcat2
dummy_jobcat3
dummy_jobcat4
dummy_jobcat5
dummy_jobcat6
dummy_internet0
dummy_internet1
dummy_internet2
dummy_internet3
dummy_internet4
dummy_card1
dummy_card2
dummy_card3
dummy_card4
dummy_card5
dummy_response_03
dummy_response_03_1
dummy_gender
dummy_gender1/  selection = stepwise slentry=0.1 slstay=0.1 vif stb;
output out=linear.dev3 predicted=newpred2 cookd=cd3;
run;

data linear.dev3; 
set linear.dev3; 
if cd3< (4/3251);  
run;

/* EXECUTE AFTER REMOVING COOKS D */
proc reg data=linear.dev3 OUTEST=linear.MODEL;
model  lntotalspent =
age
lninc
lncreddebt
longmon
dummy_region1
dummy_region2
dummy_region3
dummy_region4
dummy_region5
dummy_jobcat1
dummy_jobcat2
dummy_jobcat3
dummy_jobcat4
dummy_jobcat5
dummy_jobcat6
dummy_internet0
dummy_internet1
dummy_internet2
dummy_internet3
dummy_internet4
dummy_card1
dummy_card2
dummy_card3
dummy_card4
dummy_card5
dummy_response_03
dummy_response_03_1
dummy_gender
dummy_gender1/  selection = stepwise slentry=0.1 slstay=0.1 vif stb;
output out=linear.dev4 predicted=newpred3 cookd=cd4;
run;

data linear.dev4; 
set linear.dev4; 
if cd4< (4/3191);  
run;

/* EXECUTE AFTER REMOVING COOKS D */
proc reg data=linear.dev4 OUTEST=linear.MODEL;
model  lntotalspent =
age
lninc
lncreddebt
longmon
dummy_region1
dummy_region2
dummy_region3
dummy_region4
dummy_region5
dummy_jobcat1
dummy_jobcat2
dummy_jobcat3
dummy_jobcat4
dummy_jobcat5
dummy_jobcat6
dummy_internet0
dummy_internet1
dummy_internet2
dummy_internet3
dummy_internet4
dummy_card1
dummy_card2
dummy_card3
dummy_card4
dummy_card5
dummy_response_03
dummy_response_03_1
dummy_gender
dummy_gender1/  selection = stepwise slentry=0.1 slstay=0.1 vif stb;
output out=linear.dev5 predicted=newpred4 cookd=cd5;
run;

data linear.dev5; 
set linear.dev5; 
if cd5< (4/3172);  
run;

/* EXECUTE AFTER REMOVING COOKS D */
proc reg data=linear.dev5 OUTEST=linear.MODEL;
model  lntotalspent =
age
lninc
lncreddebt
longmon
dummy_region1
dummy_region2
dummy_region3
dummy_region4
dummy_region5
dummy_jobcat1
dummy_jobcat2
dummy_jobcat3
dummy_jobcat4
dummy_jobcat5
dummy_jobcat6
dummy_internet0
dummy_internet1
dummy_internet2
dummy_internet3
dummy_internet4
dummy_card1
dummy_card2
dummy_card3
dummy_card4
dummy_card5
dummy_response_03
dummy_response_03_1
dummy_gender
dummy_gender1/  selection = stepwise slentry=0.1 slstay=0.1 vif stb;
output out=linear.dev6 predicted=newpred5 cookd=cd6;
run;

data linear.dev6; 
set linear.dev6; 
if cd6< (4/3163);  
run;

/* EXECUTE AFTER REMOVING COOKS D */
proc reg data=linear.dev6 OUTEST=linear.MODEL;
model  lntotalspent =
age
lninc
lncreddebt
longmon
dummy_region1
dummy_region2
dummy_region3
dummy_region4
dummy_region5
dummy_jobcat1
dummy_jobcat2
dummy_jobcat3
dummy_jobcat4
dummy_jobcat5
dummy_jobcat6
dummy_internet0
dummy_internet1
dummy_internet2
dummy_internet3
dummy_internet4
dummy_card1
dummy_card2
dummy_card3
dummy_card4
dummy_card5
dummy_response_03
dummy_response_03_1
dummy_gender
dummy_gender1/  selection = stepwise slentry=0.1 slstay=0.1 vif stb;
output out=linear.dev7 predicted=newpred6 cookd=cd7;
run;

data linear.dev7; 
set linear.dev7; 
if cd7< (4/3132);  
run;

/* EXECUTE AFTER REMOVING COOKS D */
proc reg data=linear.dev7 OUTEST=linear.MODEL;
model  lntotalspent =
age
lninc
lncreddebt
longmon
dummy_region1
dummy_region2
dummy_region3
dummy_region4
dummy_region5
dummy_jobcat1
dummy_jobcat2
dummy_jobcat3
dummy_jobcat4
dummy_jobcat5
dummy_jobcat6
dummy_internet0
dummy_internet1
dummy_internet2
dummy_internet3
dummy_internet4
dummy_card1
dummy_card2
dummy_card3
dummy_card4
dummy_card5
dummy_response_03
dummy_response_03_1
dummy_gender
dummy_gender1/  selection = stepwise slentry=0.1 slstay=0.1 vif stb;
output out=linear.dev8 predicted=newpred7 cookd=cd8;
run;

data linear.dev8; 
set linear.dev8; 
if cd8< (4/3127);  
run;

/* FINAL COOKS D EXECUTION */

proc reg data=linear.dev8 OUTEST=linear.MODEL;
model  lntotalspent =
age
lninc
lncreddebt
longmon
dummy_region1
dummy_region2
dummy_region3
dummy_region4
dummy_region5
dummy_jobcat1
dummy_jobcat2
dummy_jobcat3
dummy_jobcat4
dummy_jobcat5
dummy_jobcat6
dummy_internet0
dummy_internet1
dummy_internet2
dummy_internet3
dummy_internet4
dummy_card1
dummy_card2
dummy_card3
dummy_card4
dummy_card5
dummy_response_03
dummy_response_03_1
dummy_gender
dummy_gender1/  selection = stepwise slentry=0.1 slstay=0.1 vif stb;
output out=linear.dev9 predicted=newpred8 cookd=cd9;
run;

data linear.dev9; 
set linear.dev9; 
if cd7< (4/3126);  
run;

data linear.develop;
set linear.dev9;
pre_totalspent = exp(newpred8);
run;


proc sort data=linear.develop;
by descending pre_totalspent;
run;

/* Decile Analysis*/
proc rank data=linear.develop out=linear.dev_rank ties=low descending groups=10; 
var pre_totalspent;
ranks decile;
run;

proc sql;
/* create table decile as */
select decile, mean(pre_totalspent) as avg_pre_totalspent, mean(totalspent) as avg_act_totalspent,
sum(pre_totalspent) as sum_pre_totalspent, sum(totalspent) as tot_act_totalspent from linear.dev_rank
group by decile;
quit;

/* VALIDATION */

proc score data=linear.val score=linear.model out=linear.val1 type=parms;
var 
age
lninc
lncreddebt
dummy_region4
dummy_internet2
dummy_card1
dummy_card4
dummy_response_03_1
dummy_gender;
run;

data linear.val1;
set linear.val1;
val_pre_totalspent = exp(model1);
run;

proc sort data=linear.val1;
by descending val_pre_totalspent;
run;

proc rank data=linear.val1 out=linear.val_rank ties=low descending groups=10;
var val_pre_totalspent;
ranks decile;
run;

/* DECILING */

proc sql;
select decile, mean(val_pre_totalspent) as avg_pre_totalspent, mean(totalspent) as avg_act_totalspent,
sum(val_pre_totalspent) as sum_pre_totalspent, sum(totalspent) as tot_act_totalspent from
linear.val_rank group by decile;
quit;