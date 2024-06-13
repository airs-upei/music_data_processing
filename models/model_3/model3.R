model3 <- function(folderPathToPyinFiles, praatData, outputFolder) {
  
  # Specify the path to the directory you want to create
  model3_subfolder <- paste(outputFolder, 'model 3', sep = "/")
  model3_path <- paste(model3_subfolder, 'model3_pyin_data.xlsx', sep = '/' )
  
  # Check if the directory already exists
  if (!dir.exists(model3_subfolder)) {
    # If it doesn't exist, create the directory
    dir.create(model3_subfolder, recursive = TRUE)
    cat("Directory created:", model3_subfolder, "\n")
  } 
  else {
    cat("Directory already exists:", model3_subfolder, "\n")
  }
  
  #read pyin data
  model3_pyin <- readAllFiles(folderPathToPyinFiles, model3_path, readAndProcessDataModel3Modified, header)
  
  
  
  correlations <- runCorrelations(model3_pyin, praatData)
  
  # Combine the first column with the vector to create a new dataframe
  # correlatonsD <- data.frame(p_id = model1_pyin[, 1], Correlations = correlations)
  
  model3_correlations_path <- paste(model3_subfolder, 'model3_correlations.xlsx', sep = '/' )
  
  #write.xlsx(correlations, model3_correlations_path, row.names = FALSE)
  
  
  
  #WRITE THE correlations to file
  #give the sheet a name
  createNewSheet(model3_correlations_path, 'pyin vs praat (120 Notes)', correlations)
  
  #write 60 notes
  addNewSheet(model3_correlations_path, 'pyin vs praat (60 Notes)', runCorrelations(compress120Notes(model3_pyin), compress120Notes(praatData)))
  
  #write pyin vs ground truth
  addNewSheet(model3_correlations_path, 'pyin vs ground', runGroundTruthPyinCorrelations(model3_pyin, correctFrequencies))
  
  
  #write praat vs ground truth
  addNewSheet(model3_correlations_path, 'praat vs ground', runGroundTruthPraatCorrelations(model3_pyin, praatData, correctFrequencies))
  
  
  
  #give the sheet a name
  createNewSheet(model3_path, '120 Notes', model3_pyin)
  
  
  #write 60 notes
  addNewSheet(model3_path, '60 Notes', compress120Notes(model3_pyin))
}