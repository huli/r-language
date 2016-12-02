
# load workspace
load("myscript")

# load source
source("mylibrary")

# redirect output
sink("myoutput")

# stop redirecting
dev.off()

# scalars are one element vectors
a <- TRUE
class(a)
is.vector(a)

# vectors
v <- c(1,2,3,4,5,10:45)
v[c(5:10, 1)]
dim(v) # NULL

# matrix is 2dim array
m <- matrix(1:20, nrow = 5, ncol = 4)
dim(m) # 5 4
length(dim(m)) # 2 (number of dimensions)

# array - are natural extensions of matrices
# (more than 2 dimensions possible)
dim1 <- LETTERS[1:2]
dim2 <- c(1,2,3)
dim3 <- c("t1", "t2", "t3", "t4")
arr <- array(1:24, c(2,3,4), dimnames = list(dim1,dim2,dim3))


