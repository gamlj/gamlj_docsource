# folders should be absolute or relative to the docssource folder
# do not use the trailing slash
MODULE_FOLDER="/home/marcello/Skinner/Forge/jamovi/gamlj"
SOURCE_FOLDER="pubs"
TARGET_FOLDER="../gamlj.github.io"
DATALINK<-"https://raw.githubusercontent.com/mcfanda/gamlj_docs/master/data"

# These handle the release notes from commits
MODULE_REPO="gamlj"
MODULE_REPO_OWNER="gamlj"
FIRST_VERSION="version.1.5.0"
BANNED_COMMITS=list("initialize","fix commits","remove some marks","typo in random table #73","1.5.0")
BANNED_COMMITS_GREP=list("^#","^!","^Merge branch","spelling")

# These handle the R vignettes

VIGNETTES_FOLDER="/home/marcello/Skinner/Forge/jamovi/gamlj/vignettes/"
