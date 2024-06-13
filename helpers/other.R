library(xlsx)

library(writexl)
library(tidyverse)


edit_dist <- function(s, t, toSingleChars) {
  
  if(toSingleChars) {
    s <- intToUtf8(s)
    t <- intToUtf8(t)
  }
  
  adist(s,t)
}


#used to create the same cells from pyin sheet 
joinPraatData <- function(pyin, praat) {
  header <- colnames(pyin)
  processedDataFrame <- data.frame(
    matrix(ncol = 61, nrow = 0)
  )
  
  colnames(processedDataFrame) <- header
  for(row in 1:nrow(pyin)) {
    vec <- c()
    
    for(col in 1:ncol(pyin)) {
      if(is.na(pyin[row, col]) ) {
        vec <- c(vec, NA)
      }
      else {
        # if(is.na(praat[row, col])) {
        #if there is no daa, use a doo
        #vec <- c(vec, unlist(praat[row, col + 60]))
        #}
        # else {
        vec <- c(vec, unlist(praat[row, col]))
        # }
      }
    }
    
    supplemental_data_frame <- data.frame(t(vec));
    colnames(supplemental_data_frame) <- colnames(pyin);
    #colnames(supplemental_data_frame) <- expected_notes;
    
    
    #rbind means row bind, pass in two data.frame
    processedDataFrame <- rbind(processedDataFrame, supplemental_data_frame);
  }
  
  return(processedDataFrame)
}



getNumberOfNotes <- function(rdsList) {
  id <- rdsList$session$p_id
  if(id == 'joh11tav') {
    id <- 'cha20nib'
  }
  melodyVector <-  c(tolower(id))
  count <- 0
  mastCount <- 1
  daaCount <- 0
  dooCount <- 0
  
  for (melody in rdsList$MAST21) {
    
    if(grepl("daa",names(rdsList$MAST21)[mastCount], fixed = TRUE) && daaCount < 20) {
      daaCount <- daaCount + 1
      if(!is.na(melody$pyin_res$freq)) {
        count <- count + length(melody$pyin_res$freq)
      }
    }
    mastCount <- mastCount + 1
    
  }
  
  mastCount <- 1
  for (melody in rdsList$MAST21) {
    if(grepl("doo", names(rdsList$MAST21)[mastCount], fixed = TRUE) && dooCount < 20) {
      dooCount <- dooCount + 1
      
      if(!is.na(melody$pyin_res$freq)) {
        count <- count + length(melody$pyin_res$freq)
      }
      
    }
    mastCount <- mastCount + 1
  }
  
  melodyVector <- c(melodyVector, count)
  return(melodyVector);
}



calculateVariability <-  function(dataframe, vector) {
  
  newDataframe <- dataframe[-vector, ]
  randomData <- newDataframe[sample(nrow(newDataframe), 6), ]
  header <-  c('Random', 'Selected 6')
  
  df <- data.frame(matrix(ncol = 2))
  colnames(df) <- header
  vectorData <- dataframe[vector,]
  for(i in 1:nrow(randomData)) {
    randomSemitones <- convertListToSemitone(as.numeric(unlist(randomData[i, -1])))
    vectorSemitones <- convertListToSemitone(as.numeric(vectorData[i, -1]))
    df <- rbind(df, c(sd(randomSemitones, na.rm=TRUE), sd(vectorSemitones, na.rm=TRUE)))
    #df[nrow(df) + 1,] <- c(mean(randomSemitones, na.rm=TRUE), mean(vectorSemitones, na.rm=TRUE))
  }
  return(df)
}



##This function checks the notes groups that pYIN predicts the right number of notes
calculateErrors <- function(rdsList) {
  expected <- c(1,1,1,1,2,2,2,2,3,3,3,3,5,5,5,5,4,3,6,3)
  
  
  errors_tracker <-  c(rdsList$session$p_id)
  daaCount <- 0
  
  if(rdsList$session$p_id == 'joh11tav') {
    errors_tracker <-  c('cha20nib')
  }
  else {
    errors_tracker <-  c(rdsList$session$p_id)
  }
  
  #daa
  #petsta has a different format
  if(!is.null(rdsList$MAST21)) {
    count <- 1
    for (melody in rdsList$MAST21) {
      
      if(daaCount < 20) {
        if(grepl("daa",names(rdsList$MAST21)[count], fixed = TRUE)) {
          daaCount <- daaCount + 1
          notes <- melody$pyin_res$freq
          duration <- melody$pyin_res$dur
          
          
          
          #1 note expected
          if(daaCount <= 4) {
            if(!is.na(notes) && length(notes) == 1) {
              
              # melodyVector <- c(melodyVector, processData(1, notes))
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            else {
              errors_tracker <- c(errors_tracker, 0)
              
            }
            
          }
          
          #two notes expected
          else if(daaCount == 5 | daaCount == 6 | daaCount == 7 | daaCount == 8) {
            if(!is.na(notes) && length(notes) == 2) {
              
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
            
          }
          
          #3 notes expected
          else if(daaCount == 9 | daaCount == 10 | daaCount == 11 | daaCount == 12) {
            if(!is.na(notes) && length(notes) == 3) {
              errors_tracker <- c(errors_tracker, 1)
              
              
            }
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
          }
          
          #5 notes expected
          else if(daaCount == 13 | daaCount == 14 | daaCount == 15 | daaCount == 16) {
            if(!is.na(notes) && length(notes) == 5) {
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
            
          }
          
          #4 notes expected
          else if(daaCount == 17) {
            if(!is.na(notes) && length(notes) == 4) {
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
          }
          
          #3 notes expected
          else if(daaCount == 18) {
            if(!is.na(notes) && length(notes) == 3) {
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
          }
          
          #6 notes expected
          else if(daaCount == 19) {
            if(!is.na(notes) && length(notes) == 6) {
              errors_tracker <- c(errors_tracker, 1)
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
          }
          
          #3 notes expected
          else if(daaCount == 20) {
            if(!is.na(notes) && length(notes) == 3) {
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
          }
        }
      }
      
      
      count <- count + 1
      
    }
    
    if(length(errors_tracker) < 21) {
      errors_tracker <- c(errors_tracker, rep(0, 21 - length(errors_tracker)))
    }
    
  }
  
  else {
    errors_tracker <- c(errors_tracker, rep(0, 20))
  }
  
  return(errors_tracker);
  
}


#Enter the Na for the ones that do not have data, adding 0's and 1's
calculateErrorsWithMissingValues <- function(rdsList) {
  expected <- c(1,1,1,1,2,2,2,2,3,3,3,3,5,5,5,5,4,3,6,3)
  
  
  errors_tracker <-  c(rdsList$session$p_id)
  daaCount <- 0
  
  if(rdsList$session$p_id == 'joh11tav') {
    errors_tracker <-  c('cha20nib')
  }
  else {
    errors_tracker <-  c(rdsList$session$p_id)
  }
  
  #daa
  #petsta has a different format
  if(!is.null(rdsList$MAST21)) {
    count <- 1
    for (melody in rdsList$MAST21) {
      
      if(daaCount < 20) {
        if(grepl("daa",names(rdsList$MAST21)[count], fixed = TRUE)) {
          daaCount <- daaCount + 1
          notes <- melody$pyin_res$freq
          duration <- melody$pyin_res$dur
          
          
          
          #1 note expected
          if(daaCount <= 4) {
            
            if(anyNA(notes)) {
              
              errors_tracker <- c(errors_tracker, NA)
            }
            
            else if(!is.na(notes) && length(notes) == 1) {
              
              # melodyVector <- c(melodyVector, processData(1, notes))
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            else {
              errors_tracker <- c(errors_tracker, 0)
              
            }
            
          }
          
          #two notes expected
          else if(daaCount == 5 | daaCount == 6 | daaCount == 7 | daaCount == 8) {
            
            if(anyNA(notes)) {
              errors_tracker <- c(errors_tracker, NA)
            }
            
            else if(!is.na(notes) && length(notes) == 2) {
              
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
            
          }
          
          #3 notes expected
          else if(daaCount == 9 | daaCount == 10 | daaCount == 11 | daaCount == 12) {
            
            if(anyNA(notes)) {
              errors_tracker <- c(errors_tracker, NA)
            }
            
            else if(!is.na(notes) && length(notes) == 3) {
              errors_tracker <- c(errors_tracker, 1)
            }
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
          }
          
          #5 notes expected
          else if(daaCount == 13 | daaCount == 14 | daaCount == 15 | daaCount == 16) {
            
            if(anyNA(notes)) {
              errors_tracker <- c(errors_tracker, NA)
            }
            
            else if(!is.na(notes) && length(notes) == 5) {
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
            
          }
          
          #4 notes expected
          else if(daaCount == 17) {
            if(anyNA(notes)) {
              errors_tracker <- c(errors_tracker, NA)
            }
            
            else if(!is.na(notes) && length(notes) == 4) {
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
          }
          
          #3 notes expected
          else if(daaCount == 18) {
            
            if(anyNA(notes)) {
              errors_tracker <- c(errors_tracker, NA)
            }
            
            else if(!is.na(notes) && length(notes) == 3) {
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
          }
          
          #6 notes expected
          else if(daaCount == 19) {
            if(anyNA(notes)) {
              errors_tracker <- c(errors_tracker, NA)
            }
            
            else if(!is.na(notes) && length(notes) == 6) {
              errors_tracker <- c(errors_tracker, 1)
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
          }
          
          #3 notes expected
          else if(daaCount == 20) {
            if(anyNA(notes)) {
              errors_tracker <- c(errors_tracker, NA)
            }
            
            else if(!is.na(notes) && length(notes) == 3) {
              errors_tracker <- c(errors_tracker, 1)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, 0)
            }
          }
        }
      }
      
      count <- count + 1
      
    }
    
    if(length(errors_tracker) < 21) {
      errors_tracker <- c(errors_tracker, rep(NA, 21 - length(errors_tracker)))
    }
    
  }
  
  else {
    errors_tracker <- c(errors_tracker, rep(NA, 20))
  }
  
  return(errors_tracker);
  
}


fillInVAluesWithOriginal <- function(correct_tests) {
  expected <- c(1,1,1,1,2,2,2,2,3,3,3,3,5,5,5,5,4,3,6,3)
  
  expected_notes <- c('p_id',
                      "Mast_1",
                      "Mast_2",
                      "Mast_3",
                      "Mast_4",
                      "Mast_5",
                      "Mast_6",
                      "Mast_7",
                      "Mast_8",
                      "Mast_9",
                      "Mast_10",
                      "Mast_11",
                      "Mast_12",
                      "Mast_13",
                      "Mast_14",
                      "Mast_15",
                      "Mast_16",
                      "Mast_17",
                      "Mast_18",
                      "Mast_19",
                      "Mast_20")
  
  
  #frame <- data.frame(matrix(nrow = 15, ncol = 21, byrow = TRUE))  
  frame <- createErrorsHeader(expected_notes)
  
  
  
  #Change to the number of rows expected
  for (row in 1:30) {
    vector <- unlist(correct_tests[row, 1])
    for(column in 2:21) {
      data_x <- unlist(correct_tests[row, column])
      
      if(is.na(data_x)) {
        vector <- c(vector, NA)
      }
      
      else if(data_x == 1) {
        vector <- c(vector, expected[column -1])
        
      }
      else {
        vector <- c(vector, NA)
      }
    }
    
    supplemental_data_frame <- data.frame(t(vector))
    colnames(supplemental_data_frame) <- expected_notes
    
    
    #rbind means row bind, pass in two data.frame
    frame <- rbind(frame, supplemental_data_frame)
    
  }
  write_file <- "/Users/mcfrancho/2022MusicResearchWork/Pyin_analyser/compiled_pyin_original.xlsx"
  
  
  #filesList <- list.dirs("/Users/mcfrancho/2022MusicResearchWork/seniors_rds_files")
  write_xlsx(frame, write_file)
  
  return(frame)
  
}

