

library(RODBC)
library(data.table)

connection <- odbcDriverConnect('driver={SQL Server};server=sqlrem\\sql2005;database=rem_unit_test;trusted_connection=true')
person_table <- sqlQuery(connection, 'select OID, PersonID, Name, Vorname from dbo.Person')
adresse_table <- sqlQuery(connection, 'select OID, Strasse, Ort, Plz from Adresse')
adressezuordnung_table <- sqlQuery(connection, 'select * from dbo.Adresszuordnung')

newest_adresszuordnungen <- as.data.table(adressezuordnung_table)[
              , .(GueltigAb, PersonOID, AdresseOID)][ 
                , GueltigAb := max(GueltigAb), by=PersonOID]




close(connection)
