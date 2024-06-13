model1 <- function(folderPathToPyinFiles, praatData, outputFolder) {
  
  # Specify the path to the directory you want to create
  model1_subfolder <- paste(outputFolder, 'model 1', sep = "/")
  model1_path <- paste(model1_subfolder, 'model1_pyin_data.xlsx', sep = '/' )
  
  # Check if the directory already exists
  if (!dir.exists(model1_subfolder)) {
    # If it doesn't exist, create the directory
    dir.create(model1_subfolder, recursive = TRUE)
    cat("Directory created:", model1_subfolder, "\n")
  } else {
    cat("Directory already exists:", model1_subfolder, "\n")
  }
  
  #read pyin data
  model1_pyin <- readAllFiles(folderPathToPyinFiles, model1_path, readAndProcessData, header)
  
  
  
  correlations <- runCorrelations(model1_pyin, praatData)
  
  # Combine the first column with the vector to create a new dataframe
  # correlatonsD <- data.frame(p_id = model1_pyin[, 1], Correlations = correlations)
  
  model1_correlations_path <- paste(model1_subfolder, 'model1_correlations.xlsx', sep = '/' )
  
  # write.xlsx(correlations, model1_correlations_path, row.names = FALSE)
  
  
  #WRITE THE correlations to file
  #give the sheet a name
  createNewSheet(model1_correlations_path, 'pyin vs praat (120 Notes)', correlations)
  
  
  #write 60 notes
  addNewSheet(model1_correlations_path, 'pyin vs praat (60 Notes)', runCorrelations(compress120Notes(model1_pyin), compress120Notes(praatData)))
  
  
  #write pyin vs ground truth
  addNewSheet(model1_correlations_path, 'pyin vs ground', runGroundTruthPyinCorrelations(model1_pyin, correctFrequencies))
  
  
  #write praat vs ground truth
  addNewSheet(model1_correlations_path, 'praat vs ground', runGroundTruthPraatCorrelations(model1_pyin, praatData, correctFrequencies))
  
  
  #main data
  #give the sheet a name
  createNewSheet(model1_path, '120 Notes', model1_pyin)
  
  #write 60 notes
  addNewSheet(model1_path, '60 Notes', compress120Notes(model1_pyin))
  
  
  
}