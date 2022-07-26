#! /bin/bash
########################################################################################################################
## Copyright 2021-2022 Datum Technology Corporation
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# Launched from uvml_logs project sim dir
mio sim     uvmt_logs_st -CE
mio sim     uvmt_logs_st -S -t traffic -s 1 -c
mio sim     uvmt_logs_st -S -t reg     -s 1 -c
mio sim     uvmt_logs_st -S -t rs      -s 1 -c
mio results uvmt_logs_st results
mio cov     uvmt_logs_st
