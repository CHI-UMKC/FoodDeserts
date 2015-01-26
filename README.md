Food Deserts
============

[USDA Food Access Data](http://www.ers.usda.gov/data-products/food-access-research-atlas/download-the-data.aspx) by census tract.

## Download

Script **0-USDA-Food-Access-Data-Download.R** downloads the raw data from the site above:

* Food-Access-Research-Atlas-Archived.pdf
* Food-Access-Research-Atlas-Archived.xls
* Food-Access-Research-Atlas-Current.pdf
* Food-Access-Research-Atlas-Current.xlsx

These data files are not stored as part of this repository.

The "Current" files are of the most interest, but the "Archived" versions are saved for comparisons.

## FirstLook

Script **1-USDA-Food-Access-FirstLook.R** extracts data from two of the worksheets from the file Food-Access-Research-Atlas-Current.xlsx and writes .csv files for use in other programs:

* sheet3: Food-Access-Research-Atlas-Current.csv (raw data)
* sheet1: Food-Access-Research-Atlas-Current-Fields.csv (metadata)

The metadata file was edited in an Excel file (Food-Access-Research-Atlas-Current-Fields.xlsx) to have a "Check" column with values Binary, Boxplot, or Table and used in the later run of the script to identify what preliminary analysis to perform.

Frequency counts were made for binary (0/1) fields and those tagged "table".  Output can be seen in the file **1-USDA-Food-Access-FirstLook.txt**.

[Five Number](http://en.wikipedia.org/wiki/Five-number_summary) summaries are shown in the file above for variables marked "boxplot" as well as separate graphics in file **1-USDA-Food-Access-FirstLook.pdf**. The boxplots show many of the variables are skewed.

## MySQL Load

The script **FoodDeserts-Create-Load.SQL** loads the raw data file created above in a MySQL database.  The **.bat** shows calling MySQL from the command line.



