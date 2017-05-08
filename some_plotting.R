
# Barplots

library(vcd)

df <- table(Arthritis$Improved, Arthritis$Treatment)

# Placebo Treated
# None        29      13
# Some         7       7
# Marked       7      21

barplot(df, 
        beside = T,
        col = c("red","green","yellow"),
        legend = rownames(df))


# Spinograms

library(vcd)
attach(Arthritis)

df <- table(Treatment, Improved)
spine(df, main = "Spinogramm")

detach(Arthritis)


# Finally a Pie you can compare

library(plotrix)
slices <- c(10, 12, 4, 16, 8)
labels <- c("US", "UK", "Australia", "France", "Switzerland")

fan.plot(slices, labels = labels, main = "Fan Plot")


# Histogram

mpgs <- mtcars$mpg
h <- hist(mpgs,
          breaks = 12,
          main = "Histogram with normal curve and box")
xfit <- seq(min(mpgs), max(mpgs), length = 40)
yfit <- dnorm(xfit, mean= mean(mpgs), sd = sd(mpgs))
yfit <- yfit *diff(h$mids[1:2]) * length(mpgs)
lines(xfit, yfit, lwd = 2)
box()
rug(jitter(mtcars$mpg))



# Density plots

par(mfrow = c(2,1))

d <- density(mtcars$mpg)

plot(d)
polygon(d, col = "red", border = "blue")
rug(mtcars$mpg, col = "brown")

# with grouping

#install.packages("sm")
dev.off()
library(sm)

attach(mtcars)

cyl_f <- factor(cyl, levels = c(4,6,8),
                labels = c("4 cylinder", "6 cylinder",
                           "8 cylinder"))
sm.density.compare(mpg, cyl, xlab = "Miles Per Gallon")
title("MPG Distribution by Car Cylinders")

colfill <- c(2:(1+length(levels(cyl_f))))
legend(locator(1), levels(cyl_f), fill = colfill)

detach(mtcars)


# Boxplots with statistics

boxplot(mtcars$mpg, main="Box plot", ylab = "Miles per Gallon")
boxplot.stats(mtcars$mpg)

mtcars$cyl_f <- factor(mtcars$cyl,
                       levels = c(4,6,8),
                       labels = c("4","6","8"))
mtcars$am_f <- factor(mtcars$am,
                      levels = c(0,1),
                      labels = c("auto", "standard"))

boxplot(mpg ~ am_f * cyl_f,
        data = mtcars,
        varwidth = T,
        col = c("gold", "darkgreen"),
        main = "MPG Distribution by Auto Type",
        xlab = "Auto Type", ylab = "Miles Per Gallon")

# or as violin plot
library(vioplot)

vioplot(mtcars$mpg[mtcars$cyl ==4],
        mtcars$mpg[mtcars$cyl ==6],
        mtcars$mpg[mtcars$cyl ==8],
        names = c("4 cylinder", "6 cylinder",
                  "8 cylinder"),
        col = c("gold"))
