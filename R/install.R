library(rmarkdown)
HERE<-getwd()
msg<-"updates"
render_site("docssource/")
system("git add .")
system(paste('git commit -m "',msg,'"'))
system("git push origin master")

cmd<-paste("cp -R ",paste0(SOURCE_FOLDER,"/*"),paste0(TARGET_FOLDER,"/"))
system(cmd)
setwd(TARGET_FOLDER)
system("git add .")
system(paste('git commit -m "',msg,'"'))
system("git push origin master")
setwd(HERE)



