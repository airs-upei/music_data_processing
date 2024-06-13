modelR <- function(folderPathToPyinFiles, praatData, outputFolder) {
  
  # Specify the path to the directory you want to create
  modelR_subfolder <- paste(outputFolder, 'model R', sep = "/")
  modelR_path <- paste(modelR_subfolder, 'modelR_data.xlsx', sep = '/' )
  
  # Check if the directory already exists
  if (!dir.exists(modelR_subfolder)) {
    # If it doesn't exist, create the directory
    dir.create(modelR_subfolder, recursive = TRUE)
    cat("Directory created:", modelR_subfolder, "\n")
  } else {
    cat("Directory already exists:", modelR_subfolder, "\n")
  }
  
  #read pyin data
  #used to get the n rows
  modelR_pyin_temp <- readAllFiles(folderPathToPyinFiles, modelR_path, readAndProcessDataWithRandomNotes, header)
  
  
  num_random =1
  temp_data_frame = data.frame(matrix(nrow = nrow(praatData)))
  modelR_pyin = data.frame(matrix(0, nrow = nrow(praatData), ncol = 121))
  colnames(modelR_pyin) = colnames(praatData)
  
  temp_data_frame[, 1] = praatData[, 1]
  modelR_pyin[, 1] = praatData[, 1]
  
  
  modelR_pyin_60 = data.frame(matrix(0, nrow = nrow(praatData), ncol = 61))
  colnames(modelR_pyin_60) = daaHeader
  modelR_pyin_60[, 1] = praatData[, 1]
  
  for (i in 1:num_random) {
    modelR_pyin_temp <- readAllFiles(folderPathToPyinFiles, modelR_path, readAndProcessDataWithRandomNotes, header)
    
    for (col in names(modelR_pyin_temp)[-1]) {
      modelR_pyin_temp[[col]] <- as.numeric(modelR_pyin_temp[[col]]) 
      # temp_data_frame[[col]] <- as.numeric(temp_data_frame[[col]])
    }
    
    
    modelR_pyin[, -1] = modelR_pyin[, -1] + modelR_pyin_temp[, -1]
    
    modelR_pyin_60[, -1] = modelR_pyin_60[, -1] + compress120Notes(modelR_pyin_temp)[, - 1]
    
    
    # cor_res <- runCorr(modelR_pyin_temp, praatData)
    
    # temp_data_frame <- cbind(temp_data_frame, cor_res)
    
  }
  
  #120 notes correlation
  modelR_pyin[, -1] = modelR_pyin[, -1] / num_random
  correlations <- runCorrelations(modelR_pyin, praatData)
  
  
  #60 notes
  modelR_pyin_60[, -1] = modelR_pyin_60[, -1] / num_random
  correlations_60 <- runCorrelations(modelR_pyin_60, compress120Notes(praatData))
  
  # cor_file_rand_2 <- '/Users/mcfrancho/2022MusicResearchWork/Pyin_analyser/pyin_april2023_model_r.xlsx'
  # write_xlsx(pyin_april2023_model_r, cor_file_rand_2)
  
  modelR_correlations_path <- paste(modelR_subfolder, 'modelR_correlations.xlsx', sep = '/' )
  
  
  #WRITE THE correlations to file
  #give the sheet a name
  createNewSheet(modelR_correlations_path, '120 Notes', correlations)
  
  #write 60 notes
  addNewSheet(modelR_correlations_path, '60 Notes', correlations_60)
  
  
  
  #give the sheet a name
  createNewSheet(modelR_path, '120 Notes', modelR_pyin)
  
  
  #write 60 notes
  addNewSheet(modelR_path, '60 Notes', compress120Notes(modelR_pyin))
}