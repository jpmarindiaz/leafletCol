

library(devtools)
document()
load_all()

install()

library(leafletCol)
# devtools::install_github('rstudio/leaflet', ref='feature/color-legend')

d <- read.csv(system.file("data/mapBogGGCN.csv",package = "leafletCol"))
leafletBog(d, theme="bw")


leafletBogIcon(d[1:2,], theme="bw")


