#!/usr/bin/env bash

export R_COMPILE_PKGS=TRUE
export R_ENABLE_JIT=3

Rscript ./mandelRnaive.R
