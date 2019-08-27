Sys.setenv(RSTUDIO_PANDOC="C:/Program Files/Pandoc")
library(pkgdown)
pkgdown::clean_site()
pkgdown::build_site()
