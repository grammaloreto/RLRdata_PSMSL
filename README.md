
[RLR data](https://psmsl.org/data/obtaining/rlr.php) refers to **Tide Gauge (TG)** data that has been standardized to a common datum, the Revised Local Reference. This standardization is vital for comparing relative sea level changes across different locations around the globe. 

For the TG station worked in this repo (Marseille - France):
Add 6.840m to data values 1885-1996 to refer to RLR
Add 6.510m to data values 1998 onwards to refer to RLR
RLR is 8.500m below primary benchmark M.AC-0-VIII

In this repository, the rlrdata files are downloaded directly from the [PSMSL](https://psmsl.org/data/obtaining/) to read them, change the date format (decimal to YYYY-MM-DD) and save them in databases (CSV). The process is done in FORTRAN and Python.








