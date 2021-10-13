#!/bin/sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(cd ../../libgit2/build; pwd)
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$(cd ../../libgit2/build; pwd)
./playground
