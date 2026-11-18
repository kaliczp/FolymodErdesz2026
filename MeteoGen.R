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
## Az adat objektum struktúrája
str(adat)

## Korábbi évek adatainak letöltése
## Korábbi adatok kiszűrése a szerverről
install.packages("xml2") # Telepítés után már nem kell többször futtatni. Mehet ## a sor elejére.
library(xml2) # A telepített csomag betöltése.
## Történeti csapadék adatok URL
archurl <- "https://odp.met.hu/climate/observations_hungary/daily/historical/"
## Történeti csapadék adatok letöltése
html <- read_html(archurl)
## zip fájlok kiválasztása a linkekből
fajlnevek <- xml_text(
  xml_find_all(html, "//a[contains(@href, '.zip')]")
)
## Az állomás kiválasztása a zip fájlnevek közül
archzipfile <- grep(paste0("_",StationID,"_"), fajlnevek, value = TRUE)
## A mappa URL-lel összefűzés
fullarchurl <- paste0(archurl, archzipfile)
## Letöltés
download.file(fullarchurl, archzipfile, mode = "wb")
# Fájl név kinyerése a zip fájlból, itt nincs kicsomagolás, csak listázás.
archcsvfile <- unzip(archzipfile, list = TRUE)$Name
## Kicsomagolás
unzip(archzipfile, exdir = tempdir())
## Adat importálás az adat nevű objektumba
archadat <- read.table(file.path(tempdir(), archcsvfile), sep = ";", head = TRUE)

## A korábbi évek és idei év összefűzése
fulladat <- rbind(archadat, adat)
## Nyers adatsor exportálás
write.csv2(fulladat, "adat.csv")

## xts csomag telepítése a napi felbontású idősorhoz
install.packages("xts")
library(xts)
csaptemp.xts <- xts(fulladat[,c("rau", "t")], as.Date(as.character(fulladat$Time), format="%Y%m%d"))
## Az összefűzött csapadék, és hőmérséklet adatsor ábárzolása
plot(csaptemp.xts)

## Külön-külön
## csapadék
plot(csaptemp.xts$rau, col = "blue")
## hőmérséklet
plot(csaptemp.xts$t, col = "red")
