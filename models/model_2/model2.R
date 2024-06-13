model2 <- function(folderPathToPyinFiles, praatData, outputFolder) {
  
  # Specify the path to the directory you want to create
  model2_subfolder <- paste(outputFolder, 'model 2', sep = "/")
  model2_path <- paste(model2_subfolder, 'model2_pyin_data.xlsx', sep = '/' )
  
  
  # Check if the directory already exists
  if (!dir.exists(model2_subfolder)) {
    # If it doesn't exist, create the directory
    dir.create(model2_subfolder, recursive = TRUE)
    cat("Directory created:", model2_subfolder, "\n")
  } else {
    cat("Directory already exists:", model2_subfolder, "\n")
  }
  
  #read pyin data -2A
  # model2_pyin <- readAllFiles(folderPathToPyinFiles, model2_path, readAndProcessDataWithDuration, header, )
  
  #2B
  #model2_pyin <- readAllFiles(folderPathToPyinFiles, model2_path, readAndProcessDataWithDurationReorder, header)
  
  #2C
  model2_pyin <- readAllFiles(folderPathToPyinFiles, model2_path, readAndProcessDataWithDurationShortAveraged_1, header)
  
  
  
  correlations <- runCorrelations(model2_pyin, praatData)
  
  # Combine the first column with the vector to create a new dataframe
  # correlatonsD <- data.frame(p_id = model1_pyin[, 1], Correlations = correlations)
  
  #write.xlsx(correlations, paste(model2_subfolder, 'model2daa_correlations.xlsx', sep = '/' ), row.names = FALSE)
  
  
  model2_correlations_path <- paste(model2_subfolder, 'model2_correlations.xlsx', sep = '/' )
  
  
  #WRITE THE correlations to file
  #give the sheet a name
  createNewSheet(model2_correlations_path, 'pyin vs praat (120 Notes)', correlations)
  
  #write 60 notes
  addNewSheet(model2_correlations_path, 'pyin vs praat (60 Notes)', runCorrelations(compress120Notes(model2_pyin), compress120Notes(praatData)))
  
  
  #write pyin vs ground truth
  addNewSheet(model2_correlations_path, 'pyin vs ground', runGroundTruthPyinCorrelations(model2_pyin, correctFrequencies))
  
  
  #write praat vs ground truth
  addNewSheet(model2_correlations_path, 'praat vs ground', runGroundTruthPraatCorrelations(model2_pyin, praatData, correctFrequencies))
  
  
  #give the sheet a name
  createNewSheet(model2_path, '120 Notes', model2_pyin)
  
  
  #write 60 notes
  addNewSheet(model2_path, '60 Notes', compress120Notes(model2_pyin))
}