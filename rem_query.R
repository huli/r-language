

install.packages("RODBC")
install.packages("data.table")
install.packages("ggplot2")


library(RODBC)
library(data.table)
library(ggplot2)
library(dplyr)

connection <- odbcDriverConnect('driver={SQL Server};server=sqlrem\\sql2005;database=rem_unit_test;trusted_connection=true')
mietzinse <- sqlQuery(connection, "select mz.GueltigAb ,mz.BetragNetto, abr.KantonCD, 
		                  abr.Ort,
                      abr.Bezeichnung1, 
                      art.Bez,
                      art.ObjektKategorieCD,
                      o.AnzahlZimmerCD
                      from Mietzins mz
                      join Objekt o on mz.ObjektOID = o.OID
                      join Haus h on o.HausOID = h.OID
                      join AbrechEinheit abr on abr.OID = h.AbrechEinheitOID
                      join ObjektArt art on art.OID = o.ObjektArtOID
                      where GueltigAb > \'2000-01-01\'
                      and GueltigAb < \'2017-01-01\'
                      order by Ort")

mietzinse %>% 
  group_by(GueltigAb < '2002-01-01') %>% 
  summarise(avg_betrag = mean(BetragNetto))

mietzinse %>% 
  mutate(year = format(GueltigAb, "%Y")) %>% 
  mutate(month = format(GueltigAb, "%m"))
  group_by(year_month) %>% 
  summarise(avg_betrag = mean(BetragNetto))

mietzinse[1:10,] %>% 
  mutate(year_month = cat(year(GueltigAb), months(GueltigAb), sep = ""))

summary(mietzinse)
str(mietzinse)

cat("adsfad", 4)

mietzinse[1, "GueltigAb"] %>%  format("%m")  
mietzinse[1, "GueltigAb"] %>%  format("%Y")  

mietzinse %>% 
  filter(!is.na(AnzahlZimmerCD) & AnzahlZimmerCD == "3.5") %>% 
  ggplot(aes(x = GueltigAb, y = BetragNetto)) +
  geom_point()




close(connection)
