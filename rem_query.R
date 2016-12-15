

install.packages("RODBC")
install.packages("data.table")
install.packages("ggplot2")


library(RODBC)
library(data.table)
library(ggplot2)

connection <- odbcDriverConnect('driver={SQL Server};server=sqlrem\\sql2005;database=rem_unit_test;trusted_connection=true')
person_table <- sqlQuery(connection, 'select OID, PersonID, Name, Vorname from dbo.Person')
# adresse_table <- sqlQuery(connection, 'select OID, Strasse, Ort, Plz from Adresse')
# adressezuordnung_table <- sqlQuery(connection, 'select * from dbo.Adresszuordnung')
# 
# newest_adresszuordnungen <- as.data.table(adressezuordnung_table)[
#               , .(GueltigAb, PersonOID, AdresseOID)][ 
#                 , GueltigAb := max(GueltigAb), by=PersonOID]


personen <- as.data.table(person_table)
personen <- personen[ Name != " "][!is.na(Name)]

personen[, Vorkommen := .N, by = Name]

nrow(personen)
setkey(personen, Name)
key(personen)

str(personen)
unique_personen <- personen[, .(Name, max(Vorkommen)), by=Name]
str(unique_personen)

ordered_vorkommen <- unique_personen[order(-V2)][1:10]

ggplot(ordered_vorkommen[order(-V2)]) +
  aes(y = V2, x = Name) +
  geom_point()  +
  ylim(0, 1000)


close(connection)
