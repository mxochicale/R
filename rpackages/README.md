R package example
---

This example is based on
[H. Parker Tutorial](https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/).


# 1 Install Required packages

```
R
install.packages("devtools", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
devtools::install_github("klutometis/roxygen", repos='https://www.stats.bris.ac.uk/R/', dependencies = TRUE)
```

# 2. Create paths,  file function and package paths


```
R
library(roxygen2); library("devtools")
setwd(getwd())
create('catpackage')
```

add "cat_function.R" to ~/R/

```
#' A Cat Function
#'
#' This function allows you to express your love of cats.
#' @param love Do you love cats? Defaults to TRUE.
#' @keywords cats
#' @export
#' @examples
#' cat_function()

cat_function <- function(love=TRUE){
    if(love==TRUE){
        print("I love cats!")
    }
    else {
        print("I am not a cool person.")
    }
}
```

# 3. Process the documentation

```
setwd('./catpackage')
document()
```

# 4. Install


```
setwd('..')
install('catpackage')
```


# 5. USAGE


```
setwd('..') #parent path of the package
library(roxygen2); library("devtools")
install('catpackage')
library('catpackage')
```




# 6. Github?TESTING

```
install_github("mxochicale/r-code_repository", subdir=c('rpackage','catpackage'))
```
