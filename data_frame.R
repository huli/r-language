


df <- data.frame(c(1,2,3,4), c("eins","zwei","drei","vier"))
names(df) <- c("col1", "col2")

# Eine neue kombinierte Spalte machen
library(dplyr)
df %>% 
  mutate(col3 = paste(col1, col2))


