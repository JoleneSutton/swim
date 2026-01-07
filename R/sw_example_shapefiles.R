#' Get the example shapefiles
#'
#' Imports a stored shapefile as a SpatVector (terra).
#' @param save.files If TRUE, a folder with the downloaded files will be saved to the working directory. Default is TRUE.
#' @importFrom zen4R ZenodoManager
#' @importFrom terra vect writeVector
#' @importFrom utils download.file
#' @return Returns example shapfiles (class SpatVector)
#' sw_example_shapefiles()
#' ls()
#' @export
sw_example_shapefiles<-function(save.files=TRUE){

  message("Fetching SWIM example shapefiles from https://zenodo.org/records/18165445.")

  record_id <- 18165445  #Zenodo record ID

  output_dir <- "zenodo_downloads"  # Local folder to save files
  # Create output directory if it doesn't exist
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }

  # Create Zenodo API manager (no token needed for public records)
  zen <- zen4R::ZenodoManager$new()

  # Get record metadata
  record <- zen$getRecordById(record_id)

  if (is.null(record$files) || length(record$files) == 0) {
    stop("No files found in this Zenodo record.")
  }

  cat("Found", length(record$files), "files in zenodo record", record_id, "\n")

  for(i in 1:length(record$files)){
    file_path <- file.path(record$files[[i]][4])
    utils::download.file(file_path, destfile = paste0(output_dir,'/',record$files[[i]][1]), mode = "wb", quiet = TRUE)
  }

  my_objects <- list()
  for(i in 1:length(record$files)){
    ob.name<-record$files[[i]][1]
    ob.name<-gsub("_list.rds","",ob.name)
    ob<-readRDS(paste0('zenodo_downloads/',record$files[[i]][1]))
    ob<-terra::vect(ob, geom=c("geometry"), crs='ESRI:102001', keepgeom=F)
    my_objects[[i]]<-ob
    names(my_objects)[[i]]<-ob.name
  }
  list2env(my_objects, envir = .GlobalEnv)


  if(isTRUE(save.files)){
    for(i in 1:length(my_objects)){
      terra::writeVector(my_objects[[i]],filename=paste0('zenodo_downloads/',names(my_objects)[[i]],'.shp'))
    }
  }


  if(save.files!=TRUE){unlink(output_dir, recursive = TRUE)}

  rm(file_path,i,ob,ob.name,output_dir,record,record_id,zen,my_objects)

}
