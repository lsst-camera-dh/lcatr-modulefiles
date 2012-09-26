#!/bin/bash

# a dummy job harness to provide dummy values of expected env. vars.
# usage: dummy_jh.sh <some other commmand and args>


export CCDTEST_ROOT=/path/to/ccdtest_root
export CCDTEST_CCD_ID=00000
export CCDTEST_JOB_ID=00000
export CCDTEST_SITE=TESTSITE


echo "cmd: $@"

$@
