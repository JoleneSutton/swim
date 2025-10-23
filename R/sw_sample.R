#' Swim Sample
#'
#' Sample spatial grid cells and distribute events according to grid cell sample weights
#' @param length The number of events
#' @param wghts Data frame with two columns. The first column is the identity of the grid cell. The second column is the associated sampling weight. If choosing option=3, the column of sampling weights is ignored.
#' @param option Either 1, 2, or 3. Default is 1. Option 1 uses weighted random assignment to distribute events over grid cells. This option returns grid cell identities. Option 2 distributes events over all grid cells proportionally according to the sampling weights. Option 3 distributes events evenly over all available grid cells, ignoring sampling weights.
#' @export
sw_sample<-function(length,wghts,option=1){

  # appease R CMD check
  weight=NULL

  #/////////////////////////////////////////
  # Option 1: weighted random sample
  if(option==1){
  message("Returning grid cell identities resulting from weighted random sampling")
  SAMPLE<-wghts[sample(1:nrow(wghts),
                       length,
                       replace=TRUE,
                       prob=c(wghts[,2])), 1]
  return(SAMPLE)
  }

  #/////////////////////////////////////////
  # Option 2: distribute proportionally
  if(option==2){
    message("Returning data frame of the sampling weight, the number of associated spatial grid cells, and the number of events per grid cell")

    # number of records to assign per group
    records=(length*unique(wghts[,2])/sum(length*unique(wghts[,2])) * length)

    #number of cells to distribute over per group
    cells<-wghts|>
      dplyr::group_by(factor(weight))|>
      dplyr::summarize(count=dplyr::n())#|>mutate(proportion = count / sum(count))
      #cells

    # num records / number cells
    out=cbind(cells,rev(records)/cells$count)
    names(out)<-c('weight','cells','n.per.cell')
    #out
    #sum(out$n.per.cell*out$cells)
    return(out)
  }

  #/////////////////////////////////////////
  # Option 3: Distribute evenly (ignore sampling weights)
  if(option==3){
    message("Returning data frame of number grid cells and the number of events per grid cell")
    out<-(cbind.data.frame(nrow(wghts),length/nrow(wghts)))
    names(out)<-c('cells','n.per.cell')
    return(out)
  }

}



