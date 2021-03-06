# Makefiles

This project is a tome of useful makefiles to help get many different types of projects started quickly with the power of `make`.

If you aren't experienced in `make` I recommend starting here: http://swcarpentry.github.io/make-novice/

The basic idea is you import in makefiles modules to help save time and get operational quickly. Each makefile module will have variables that will change its behavior and can be overridden before importing.

## Hello World

```console
richard:~$ git clone https://github.com/richardanaya/makefiles.git .vendor/make
richard:~$ vim Makefile
```

```makefile
PROJECT_NAME        = hello-world
PROJECT_DESCRIPTION = A simple project that says hello world

include .vendor/make/prelude.mk
include .vendor/make/help.mk

.PHONY : hello

##hello - Say hello
hello  :
	@echo Hello World!
```

```console
richard:~$ make
hello-world
A simple project that says hello world

help - Show commands for this makefile
hello - Say hello

richard:~$ make hello
Hello World!
```

## Quickstart

```
curl -L https://rawgit.com/richardanaya/makefiles/master/make_project.sh | sh -s app app_rust
```

```
curl -L https://rawgit.com/richardanaya/makefiles/master/make_project.s | sh -s lambda_app lambda_rust terraform
```
