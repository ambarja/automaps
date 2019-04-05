## AUTOMATIZANDO LA ELABORACIÓN DE MAPAS EN R CON TMAP --------------------

# Insumos -----------------------------------------------------------------
setwd('C:/Users/Antony/Desktop/shp')
#  Instalación del paquete sf
# install.packages('sf', dependencies = TRUE) 
## Llamado o activación del paquete sf
library(sf) # Manejo de datos vectoriales


# Lectura de un archivo .shp dentro de R ----------------------------------
shp <- st_read('huanuco.shp')
st_crs(shp)
names(shp)


# Mapas temáticos con Tmap  -----------------------------------------------
library(tmap)
tmap_options(inner.margins = c(0.1, 0.3, 0.06, 0.05)) +
    tm_shape(shp) +
    tm_layout(frame = FALSE) +
    tm_fill('Pobreza', palette = 'viridis', legend.hist = T) +
    tm_compass() +
    tm_scale_bar() +
    tm_layout(
        legend.hist.size = 0.9,
        legend.hist.width = 0.3,
        legend.position = c(0.074, 0.04),
        legend.outside = F,
        legend.height = 0.45
    ) +
    tm_grid(lwd = 0.05, col = 'black', alpha = 0.15)


# Automatización de elboración de mapas con Tmap --------------------------
for (i in 13:23) {
    map <- tmap_options(inner.margins = c(0.1, 0.3, 0.06, 0.05)) +
        tm_shape(shp) +
        tm_layout(frame = FALSE) +
        tm_fill(colnames(shp)[i],
                palette = 'viridis',
                legend.hist = T) +
        tm_compass() +
        tm_scale_bar() +
        tm_layout(
            main.title = paste('Mapa de ', colnames(shp)[i]),
            legend.hist.size = 0.9,
            legend.hist.width = 0.3,
            legend.position = c(0.074, 0.04),
            legend.outside = F,
            legend.height = 0.45
        ) +
        tm_text("NOMBDIST", size = 0.2, shadow = TRUE) +
        tm_grid(lwd = 0.05,
                col = 'black',
                alpha = 0.15)
    tmap_save(
        map,
        paste(tm = NULL, './plots/tmap', i, '.png', sep = ''),
        dpi = 300,
        width = 6,
        height = 5
    )
}


# FIN *********************************************************************
