#!/bin/sh
PROJECT_NAME=$1
shift
MAKE_MODULES=$@
echo Creating project \"$PROJECT_NAME\" with modules \"$MAKE_MODULES\"
test -e $PROJECT_NAME && echo Project already exists, exiting. && exit 1  || mkdir $PROJECT_NAME
cd $PROJECT_NAME
git init
printf "\
# Project level variables\n\
PROJECT_NAME         = $PROJECT_NAME\n\
PROJECT_DESCRIPTION  = \n\
\n\
# Tools\n\
GIT                  = git\n\
\n\
# Vendoring\n\
ifneq (\"\$(wildcard .vendor)\",\"\")\n\
include .vendor/make/prelude.mk\n\
include .vendor/make/help.mk\n\
`echo $MAKE_MODULES | tr " " "\n" | xargs -n1 -I % printf "include .vendor/make/%.mk\n"`\n\
endif\n\
\n\
.PHONY : all check deploy clean vendor\n\
\n\
##all    - Build everything\n\
all:\n\
\n\
##clean  - Clean up project\n\
clean:\n\
\n\
##vendor - Vendor makefiles\n\
vendor:\n\
	@echo Vendoring Makefiles\n\
	@rm -rf .vendor\n\
	@\$(GIT) clone https://github.com/richardanaya/makefiles.git .vendor/make\n\
" > Makefile
make vendor
make `echo $MAKE_MODULES | tr " " "\n" | xargs -n1 -I % printf "%__setup "`