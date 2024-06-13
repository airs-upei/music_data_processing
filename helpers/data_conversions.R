convertListToSemitone <- function(list) {
  newVector <- c()
  for( i in 1:length(list)) {
    newVector <- c(newVector, convertFrequencyToSemitone(list[i]))
  }
  
  return( newVector);
}

conversions <- function(dataFrame, conversionFunction) {
  #convert only the numbers the numeric 
  data_num <- as.data.frame(apply(dataFrame[, -1], 2, as.numeric))  # Convert all variable types to numeric
  sapply(data_num, class) 
  
  #apply the function to only the numeric values, change the functions here
  data_num <- lapply(data_num, conversionFunction)
  
  
  
  #append the first column to our result
  dataFrame <- data.frame(dataFrame[,1], as.data.frame(data_num))
  
  #noticed that the first column was renamed, changed it back to p_id here
  names(dataFrame)[names(dataFrame) == 'dataFrame...1.'] <- 'p_id'
  
  return(dataFrame);
  
}

convertMidiToFrequency <- function(x) {
  ifelse(x == 9999, 9999, round(((2^((x-60)/12)) * 261.3), digits = 5))
  
}



convertFrequencyToSemitone <- function(fn) {
  ifelse(fn == 9999, 9999, round(((log2(fn/261.3)) * 12.0), digits = 5))
}

convertDataSet <-  function(data, functionName) {
  newData <- data.frame(lapply(as.numeric(data), functionName))
  
  colnames(newData) <- colnames(data)
  return(newData);
}
