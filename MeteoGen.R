## A mérőállomás azonosítószáma
StationID = "55405" # Karcag
## Forrás URL
teszturl = paste0("https://odp.met.hu/climate/observations_hungary/daily/recent/HABP_1D_",
                  StationID,
                  "_akt.zip")
## Zip fájlnév változóból
zipfilename = paste0("P",
                     StationID,
                     ".zip")
## Fájl letöltés
download.file(teszturl, zipfilename, mode = "wb")
# Fájl név kinyerése a zip fájlból, itt nincs kicsomagolás, csak listázás.
csvfile <- unzip(zipfilename, list = TRUE)$Name
## Kicsomagolás
unzip(zipfilename, exdir = tempdir())
## Adat importálás az adat nevű objektumba
adat <- read.table(file.path(tempdir(), csvfile), sep = ";", head = TRUE)
## Csapadékösszeg kiíratás a lekérdezett állomás ez ideig feltöltött adataira
sum(adat$rau)
## Az adatok kiírása csv-be
write.csv2(adat, "MeteoIdei.csv")
