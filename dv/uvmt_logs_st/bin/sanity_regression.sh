#! /bin/bash
########################################################################################################################
## Copyright 2021-2022 Datum Technology Corporation
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# Launched from uvml project sim dir
shopt -s expand_aliases
source ~/.bashrc
mio cpel    uvmt_logs_st
mio sim     uvmt_logs_st -t traffic -s 1 -c
mio sim     uvmt_logs_st -t reg     -s 1 -c
mio sim     uvmt_logs_st -t rs      -s 1 -c
mio results uvmt_logs_st results
mio cov     uvmt_logs_st
