### mixed 1 ###
dat<-read.csv2("data/beers_bars.csv")
dat$smile<-as.numeric(as.character(dat$smile))
dat$beer<-as.numeric(as.character(dat$beer))
dat$beer<-as.numeric(scale(dat$beer,scale = F))
library(lmerTest)
model<-lmer(smile~beer+(1|bar),data=dat,REML = F)
summary(model)
model<-lmer(smile~beer+(1+beer|bar),data=dat)
summary(model)

anova(model, type=2, ddf="Kenward-Roger")

ranova(model)

sxs<-read.csv("data/subjects_by_stimuli.csv")
#sxs<-sxs[sxs$nest_stimulus %in% c(1,31,2,32) & sxs$subj %in% c(1,2,3),]
sxs2<-sxs
sxs2$nest_stimulus<-sxs2$nest_stimulus+60

sxs2$stimulus<-sxs2$stimulus+30
sxs2<-rbind(sxs,sxs2)

sxs2$cond<-factor(sxs2$cond)
sxs2$subj<-factor(sxs2$subj)
sxs2$stimulus<-factor(sxs2$stimulus)

sxs$cond<-factor(sxs$cond)
sxs$subj<-factor(sxs$subj)
sxs$stimulus<-factor(sxs$stimulus)
sxs$nest_stimulus<-factor(sxs$nest_stimulus)
library(lmerTest)
mod0<-lmer(y~(1+cond|subj)+(1|stimulus)+cond,data=sxs2)
summary(mod0)
table(sxs2$stimulus)
table(sxs$stimulus)
table(sxs2$cond)
table(sxs$cond,)

mod1<-lmer(y~(1+cond|subj)+(1|stimulus)+cond,data=sxs)
summary(mod1)

mod2<-lmer(y~(1+cond|subj)+(1|nest_stimulus)+cond,data=sxs)
summary(mod2)
mod2<-lmer(y~(1+cond|subj)+(1|nest_stimulus)+cond,data=sxs2)
summary(mod2)




sigma(mod1)*diag(mod1@pp$unsc())*10


mod1@vcov_varpar

mm<-model.matrix(mod0)
head(mm)
mod0@vcov_varpar
Z<-getME(mod0,"Z")
Zt<-getME(mod0,"Zt")
as.matrix(Zt%*%Z)


Z<-getME(mod1,"Z")
Zt<-getME(mod1,"Zt")
v<-Zt%*%Z
v<-as.matrix(v)
v
library(MASS)
v


r<-5
s<-10
b<-rnorm(s,0,10)
cond<-rep(c(0,1),s*r)
cond2<-rep(c(0,1),each=s*r/2)

data<-data.frame()
j<-0
for (i in 1:s) {
  rowz<-(j+1):(j+r)
  j<-max(rowz)
  x<-cond[rowz]
  x2<-cond2[rowz]
  y<-b[i]+x+rnorm(r,0,1)
  one<-cbind(i,y,x,x2)
  data<-rbind(data,one)
}
data$x<-factor(data$x)
data$x2<-factor(data$x2)
data$i<-factor(data$i)
table(data$x2)
lmer(y~1+(1|i)+x,data=data)
lmer(y~1+(1|i)+x2,data=data)
