


data <- readxl::read_xlsx("D:\\Source\\r-language\\AirRating.xlsx")
sd(rating$Rating)
mean(rating$Rating)

hist(rating$Rating)

result <- t.test(rating$Rating, 
                mu = 7, 
                alternative ="two.sided")
result


tcrit = qt(0.025, df= 59)
dum = seq(-3.5, 3.5, length=10^4)
plot(dum, dt(dum, df=59), type='l', xlab='t', ylab='f(t)')
abline(v=result$statistic, lty=3)
abline(v=tcrit, col='red', lty=2)
abline(v=-tcrit, col='red', lty=2)

# Some plotting
library(MASS)
library(ggplot2)

h = na.omit(data$Rating)
pop.mean = mean(h)

n_reps = 20
sample_size = 30
res_list = list()

for (i in 1:n_reps) {
  h.sample = sample(h, sample_size)
  res_list[[i]] = t.test(h.sample, mu=pop.mean)
}

dat = data.frame(id=seq(length(res_list)),
                 estimate=sapply(res_list, function(x) x$estimate),
                 conf_int_lower=sapply(res_list, function(x) x$conf.int[1]),
                 conf_int_upper=sapply(res_list, function(x) x$conf.int[2]))

p = ggplot(data=dat, aes(x=estimate, y=id)) +
  geom_vline(xintercept=pop.mean, color="red", linetype=2) +
  geom_point(color="grey30") +
  geom_errorbarh(aes(xmin=conf_int_lower, xmax=conf_int_upper), 
                 color="grey30", height=0.4)

p
