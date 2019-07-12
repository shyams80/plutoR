library(desc)

desc <- description$new("../DESCRIPTION")
install.packages(sprintf('../../plutoR_%s.zip', desc$get_field('Version')), repos = NULL)
