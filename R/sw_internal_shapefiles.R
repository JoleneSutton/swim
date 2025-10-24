#' Get the example shapefiles
#'
#' Imports a stored shapefile as a SpatVector (terra).
#' @param x Only option is to return all
#' @importFrom terra vect
#' @return Returns a list of SpatVectors
#' x<-sw_internal_shapefiles('all')
#' x
#' @export
sw_internal_shapefiles<-function(x){

  if(x=='all'){
  naf4t<-readRDS(system.file('extdata','nafo_4t_list.rds',package='swim'))
  naf4t<-terra::vect(naf4t, geom=c("geometry"), crs='ESRI:102001', keepgeom=F)

  spatial.grid<-readRDS(system.file('extdata','spatial_grid_list.rds',package='swim'))
  spatial.grid<-terra::vect(spatial.grid, geom=c("geometry"), crs='ESRI:102001', keepgeom=F)

  buffer10<-readRDS(system.file('extdata','buffer10_list.rds',package='swim'))
  buffer10<-terra::vect(buffer10, geom=c("geometry"), crs='ESRI:102001', keepgeom=F)

  buffer30<-readRDS(system.file('extdata','buffer30_list.rds',package='swim'))
  buffer30<-terra::vect(buffer30, geom=c("geometry"), crs='ESRI:102001', keepgeom=F)

  buffer50<-readRDS(system.file('extdata','buffer50_list.rds',package='swim'))
  buffer50<-terra::vect(buffer50, geom=c("geometry"), crs='ESRI:102001', keepgeom=F)

  my.list<-list(naf4t,spatial.grid,buffer10,buffer30,buffer50)
  names(my.list)=c('naf4t','spatial.grid','buffer10','buffer30','buffer50')
  #return(do.call(rbind,my.list))
  #return(vect(my.list))
  return(my.list)

  }

  }
