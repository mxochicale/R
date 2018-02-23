data.table examples
---

# data.table: Extension of 'data.frame'
Fast aggregation of large data (e.g. 100GB in RAM), fast ordered joins, 
fast add/modify/delete of columns by group using no copies at all, 
list columns, a fast friendly file reader and parallel file writer. 
Offers a natural and flexible syntax, for faster development [:link:](https://cran.r-project.org/web/packages/data.table/).

## Introdution to datatable:

* `intro_datatable00.R`  
Advanced tutorial on the use of data.table

* `intro_datatable01.R`  
Using shift for  to lead/lag vectors and lists

* `intro_datatable02.R`  

You need to download the following data to run this script
```
wget https://raw.githubusercontent.com/wiki/arunsrinivasan/flights/NYCflights14/flights14.csv
```

* `intro_datatable03.R`
You need to download the following data to run this script
```
wget https://dl.dropboxusercontent.com/u/83643/AirlineSubset1pct.csv.gz
gunzip AirlineSubset1pct.csv.gz
```



## Shift -- Fast Lead/Lag for Vectors  and Lists

Examples:
* `shift_data00.R`
* `shift_data01.R`
* `shift_data02.R`





## TODO

* [ ] Define data path e.g.
```
setwd("../")
main_path <- getwd()
r_scripts_path <- paste(main_path,"/r-scripts/",sep="")

main_data_directory <- "/outcomes/..."

data_path <-  paste(main_path,main_data_directory,sep="")
outcomes_path <- paste(main_path,"/outcomes",sep="")
feature_path <- "xxxxxxxxxxxxxx"

```
