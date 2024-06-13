library("openxlsx")


#param - dataframe of pyin and praat values with the p_id as the first column
runCorrelations <- function(pyinDataframe, praatDataframe) {
  
  #correlations
  cor_test_results <- data.frame(
    p_id = character(),
    correlation_coefficient = numeric(),
    p_value = numeric(),
    confidence_interval_lower = numeric(),
    confidence_interval_upper = numeric(),
    stringsAsFactors = FALSE
  )
  
  
  for(row in 1: nrow(pyinDataframe)) {
    matching_rows <- subset(praatDataframe, p_id == unlist(pyinDataframe[row, 1]))
    pyin <- as.numeric(unlist(pyinDataframe[row, -1]))
    praat <- as.numeric(unlist(matching_rows[1, -1]))
    
    pyin <- ifelse(pyin == 9999, NA, pyin)
    praat <- ifelse(praat == 9999, NA, praat)
    
    
    non_na_length <- sum(!is.na(pyin))
    
    
    if (non_na_length > 3) {
      cor_res <- cor.test(pyin, praat)
      
      
      # Extract relevant information
      correlation_coefficient <- unname(cor_res$estimate) 
      p_value <- cor_res$p.value
      confidence_interval <- cor_res$conf.int
      
      
      result_v <- data.frame(
        p_id = unlist(pyinDataframe[row, 1]),
        correlation_coefficient = correlation_coefficient,
        p_value = p_value,
        confidence_interval_lower = confidence_interval[1],
        confidence_interval_upper = confidence_interval[2],
        stringsAsFactors = FALSE
      )
      
      cor_test_results <- rbind(cor_test_results, result_v)
      
    }
    
  }
  
  return (cor_test_results);
  
}



runGroundTruthPyinCorrelations <- function(dataFrame, correct) {
  
  #correlations
  cor_test_results <- data.frame(
    p_id = character(),
    correlation_coefficient = numeric(),
    p_value = numeric(),
    confidence_interval_lower = numeric(),
    confidence_interval_upper = numeric(),
    stringsAsFactors = FALSE
  )
  
  
  
  for(row in 1: nrow(dataFrame)) {
    data <- as.numeric(unlist(dataFrame[row, -1]))
    ground <- as.numeric(unlist(correct[2, -1]))
    
    data <- ifelse(data == 9999, NA, data)
    ground <- ifelse(ground == 9999, NA, ground)
    
    
    non_na_length <- sum(!is.na(data))
    
    
    if (non_na_length > 3) {
      
      cor_res <- cor.test(data, ground)
      
      # Extract relevant information
      correlation_coefficient <- unname(cor_res$estimate) 
      p_value <- cor_res$p.value
      confidence_interval <- cor_res$conf.int
      
      
      result_v <- data.frame(
        p_id = unlist(dataFrame[row, 1]),
        correlation_coefficient = correlation_coefficient,
        p_value = p_value,
        confidence_interval_lower = confidence_interval[1],
        confidence_interval_upper = confidence_interval[2],
        stringsAsFactors = FALSE
      )
      
      cor_test_results <- rbind(cor_test_results, result_v)
      
    }
  }
  
  return (cor_test_results);
  
}


runGroundTruthPraatCorrelations <- function(pyinDataFrame, praatDataFrame, correct) {
  
  #correlations
  cor_test_results <- data.frame(
    p_id = character(),
    correlation_coefficient = numeric(),
    p_value = numeric(),
    confidence_interval_lower = numeric(),
    confidence_interval_upper = numeric(),
    stringsAsFactors = FALSE
  )
  
  # print("praat")
  # print(praatDataFrame)
  
  for(row in 1: nrow(pyinDataFrame)) {
    matching_rows <- subset(praatDataFrame, p_id == unlist(pyinDataFrame[row, 1]))
    data <- as.numeric(unlist(matching_rows[1, -1]))
    ground <- as.numeric(unlist(correct[2, -1]))
    
    data <- ifelse(data == 9999, NA, data)
    ground <- ifelse(ground == 9999, NA, ground)
    
    
    non_na_length <- sum(!is.na(data))
    
    
    if (non_na_length >= 3) {
      
      print(matching_rows)
      # print(pyinDataFrame[row, 1])
      # print(data)
      cor_res <- cor.test(data, ground)
      
      # Extract relevant information
      correlation_coefficient <- unname(cor_res$estimate) 
      p_value <- cor_res$p.value
      confidence_interval <- cor_res$conf.int
      
      
      result_v <- data.frame(
        p_id = unlist(pyinDataFrame[row, 1]),
        correlation_coefficient = correlation_coefficient,
        p_value = p_value,
        confidence_interval_lower = confidence_interval[1],
        confidence_interval_upper = confidence_interval[2],
        stringsAsFactors = FALSE
      )
      
      cor_test_results <- rbind(cor_test_results, result_v)
    }
  }
  
  return (cor_test_results);
  
}
