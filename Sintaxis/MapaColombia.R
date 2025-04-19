# Install and load necessary packages if you haven't already
# install.packages(c("geodata", "ggplot2", "sf"))
library(geodata)
library(ggplot2)
library(sf)

# Get the shapefile for Colombia's departments (level 1 administrative divisions)
colombia_depto <- geodata::gadm(country = "COL", level = 1, path = tempdir())

# Convert the SpatialPolygonsDataFrame to an sf object
colombia_depto_sf <- st_as_sf(colombia_depto)

# Create the plot using ggplot2 with geom_sf
ggplot(colombia_depto_sf) +
  geom_sf(color = "black", fill = "lightgray") +
  labs(title = "Map of Colombia with Departments") +
  theme_minimal()


colombia_depto <- geodata::gadm(country = "COL", level = 1, path = tempdir())

# Convert to an sf object
colombia_depto_sf <- st_as_sf(colombia_depto)

# Departments to color in green
green_departments <- c("Antioquia", "Amazonas", "Atlántico", "Bogotá D.C.",
                       "Bolívar", "Caldas", "Cundinamarca", "Quindío",
                       "Risaralda", "Santander", "Valle del Cauca")

# Create a new column to store the color for each department
colombia_depto_sf$color <- ifelse(colombia_depto_sf$NAME_1 %in% green_departments,
                                  "green", "red")
colombia_depto_sf$Grupo <- ifelse(colombia_depto_sf$NAME_1 %in% green_departments,
                                  "Grupo A", "Grupo B")

png(filename = "Colombia.png", width = 1200, height = 900, units = "px", bg = "transparent", res = 300)
ggplot(colombia_depto_sf) +
  geom_sf(aes(fill = Grupo), color = "black") +
  scale_fill_manual(values = c("Grupo A" = "green", "Grupo B" = "red"),
                    name = "Asignación de Recursos") +
  labs(title = "") +
  theme_void()
dev.off()







library(tmap) # para mapas estáticos e interactivos
library(ggplot2) # paquete de visualización de datos tidyverse (aunque tmap tiene su propia sintaxis)

# Asumiendo que tienes un objeto sf llamado 'colombia'
# Si no lo tienes, asegúrate de ejecutar el código para leer el shapefile primero:
# library(sf)
# ruta_archivo <- "departamentos_colombia.shp"
# colombia <- st_read(ruta_archivo)

# 1. Mapa con solo el relleno de los departamentos
mapa_relleno <- tm_shape(colombia) +
  tm_fill() +
  tm_layout(title = "Departamentos de Colombia (Relleno)")
print(mapa_relleno)

# 2. Mapa con solo los bordes de los departamentos
mapa_bordes <- tm_shape(colombia) +
  tm_borders() +
  tm_layout(title = "Departamentos de Colombia (Bordes)")
print(mapa_bordes)

# 3. Mapa con relleno y bordes de los departamentos
mapa_relleno_bordes <- tm_shape(colombia) +
  tm_fill() +
  tm_borders() +
  tm_layout(title = "Departamentos de Colombia (Relleno y Bordes)")
print(mapa_relleno_bordes)

# Opcional: Puedes guardar los mapas como archivos
# tmap_save(mapa_relleno, filename = "colombia_relleno.png")
# tmap_save(mapa_bordes, filename = "colombia_bordes.png")
# tmap_save(mapa_relleno_bordes, filename = "colombia_relleno_bordes.png")