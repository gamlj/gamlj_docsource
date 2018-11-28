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
sxs<-sxs[sxs$nest_stimulus %in% c(1,31,2,32) & sxs$subj %in% c(1,2,3),]
head(sxs)
sxs$cond<-factor(sxs$cond)
sxs$subj<-factor(sxs$subj)
sxs$stimulus<-factor(sxs$stimulus)
sxs$nest_stimulus<-factor(sxs$nest_stimulus)
library(lmerTest)
mod1<-lmer(y~(1|subj)+(1|stimulus)+cond,data=sxs)
summary(mod1)
mod2<-lmer(y~(1|subj)+(1|nest_stimulus)+cond,data=sxs)
summary(mod2)

vcov(mod2)
vcov(mod1)

mod1@vcov_varpar

mm<-model.matrix(mod1)
head(mm)
mod1@vcov_varpar
Z<-getME(mod1,"Z")
Zt<-getME(mod1,"Zt")
as.matrix(Zt%*%Z)
  getME()
Z<-getME(mod2,"Z")
Zt<-getME(mod2,"Zt")
v<-Zt%*%Z
v<-as.matrix(v)
library(MASS)
v

