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
**1. Change directory to 'sim'**

This is from where all jobs will be launched.
```
cd ./sim
```

**2. Project Setup**

Only needs to be done once, or when libraries must be updated. This will pull in dependencies from the web.
```
./setup_project.py
```

**3. Terminal Setup**

This must be done per terminal. The script included in this project is for bash:

```
export VIVADO=/path/to/vivado/bin # Set locaton of Vivado installation
source ./setup_terminal.sh
```

**4. Launch**

All jobs for simulation are performed via `mio`.

> At any time, you can invoke its built-in documentation:

```
mio --help
```

> To run test 'traffic' with seed '1' and wave capture enabled:


```
clear && mio all uvmt_logs_st -t traffic -s 1
```
