################################################
# combine vectors of unequal length 
# Nov 15, 2017
################################################

# Take vectors of unequal length but mostly similar columns and combine them into a table
# used for Parkinson's Project to show changes in coefficients between crude and adjusted models

# Note that the column names of the first vector
# are taken as column names of the developing data frame. 

l <- myList
do.call(rbind, lapply(lapply(l, unlist), "[",
                      unique(unlist(c(sapply(l,names))))))
# How it works:

# a list of names from each list element
c(sapply(l,names))

# unlist them and find unique names
unique(unlist(c(sapply(l,names))))

# gives unlisted vectors with column names for each list element
lapply(l, unlist) 

# can read to table and pander
myTable <- do.call(rbind, lapply(lapply(l, unlist), "[",
                      unique(unlist(c(sapply(l,names))))))
pander(myTable)

