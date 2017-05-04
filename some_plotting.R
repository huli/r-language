
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
