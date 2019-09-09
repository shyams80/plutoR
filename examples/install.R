library(desc)
library(devtools)

if(require('plutoR', character.only = T)) remove.packages('plutoR')
build('../../plutoR')

desc <- description$new("../DESCRIPTION")
install.packages(sprintf('../../plutoR_%s.tar.gz', desc$get_field('Version')), repos = NULL)
