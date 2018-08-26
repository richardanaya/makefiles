MAKEFLAGS += --warn-undefined-variables
SHELL := sh
.DEFAULT_GOAL := all
.DELETE_ON_ERROR:
.SUFFIXES:

PROJECT_OUTPUT_DIR  ?= dist
PROJECT_SOURCES_DIR ?= src

log = echo $(1) - $(2)