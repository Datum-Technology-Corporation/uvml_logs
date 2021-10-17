# About
## [Home Page](https://datum-technology-corporation.github.io/uvml_logs/)
The Moore.io UVM Logging Library is a crucial component to any modern digital design simulation.  This project consists the library itself (`uvml_logs_pkg`), the self-test UVM environment (`uvme_logs_st`) and the self-test UVM Test bench (`uvmt_logs_st`).

## IP
* DV
> * uvml_logs
> * uvme_logs_st
> * uvmt_logs_st
* RTL
* Tools


# Simulation
```
cd ./sim
cat ./README.md
./setup_project.py
source ./setup_terminal.sh
export VIVADO=/path/to/vivado/install
dvm --help
clear && dvm all uvmt_logs_st -t traffic -s 1
```
