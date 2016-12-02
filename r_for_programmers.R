

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

# Hint: Parameters are passed by value


# They consist out of three parts
f <- function(x) x^2

# Formals - the list of arguments which controls how you can call the function
formals(f)
# $x

# Body -  the code inside the function
body(f)
# x^2

# Environment - the “map” of the location of the function’s variables
environment(f)
# <environment: R_GlobalEnv>

# You can also add aditional attributes to function
# attributes(f)
# Note: You can also add attributes to a function. For example, 
# you can set the class() and add a custom print() method.

# Primitive funktions are exceptions to this, they to not have these 3
# componenents and will return NULL
formals(sum)
# NULL

# List all functions in base package
objs <- mget(ls("package:base"), inherits = TRUE)
funs <- Filter(is.function, objs)

# Lexical scoping
x = 1
z = 1
f <- function(){
  y = 2
  f2 <- function() {
    z = 3
    cat(x,y,z)
  }
}

f()()
# 1 2 3


# OOP in R
# ----------------------------------------------------------

# R has three different object oriented systems (and the base types):

# (base types)
# ------------------------------------------------------------------
# Every R object consists of a C structure holding the content of the
# object, information for memory management and the type

f <- function(){}
typeof(f)
# [1] "closure"

is.function(f)
# [1] TRUE

# the type of a primitive function is builtin
typeof(sum)
# [1] "builtin"

is.primitive(sum)
# [1] TRUE

# S3
# ------------------------------------------------------------------

# (R's first and simplest oo system)

# to find out if an object is an S3 object
is.object(3) & !isS4(3)
# [1] FALSE

# or with the pryr package
# install.packages("pryr")
library(pryr)

df <- data.frame(x = 1:10, y = letters[1:10], c(11:20))

# a data frame is a S3 class
otype(df)

# in S3 methods belong to functions, called generic functions
# not to classes or objects

# generic S3 methods have UseMethod in their source
# (except builtin generic functions written in C)
mean
# function (x, ...) 
#   UseMethod("mean")
# <bytecode: 0x000000000b7dc080>
#   <environment: namespace:base>
  
ftype(mean)
# [1] "s3"      "generic"

# Generic functions look like generic.class()
# (Therefore you should not use . in function names)

ftype(t.data.frame)
# [1] "s3"     "method"

ftype(t.test)
# [1] "s3"      "generic"

# list all methods that belong o a generic
methods("t.test")
# [1] t.test.default* t.test.formula*

# or all generics that have a method for a class
methods(class = "ts")
# ...

# Create a class with structure
obj <- structure(list(), class = "myClass")

# or by assigning it
instance <- list()
class(instance)
# [1] "list"

class(instance) <- "myClass"
# [1] "myClass"

inherits(instance, "myClass")
# [1] TRUE

# Constructor functions in R
myClass <- function(x) {
  if (!is.numeric(x)) stop("X must be numeric")
  structure(list(x), class = "myClass")
}

test <- myClass()
class(test)
# [1] "myClass"

# Creating new methods and generics
f <- function(x) UseMethod("f")
ftype(f)

f.myClass <- function(x) "Called on myClass"
f.numeric <- function(x) "Called on numeric"

class(instance)
f(instance)
# [1] "Called on myClass"

class(2)
f(2)
# [1] "Called on numeric"

# you can also make a default
f.default <- function(x) "Called on unknown class"
f("e")
# [1] "Called on unknown class"

# S4

# Reference classes

