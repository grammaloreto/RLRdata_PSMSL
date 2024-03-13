
[RLR data](https://psmsl.org/data/obtaining/rlr.php) refers to **Tide Gauge (TG)** data that has been standardized to a common datum, the Revised Local Reference. This standardization is vital for comparing relative sea level changes across different locations around the globe. 

For the TG station worked in this repo (Marseille - France):
Add 6.840m to data values 1885-1996 to refer to RLR
Add 6.510m to data values 1998 onwards to refer to RLR
RLR is 8.500m below primary benchmark M.AC-0-VIII

The programs for statistical, trend, and seasonal analysis of Relative Sea Level (RLR) data in Fortran are designed to extract meaningful insights from tide gauge measurements. The statistical analysis program calculates basic statistics, such as the mean, variance, and standard deviation, helping to understand the central tendency and dispersion of the sea level data. The trend analysis program applies linear regression to determine whether there is a significant long-term increase or decrease in sea levels, quantifying changes per year and providing a clearer picture of climate impact on ocean dynamics. Lastly, the seasonal analysis program evaluates monthly averages over multiple years to identify recurring patterns, revealing how sea levels fluctuate with seasons. 

There is also basic code to just read the file, change the date format (decimal to YYYY-MM-DD) and save them in databases (CSV). A python version to change the date format and save the rlrdata in csv is also present.








