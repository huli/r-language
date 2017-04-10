
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

# data.frame is a matrix with columns of different types
# do safe typing
attach(mtcars)
  summary(mpg)
  mean(mpg)
  plot(mpg, wt)
detach(mtcars)
  
# or better (but beware scope)
with(mtcars,{
  plot(mpg, wt)
  foroutherscope <<- summary(mpg)
})

foroutherscope # still exists

# factors
# are oridinal or nominal variables
status <- factor(c("Poor","Improved","Excellent", "Poor"), 
                 order = TRUE,
                 levels = c("Poor","Improved","Excellent"))

# list are the most complex types in R (?)
mylist <- list(c(1,2,3), foo=LETTERS[1:4], bar = "anything")
mylist["foo"]

# edit input by hand
mydata <- data.frame(age=numeric(0), gender=character(0),
                     weight=numeric(0))
mydata <- edit(mydata)


# read xls
library(xlsx)
download.file("https://www.lzg.nrw.de/00indi/0data/04/excel/0400900052014.xls", 
              "c:\\temp\\bmi_data.xls", 
              mode="wb")

bmidata <- read.xlsx("C:\\temp\\bmi_data.xls", 1)

# twitter
install.packages("twitteR")
library(twitteR)
# -> needs OAuth

# Connecting SQL Server
library(RODBC)
connection <- odbcDriverConnect('driver={SQL Server};server=sqlrem\\sql2005;database=rem_unit_test;trusted_connection=true')
person_table <- sqlQuery(connection, 'select PersonID, Name, Vorname from dbo.Person')
close(connection)


# Graphs

with(mtcars, {
  plot(wt, mpg)
  abline(lm(mpg~wt))
  title("Regression von MPG auf Gewicht")
})

# Enter some data for experimentation
dosage <- c(20, 30, 40, 45, 60)
drug_a <- c(16, 20, 27, 40, 60)
drug_b <- c(15, 18, 25, 31, 40)

# graphical parameters
opar <- par(no.readonly = T)
par(lty = 2, pch = 17)
plot(dosage, drug_a, type = "b")
par(opar)

# or
plot(dosage, drug_a, type = "b", lty = 2, pch = 17, cex = 1.5)

# colors - RColorBrewer is nice
if(!require(RColorBrewer)) install.packages("RColorBrewer")
n <- 7
my_colors <- brewer.pal(n, "Set1")
barplot(rep(1,n), col = my_colors)

# see all palettes
display.brewer.all()

# rainbow or gray
n <- 12
my_colors <- rainbow(n)
pie(rep(1,n), labels = my_colors, col = my_colors)
my_colors <- gray(0:n/n)
pie(rep(1,n), labels = my_colors, col = my_colors)

# fonts
plot(1:10,1:10,type="n")
windowsFonts(
  A=windowsFont("Arial Black"),
  B=windowsFont("Bookman Old Style"),
  C=windowsFont("Comic Sans MS"),
  D=windowsFont("Symbol")
)
text(3,3,"Hello World Default")
text(4,4,family="A","Hello World from Arial Black")
text(5,5,family="B","Hello World from Bookman Old Style")
text(6,6,family="C","Hello World from Comic Sans MS")
text(7,7,family="D", "Hello World from Symbol")

# some plotting without ggplot :)

# axis
x <- c(1:10)
y <- x
z <- 10/x
opar <- par(no.readonly = T)

par(mar=c(5, 4, 4, 8) + .1)
plot(x, y, type = "b", pch = 21, col = "red", yaxt = "n", lty = 3, ann = FALSE)

lines(x, z, type = "b", pch = 22, col = "blue", lty = 2)

axis(2, at = x, labels = x, col.axis = "red", las = 2)

axis(4, at = z, labels = round(z, digits = 2),
     col.axis = "blue", las = 2, cex.axis = .7, tck = -.01)

mtext("y=1/x", side = 4, line = 3, cex.lab = 1, las = 3, col = "blue")

title("An example of creative axes",
      xlab = "X values",
      ylab = "Y=X"
      )

par(opar)


opar <- par(no.readonly = T)

par(lwd = 1, cex = 1.0, font.lab = 1)

plot(dosage, drug_a, type = "b",
     pch = 15, lty = 1, col = "red", ylim = c(0, 60),
     main = "Drug A vs. Drug B",
     xlab = "Drug Dosage", ylab = "Drug Response")

lines(dosage, drug_b, type = "b", pch = 17, lty = 2, col = "blue")

abline(h = c(30), lwd = 1.5, lty = 2, col = "gray")

if(!require(Hmisc)) install.packages("Hmisc")
library(Hmisc)
minor.tick(nx = 3, ny = 3, tick.ratio = .5)

legend("topleft", inset = .05, title = "Drug Type", c("A","B"), lty = c(1,2), pch = c(15, 16), col = c("red","blue"))

# text annotations
text(40, 40, "Possible error in measure method", pos = 3)

# combining graphs with par
with(mtcars, {
  opar <- par(no.readonly = T)
  par(mfrow = c(2, 2))
  plot(wt, mpg, main = "Scatterplot of wt vs. mpg")
  plot(wt, disp, main = "Scatterplot of wt vs. disp")
  hist(wt, main = "Histogram of wt")
  boxplot(wt, main = "Boxplot of wt")
  par(opar)
})

# fine figure arrangement
opar <- par(no.readonly = T)
par(fig = c(0, 0.8, 0, 0.8))
plot(mtcars$mpg, mtcars$wt,
     xlab = "Miles Per Gallon",
     ylab = "Car Weight")
par(fig = c(0, 0.8, 0.3, 1), new = T)
boxplot(mtcars$mpg, horizontal = T, axes = F)

par(fig = c(0.65, 1, 0, 0.8), new = T)
boxplot(mtcars$wt, axes = F)

# Maniuplating Data
str(mtcars)
range(mtcars$hp)

# similar to with, but allows modification
within(mtcars, {
    power <- NA
    power[hp > 250] <- "strong"
    power[hp <= 250] <- "weak"
}) -> mycars

# renaming variables with more control than names(xy)[x] <- "bla"
library(plyr)
rename(mycars, c(power="strongness"))

# remember
is.na(NA)
# [1] TRUE
is.na(NaN)
# [1] TRUE
is.nan(NA)
# [1] FALSE
is.nan(NaN)
# [1] TRUE

vals <- c(NA, 1, 2, 3, NA)
vals_without_na <- na.omit(vals)

frame <- data.frame(Col1=c(1,2,3), Col2=c("B", "C", NA))
na.omit(frame)


# Check for NA in a Vector and measure performance
x <- y <- runif(1e7)
x[1e4] <- NA
y[1e7] <- NA
microbenchmark::microbenchmark(any(is.na(x)), anyNA(x), any(is.na(y)), anyNA(y), times=10)

# On which weekday is my last birthday
format(as.Date("2018-08-31"), "%A")

# Nice package for datetime manipulation
library(lubridate)

# odering data
mtcars[order(mtcars$mpg),]

iris[order(iris$Species, iris$Sepal.Length), ]

# merging data sets
df <- data.frame(c(1,2,3,4), c("eins","zwei","drei","vier"))
cbind(df, data.frame(c("I","II","III","IIII")))

# for joining data
#merge(frame1, frame2, by="IdColumn")

# adding rows
df <- data.frame(c(1,2,3,4))
rbind(df, "foo")


# Sql Statments for selecting data
# install.packages("sqldf")
library(sqldf)

sqldf("select sum(mpg), sum(wt), * from mtcars where carb=1 group by gear")


# apply
data <- matrix(rnorm(30), nrow = 5)

# row means
apply(data, 1, mean)

# column means 
apply(data, 2, mean)

