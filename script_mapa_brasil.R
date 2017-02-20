# Carregando os pacotes----
  
library(maptools)     
library(spdep)          
library(cartography)    
library(tmap)           
library(leaflet)        
library(dplyr)
library(rgdal)
library(dplyr)
library(RColorBrewer) 

# Importando shapefile (mapa do Brasil)----

shp <- readOGR("Mapa\\.", "BRUFE250GC_SIR", stringsAsFactors=FALSE, encoding="UTF-8")

class(shp)

# Importando dataset----

pg <- read.csv("Dados\\ClassificacaoPontosCorridos.csv", header=T,sep=";")

pg <- pg %>% group_by(Estado) %>% mutate(cumsum = cumsum(PG))

pg <- pg %>%
  group_by(Estado) %>%
  summarise(Score= max(cumsum))

pg <- as.data.frame(pg)

class(pg)

# Importando códigos do IBGE e adicionando ao dataset----

ibge <- read.csv("Dados\\estadosibge.csv", header=T,sep=",")

pg <- merge(pg,ibge, by.x = "Estado", by.y = "UF")

# Fazendo a junção entre o dataset e o shapefile----

brasileiropg <- merge(shp,pg, by.x = "CD_GEOCUF", by.y = "Código.UF")

#Tratamento e transformação dos dados----

proj4string(brasileiropg) <- CRS("+proj=longlat +datum=WGS84 +no_defs") #adicionando coordenadas geográficas

Encoding(brasileiropg$NM_ESTADO) <- "UTF-8"

brasileiropg$Score[is.na(brasileiropg$Score)] <- 0 #substituindo NA por 0


# Gerando o mapa----

pal <- colorBin("Blues",domain = NULL,n=5) #cores do mapa

state_popup <- paste0("<strong>Estado: </strong>", 
                      brasileiropg$NM_ESTADO, 
                      "<br><strong>Pontos: </strong>", 
                      brasileiropg$Score)
leaflet(data = brasileiropg) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(fillColor = ~pal(brasileiropg$Score), 
              fillOpacity = 0.8, 
              color = "#BDBDC3", 
              weight = 1, 
              popup = state_popup) %>%
  addLegend("bottomright", pal = pal, values = ~brasileiropg$Score,
            title = "Pontos Conquistados",
            opacity = 1)







