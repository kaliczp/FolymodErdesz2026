# Havi erdőlátogatás adatok
erdőlátogatók_száma <- c(120, 135, 128, 145, 160, 155,
                         170, 180, 175, 190, 200, 210)

# Idősor létrehozása
idosor <- ts(erdőlátogatók_száma,
             start = c(2025, 1),
             frequency = 12)

# Idősor megjelenítése
print(idosor)

plot(idosor,
     main = "Havi értékesítési adatok",
     xlab = "Év",
     ylab = "Erdőlátogatók [fő]",
     col = "blue",
     type = "o")

## Idősor elemzés bevezetés
data(co2)
## Az adatok leírása
?co2
## Félelmetes emelkedés
plot(co2)
## Az adatok
co2
## Átalakítás adattáblává
## Idő
time(co2)
## Az adatok
as.numeric(co2)
## Adattábla előállítása
co2.df <- data.frame(time = time(co2), co2 = as.numeric(co2))
## Adattábla nyomtatás
plot(co2.df)
## Mentés csv-be
write.csv2(co2.df, file = "co2df.csv")
