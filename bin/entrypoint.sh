#!/bin/bash
#this doesn't really work since eworm spins up other processes which end up zombies. 
set -e
export EW_LOG=/eworm/run/log/
export EW_PARAMS=/eworm/run/params/
export EW_INSTALLATION=INST_UNKNOWN
exec $@
