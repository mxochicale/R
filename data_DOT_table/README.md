data.table Source Repository
======================


### intro_datatable00.R
Advanced tutorial on the use of data.table


### intro_datatable01.R
Using shift for  to lead/lag vectors and lists

### intro_datatable02.R

You need to download the following data to run this script
```
wget https://raw.githubusercontent.com/wiki/arunsrinivasan/flights/NYCflights14/flights14.csv
```

### intro_datatable03.R

You need to download the following data to run this script
```
wget https://dl.dropboxusercontent.com/u/83643/AirlineSubset1pct.csv.gz
gunzip AirlineSubset1pct.csv.gz
```



# TODO
Define data path e.g.

```
setwd("../")
main_path <- getwd()
r_scripts_path <- paste(main_path,"/r-scripts/",sep="")

main_data_directory <- "/outcomes/..."

data_path <-  paste(main_path,main_data_directory,sep="")
outcomes_path <- paste(main_path,"/outcomes",sep="")
feature_path <- "xxxxxxxxxxxxxx"

```
