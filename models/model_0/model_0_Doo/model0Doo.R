model0Doo <- function(folderPathToPyinFiles, praatData, outputFolder) {
  
  # Specify the path to the directory you want to create
  model0doo_subfolder <- paste(outputFolder, 'model 0/doo', sep = "/")
  model0_path <- paste(model0doo_subfolder, 'model0_pyin_data.xlsx', sep = '/' )
  
  # Check if the directory already exists
  if (!dir.exists(model0doo_subfolder)) {
    # If it doesn't exist, create the directory
    dir.create(model0doo_subfolder, recursive = TRUE)
    cat("Directory created:", model0doo_subfolder, "\n")
  } else {
    cat("Directory already exists:", model0doo_subfolder, "\n")
  }
  
  #read pyin data
  model0_doo_pyin_cleaned <- readAllFiles(folderPathToPyinFiles, model0_path, fillInValuesForDoo, dooHeader)
  
  #get only the doo for praat data
  praatData <- praatData[, -c(2:61)]
  
  non_empty_count <- apply(model0_doo_pyin_cleaned[, -1], 1, function(row) sum(!is.na(row), na.rm = TRUE))
  
  # Add a new column to the 2nd index of the dataframe
  model0_doo_pyin_cleaned <- cbind(p_id = model0_doo_pyin_cleaned[, 1], `Total Clean Notes Daa` = non_empty_count, model0_doo_pyin_cleaned[, -1])
  
  
  #get the corresponding praat data
  praat_april_cleaned <- data.frame(matrix(ncol = ncol(model0_doo_pyin_cleaned), nrow = 0))
  
  colnames(praat_april_cleaned) <- colnames(model0_doo_pyin_cleaned)
  
  #data.frame(matrix(nrow = nrow(pyin_april_cleaned)))
  for(pyinRow in 1:nrow(model0_doo_pyin_cleaned)) {
    
    praat_vector <- c()
    praat_vector <- c(praat_vector, unlist(model0_doo_pyin_cleaned[pyinRow, 1]))
    praat_vector <- c(praat_vector, unlist(model0_doo_pyin_cleaned[pyinRow, 2]))
    
    matching_rows <- subset(praatData, p_id == unlist(model0_doo_pyin_cleaned[pyinRow, 1]))
    
    if (length(matching_rows) != 0) {
      for(col in 3:ncol(model0_doo_pyin_cleaned)) {
        
        if(!is.na(model0_doo_pyin_cleaned[pyinRow, col])) {
          
          
          #We start from 62 so as to get the doos
          #I had to subtract 1 here because the Total Clean notes column was missing from praat_new_marg
          if(unlist(matching_rows[col-1]) == 9999) {
            praat_vector <- c(praat_vector, NA)
          }
          else {
            praat_vector <- c(praat_vector, unlist(matching_rows[col-1]))
          }
        }
        else {
          praat_vector <- c(praat_vector, NA)
        }
      }
    }
    
    # print(praat_vector)
    supplemental_data_frame <- data.frame(t(praat_vector));
    colnames(supplemental_data_frame) <- colnames(praat_april_cleaned);
    
    praat_april_cleaned <- rbind(praat_april_cleaned, supplemental_data_frame);
  }
  
  
  #correlations for 120 notes
  # cor_test_results <-  runCorrelations(model0_daa_pyin_cleaned[, -2], praat_april_cleaned[, -2])
  
  
  
  correlations <- runCorrelations(model0_doo_pyin_cleaned[, -2], praat_april_cleaned[, -2])
  
  # Combine the first column with the vector to create a new dataframe
  # correlatonsD <- data.frame(p_id = model1_pyin[, 1], Correlations = correlations)
  
  model0_correlations_path <- paste(model0doo_subfolder, 'model0_correlations.xlsx', sep = '/' )
  
  #write.xlsx(correlations, model3_correlations_path, row.names = FALSE)
  
  
  
  #WRITE THE correlations to file
  #give the sheet a name
  createNewSheet(model0_correlations_path, 'pyin vs praat (cleaned)', correlations)
  
  #write pyin vs ground truth
  addNewSheet(model0_correlations_path, 'pyin vs ground', runGroundTruthPyinCorrelations(model0_doo_pyin_cleaned[, -2], correctFrequencies[, 1:61]))
  
  
  #write praat vs ground truth
  addNewSheet(model0_correlations_path, 'praat vs ground', runGroundTruthPraatCorrelations(model0_doo_pyin_cleaned[, -2], praat_april_cleaned[, -2], correctFrequencies[, 1:61]))
  
  
  
  #give the sheet a name
  createNewSheet(model0_path, 'doo cleaned (60)', model0_doo_pyin_cleaned)
  
}