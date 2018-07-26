# Making a basic R package

Heavily influenced by Hilary Parker's excellent tutorial
at https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/.

```r
library(devtools)
library(roxygen2)

package_name <- "test"
setwd("~/repos")
create(package_name)
```

# Next steps

 * edit $package_name/DESCRIPTION file. Also need to list package dependencies under Imports.
 * add R code to files in $package_name/R. Perhaps one function per file?
 * put documentation before each function

# Dependencies example

```
Imports:
    data.table (>= 1.9.4),
    dplyr
```

# Documentation

```r
#' Name/Title
#'
#' Description
#' @param name description
#' @keywords x y z
#' @export
#' @examples
#' func_name()
 
func_name <- function() {
    return(NULL)
}
```

# Process

```r
setwd(paste0('~/repos/', package_name, sep=""))
document()
```

# Upload to github

# Install

Can install with devtools::install_github("user/package")
