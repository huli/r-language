
library(foreign)

# file.choose()
df_world = read.spss("C:\\temp\\WELT.SAV", to.data.frame=TRUE)


View(df_world)

str(df_world)

model <- lm(LEM ~ KALORIEN, na.action = na.omit, df_world)
plot(model)

summary(model)

library(ggplot2)

ggplot(df_world) +
  geom_point(aes(KALORIEN, LEM)) +
  stat_smooth(aes(KALORIEN, LEM), method = "lm")


hist(df_world$KALORIEN)





