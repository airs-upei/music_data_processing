#compress 120 notes to 60 notes 

#param - dataframe containing 120 notes
#You must enter the full dataframe with the ids as a parameter. DO NOT subset the Dataframe when passing as a param
compress120Notes <- function(notes_dataframe) {
  
  new_frame = data.frame(
    matrix(ncol = 61, nrow = 0)
  )
  colnames(new_frame) <- daaHeader;
  
  
  for(row in 1: nrow(notes_dataframe)) {
    data_row <- as.numeric(unlist(notes_dataframe[row, -1]))
    data_row <- ifelse(data_row == 9999, NA, data_row)
    data_row_60 = get60Notes(data_row)
    
    supplemental_data_frame <- data.frame(t(c(unlist(notes_dataframe[row, 1]), as.numeric(data_row_60))));
    colnames(supplemental_data_frame) <- colnames(new_frame);
    new_frame <- rbind(new_frame, supplemental_data_frame);
  }
  
  new_frame[colnames(new_frame)[-1]]  <- sapply(new_frame[colnames(new_frame)[-1]], as.numeric)
  return (new_frame)
}

#helper function for the compress120Notes function
get60Notes <- function(vector) {
  newV = c()
  for(note in 1:60) {
    daa <- vector[note]
    doo <- vector[note + 60]
    
    if(is.na(daa) && is.na(doo)) {
      newV = c(newV, NA)
    }
    else if(!is.na(daa) && !is.na(doo)) {
      newV = c(newV, (daa + doo) / 2)
    }
    
    else if(!is.na(daa) && is.na(doo)) {
      newV = c(newV, daa)
    }
    
    else if(is.na(daa) && !is.na(doo)) {
      newV = c(newV, doo)
    }
  }
  return (newV)
}