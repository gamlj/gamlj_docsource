library(rmarkdown)
msg<-"spelling"
render_site("docssource/")
system("git add .")
system(paste('git commit -m "',msg,'"'))
system("git push origin master")
