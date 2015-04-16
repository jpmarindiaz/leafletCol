#' @export
leafletBog <- function(d, popupTpl = NULL, theme="default"){
  # dmap must have cols c("lat","lng","size","group")
  if(! all(c("lat","lng","size","group") %in% names(d)))
    stop('Names must be c("lat","lng","radius","color","popup") ')

  # TODO fix popup template
  propCols <- names(d)[!names(d)%in% c("lat","lng")]
  d$popup <- apply(d[propCols], 1, paste, collapse=",")

  # Prep data
  palName <- "Spectral" # name of an RBrewer palette
  pal <- colorFactor(palName, NULL, levels= levels(d$group))
  d$color <- pal(d$group)
  d$radius <- d$size

  if(theme=="default"){
    urlTemplate <- "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
    }
  if(theme=="bw"){
    urlTemplate <-'http://{s}.tile.stamen.com/toner-lite/{z}/{x}/{y}.png'
  }

  # Make map
  c <- leaflet()
  c <- addTiles(c,urlTemplate = urlTemplate)
  c <- setView(c, -74.1, 4.67, zoom = 11)



  c <- addCircleMarkers(c, lat=d$lat,
                        lng=d$lng,
                        radius=d$radius,
                        color=d$color,
                        popup=d$popup)



  c
}



#' @export
leafletBogIcon <- function(d, popupTpl = NULL, theme="default", iconUrl="default"){
  # dmap must have cols c("lat","lng","size","group")
  if(! all(c("lat","lng") %in% names(d)))
    stop('Names must be c("lat","lng","radius","color","popup") ')

  # TODO fix popup template
  propCols <- names(d)[!names(d)%in% c("lat","lng")]
  d$popup <- apply(d[propCols], 1, paste, collapse=",")

  # Prep data
  palName <- "Spectral" # name of an RBrewer palette
  pal <- colorFactor(palName, NULL, levels= levels(d$group))
  d$color <- pal(d$group)
  d$radius <- d$size


  if(iconUrl=="default")
    iconUrl <- "http://lasillavacia.com/crimenycastigo/sites/all/themes/crimenycastigo/img/map/iconos/ico_lupa.png"

  iconJs <- paste("L.icon({iconUrl: '",iconUrl,"',iconSize: [40, 40]})")

  if(theme=="default"){
    urlTemplate <- "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
  }
  if(theme=="bw"){
    urlTemplate <-'http://{s}.tile.stamen.com/toner-lite/{z}/{x}/{y}.png'
  }
  # Make map
  c <- leaflet()
  c <- addTiles(c,urlTemplate = urlTemplate)
  c <- setView(c, -74.1, 4.67, zoom = 11)

  c <- addMarkers(c,lat=d$lat,
                  lng=d$lng,
                  popup=d$popup
                  , icon = JS(iconJs))
  c
}


