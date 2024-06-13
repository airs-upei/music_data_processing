library(xlsx)

library(writexl)
library(tidyverse)

readAllFiles <- function(filesFolder, outputFileName, func, headerName) {
  
  #write_file <- "/Users/mcfrancho/2022MusicResearchWork/Pyin_analyser/analysed_MAST21_notes_semitones_with_weight_dur.xlsx"
  
  #write_file <- "/Users/mcfrancho/2022MusicResearchWork/Pyin_analyser/analysed_data_1.xlsx"
  write_file <- outputFileName
  #write_file <- "/Users/mcfrancho/2022MusicResearchWork/Pyin_analyser/new_pyin_semitones.xlsx"
  
  filesList <- list.dirs(filesFolder)
  
  #filesList <- list.dirs("/Users/mcfrancho/2022MusicResearchWork/compiled_files")
  
  files <- unlist(lapply(filesList, list.files, pattern = "rds", full.names = TRUE))
  #processedDataFrame <- createErrorsHeader(expected_notes)
  processedDataFrame <- createHeader(headerName)
  #processedDataFrame <- createHeader(header)
  
  
  
  
  for(file in files) {
    rdsList <- readRDS(file)
    #vector <- readAndProcessDataWithWeightedDurations(rdsList)
    #vector <- calculateErrorsWithMissingValues(rdsList)
    # vector <- readAndProcessData(rdsList)
    vector <- func(rdsList)
    #vector <- readAndProcessDataWithAverageMinConsecutiveDifference(rdsList)
    supplemental_data_frame <- data.frame(t(vector));
    colnames(supplemental_data_frame) <- headerName;
    #colnames(supplemental_data_frame) <- header;
    
    #colnames(supplemental_data_frame) <- expected_notes;
    
    
    #rbind means row bind, pass in two data.frame
    processedDataFrame <- rbind(processedDataFrame, supplemental_data_frame);
    
    
  }
  
  #comment this line if there is no conversion from midi to frequency
  #
  #processedDataFrame <- conversions(processedDataFrame, convertMidiToFrequency)
  
  #convert from frequency to semitone
  #processedDataFrame <- conversions(processedDataFrame, convertFrequencyToSemitone)
  
  #Convert the participant ids to lowercase
  processedDataFrame$p_id <- tolower(processedDataFrame$p_id)
  
  #Reorder the p_id to match a target order
  #e.g df <- data.frame(name=letters[1:4], value=c(rep(TRUE, 2), rep(FALSE, 2)))
  #target <- c("b", "c", "a", "d")
  #df[match(target, df$name),]
  processedDataFrame[match(processedDataFrame, compiled_pyin_original$p_id),]
  
  #write the result to excel
  write_xlsx(processedDataFrame, write_file)
  
  return (processedDataFrame);
}
