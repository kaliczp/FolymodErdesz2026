# Havi értékesítési adatok
ertekesites <- c(120, 135, 128, 145, 160, 155,
                 170, 180, 175, 190, 200, 210)

# Idősor létrehozása
idosor <- ts(ertekesites,
             start = c(2025, 1),
             frequency = 12)

# Idősor megjelenítése
print(idosor)
