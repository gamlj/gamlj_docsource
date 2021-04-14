  library(rmarkdown)
  source("R/constants.R")
  source("R/functions.R")
  HERE<-getwd()
  copy_vignettes()
  msg<-"updates"
  render_site("docssource/",output_format = "html_document")
  system("git add .")
  system(paste('git commit -m "',msg,'"'))
  system("git push origin master")
  
  ### the following is needed for organization pages
  source("R/constants.R")
  cmd<-paste("cp -R ",paste0(SOURCE_FOLDER,"/*"),paste0(TARGET_FOLDER,"/"))
  system(cmd)
  setwd(TARGET_FOLDER)
  system("git add .")
  system(paste('git commit -m "',msg,'"'))
  system("git push origin master")
  setwd(HERE)
  
  pkg<-"gamlj"
  db<-tools:::fetchRdDB(file.path(find.package(pkg), 
                              'help', pkg))
pp$gamljGlm
pp[["beers_bars"]]
tools::findHTMLlinks(file.path(find.package(pkg)))
for (rdname in names(db))  { 
       rd<-db[[rdname]]
       alist<-unlist(sapply(rd,function(a) if (attr(a,"Rd_tag")=="\\keyword") a))
       if (is.null(alist) | !("datasets" %in% alist))
               tools::Rd2HTML(rd,out=paste0("docssource/rhelp/",rdname,".html"),)
}
