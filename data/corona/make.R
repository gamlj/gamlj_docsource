folder<-"/home/marcello/Skinner/Stat/data/COVID-19/csse_covid_19_data/csse_covid_19_daily_reports/"
ff<-list.files(folder)
ff<-ff[grep("20",ff,fixed = T)]
data<-read.csv(paste0(folder,ff[1]))
nn<-names(data)

data$Date<-"ok"
data$Day<-0
data<-data[0,]

d<-0
f<-"ok"
for (f in ff) {
   d<-d+1
   data0<-read.csv(paste0(folder,f))
   data0<-data0[,nn]
   date<-gsub(".csv","",f,fixed = T)
   data0$Date<-date
   data0$Day<-d
   data<-rbind(data,data0)
}

data$Confirmed<-ifelse(is.na(data$Confirmed),0,data$Confirmed)
data$Deaths<-ifelse(is.na(data$Deaths),0,data$Deaths)
data$Recovered<-ifelse(is.na(data$Recovered),0,data$Recovered)

head(data)
data<-data[data$Confirmed>0,]
tdata<-aggregate(data$Confirmed,list(data$Country),sum)

adata<-aggregate(data$Confirmed,list(data$Country,data$Day),sum)
names(adata)<-c("Country","Day","Confirmed")
library(gamlj)
form<-Confirmed ~ Day + I(Day^2) + I(Day^3)+I(Day^4)
tt<-tapply(data$Confirmed,data$Country.Region,sum)
u1000<-names(which(tt>1000))

for (u in u1000) {
ddata1<-adata[adata$Country==u,]
mod<-gamlj::gamljGzlm(
  scaling = list(list(var="Day",type="none")),
  formula = form,
  data = ddata1,
  plotHAxis = Day,
  plotRaw = TRUE,
  modelSelection = "custom",
  custom_family = "Gamma",
  custom_link = "log")
cat(u)
r2<-as.numeric(as.character(mod$info$asDF[5,2]))
sprintf("## %s",u)
sprintf("R^2=%0.3f",r2)
print(mod$descPlot)
}

mod$main$fixed$asDF
names(mod$main$fixed)
str(mod$main$fixed)
snames<-sapply(f$columns,function(a) a$title)
tab<-mod$main$fixed$asDF
tab<-txtRound(tab,digits=3)
tnames<-unlist(lapply(names(tab) ,function(n) snames[[n]]))
names(tab)<-tnames
htmlTable(tab)

jtable<-function(jobject,digits=3) {
  snames<-sapply(jobject$columns,function(a) a$title)
  asDf<-jobject$asDF
  tnames<-unlist(lapply(names(asDF) ,function(n) snames[[n]]))
  tab<-htmlTable::txtRound(asDF,digits=digits)
  names(tab)<-tnames
  htmlTable::htmlTable(tab)
}
jobject<-mod$main$fixed

print(jtable(jobject))
library(kableExtra)
kable(asDF,digits = 3,row.names = F,)

str(jobject)
jobject$saveAs(file = "q",format = "text")  

library(jmv)
y<-rnorm(10)
x<-factor(rep(c(0,1)))
data<-data.frame(y,x)
mytable<-jmv::ttestIS(data = data,vars = "y",group = "x")

mytable$ttest
