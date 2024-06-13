model4 <- function(folderPathToPyinFiles, praatData, outputFolder) {
  
  # Specify the path to the directory you want to create
  model4_subfolder <- paste(outputFolder, 'model 4', sep = "/")
  model4_path <- paste(model4_subfolder, 'model4_pyin_data.xlsx', sep = '/' )
  
  # Check if the directory already exists
  if (!dir.exists(model4_subfolder)) {
    # If it doesn't exist, create the directory
    dir.create(model4_subfolder, recursive = TRUE)
    cat("Directory created:", model4_subfolder, "\n")
  } else {
    cat("Directory already exists:", model4_subfolder, "\n")
  }
  
  #read pyin data
  model4_pyin <- readAllFiles(folderPathToPyinFiles, model4_path, readAndProcessDataWithAverageMinConsecutiveDifference, header)
  
  
  
  correlations <- runCorrelations(model4_pyin, praatData)
  
  model4_correlations_path <- paste(model4_subfolder, 'model4_correlations.xlsx', sep = '/' )
  
  #write.xlsx(correlations, model3_correlations_path, row.names = FALSE)
  
  
  
  #WRITE THE correlations to file
  #give the sheet a name
  createNewSheet(model4_correlations_path, 'pyin vs praat (120 Notes)', correlations)
  
  #write 60 notes
  addNewSheet(model4_correlations_path, 'pyin vs praat (60 Notes)', runCorrelations(compress120Notes(model4_pyin), compress120Notes(praatData)))
  
  
  #write pyin vs ground truth
  addNewSheet(model4_correlations_path, 'pyin vs ground', runGroundTruthPyinCorrelations(model4_pyin, correctFrequencies))
  
  
  #write praat vs ground truth
  addNewSheet(model4_correlations_path, 'praat vs ground', runGroundTruthPraatCorrelations(model4_pyin, praatData, correctFrequencies))
  
  
  #give the sheet a name
  createNewSheet(model4_path, '120 Notes', model4_pyin)
  
  
  #write 60 notes
  addNewSheet(model4_path, '60 Notes', compress120Notes(model4_pyin))
}