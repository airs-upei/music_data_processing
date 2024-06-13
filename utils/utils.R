createHeader <- function(header) {
  participantDataFrame <- data.frame(
    matrix(ncol = length(header), nrow = 0)
  )
  
  colnames(participantDataFrame) <- header
  
  return (participantDataFrame);
}