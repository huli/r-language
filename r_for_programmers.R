

# Assignments can be made both ways
foo <- "bar"
"foo" -> bar

# R has several reserved one-letter words
#  c, q, s, t, C, D, F, I, and T.

# T and F are just variables with the default
# meaning of TRUE and FALSE
F == FALSE
T == TRUE
F <- TRUE #!
F == TRUE


# Vectors
----------------------------------------------------------

# The primary data type in R is the vector
# A vector in R is a container vector - a statistician’s 
# collection of data, not a mathematical vector
vector.a <- c(1,2,3,4)
vector.b <- c(5,6,7,8)

vector.c <- vector.a + vector.b
# [1]  6  8 10 12

vector.a == 2
# [1] FALSE  TRUE FALSE FALSE

# vectors are indexed by 1
vector.c[1]
# [1] 6

# negativ indexes on vectors remove an element
vector.c[-1]
# [1]  8 10 12

# Note:
# a single number is just a vector with the size of 1


# Sequences
# ----------------------------------------------------------
  
# Sequences in R are closed intervals
seq(3, 17, 5)
# [1]  3  8 13

# alternate notation
seq(3, 10, length.out = 5)
# [1]  3.00  4.75  6.50  8.25 10.00


# Types
# ----------------------------------------------------------

# the type of a vector, and therefore any element must be
# all the same type and one of the following:
# logical, integer, double, complex, character, or raw
# (Lists do not have this limitation)

# conversion are made with the naming convention
# as.xxx where x denotes the target type
t <- as.numeric("2")
class(t)
# [1] "numeric"


# Boolean operators
# ----------------------------------------------------------

# The operators & and | apply element-wise on vectors. 
T | F
# [1] TRUE

# && and || use lazy evaluation 
T || stopifnot(FALSE)
# [1] TRUE
T | stopifnot(FALSE)
# Error: FALSE ist nicht TRUE


# Lists
# ----------------------------------------------------------

# Lists are like vectors, except elements need not have
# the same type

l <- list(name = "First", 2, c("3","rd"))
l[1] == l$name
# TRUE 


# Matrices
# ----------------------------------------------------------
  
a <- matrix( c(2, 4, 3, 1, 5, 7), 
             nrow=2, 
             ncol=3, 
             byrow = TRUE)       

# [,1] [,2] [,3]
# [1,]    2    4    3
# [2,]    1    5    7

# only one column
a[,1]
# [1] 2 1

# only one row
a[1,]
# [1] 2 4 3

# and they can become row and column names
dimnames(a) = list( 
      c("row1", "row2"),         # row names 
      c("col1", "col2", "col3")) # column names 

# col1 col2 col3
# row1    2    4    3
# row2    1    5    7


# Missing values, Infs and NA
# ----------------------------------------------------------

# there is "Inf"
3 / 0
# [1] Inf

# and not applicaple/avaible
c(1,2,3)[4]
# [1] NA

is.na(c(1,2,3)[4])
# [1] TRUE


# Functions
# ----------------------------------------------------------

# They can have default values (not only at the last position)

f <- function(a=10, b)
{
  return (a+b)
}

f(b = 3)
# [1] 13
