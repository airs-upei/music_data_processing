






## Model 3 modified - Combination of model 1 and the original model 3
readAndProcessDataModel3Modified <- function(rdsList) {
  
  daaCount <- 0
  
  
  if(rdsList$session$p_id == 'joh11tav') {
    melodyVector <-  c('cha20nib')
    
  }
  else {
    melodyVector <-  c(rdsList$session$p_id)
    
  }
  
  #Used to get the correct melodies from the correct dataframes
  
  #daa
  #petsta has a different format
  if(!is.null(rdsList$MAST21)) {
    count <- 1
    
    for (melody in rdsList$MAST21) {
      
      if(daaCount < 20) {
        if(grepl("daa",names(rdsList$MAST21)[count], fixed = TRUE)) {
          daaCount <- daaCount + 1
          notes <- melody$pyin_res$freq
          durations <- melody$pyin_res$dur
          correct_vector <- c()
          voice_range <- 1
          
          if(daaCount == 1 || daaCount == 2) {
            correct_vector <- unlist(correctFrequencies[voice_range, grepl(paste("MAST.daa_", daaCount, sep = ""), colnames(correctFrequencies))])[1]
          }
          
          else {
            correct_vector <- unlist(correctFrequencies[voice_range, grepl(paste("MAST.daa_", daaCount, sep = ""), colnames(correctFrequencies))])
          }
          
          if(any(is.na(notes))) {
            notes <- c(9999)
          }
          
          
          #1 2 
          #2, 3, 4, 5
          #1 note expected
          if(daaCount <= 4) {
            
            if(length(notes) > 1) {
              
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(1, notes, durations))
              # print(correct_vector)
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
            
            #We are looking at the next iteration
            if(daaCount == 4) {
              no_notes_expected <-  2
              
            }
            
          }
          
          
          #two notes expected
          else if(daaCount == 5 | daaCount == 6 | daaCount == 7 | daaCount == 8) {
            
            if(length(notes) > 2) {
              
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(2, notes, durations))
              
              #avg <- mean(tail(notes, 2))
              # melodyVector <- c(melodyVector, c(notes[1], avg))
              
            }
            
            else if(length(notes) < 2) {
              
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 2 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
            
          }
          
          #3 notes expected
          else if(daaCount == 9 | daaCount == 10 | daaCount == 11 | daaCount == 12) {
            no_notes_expected <-  3
            
            if(length(notes) > 3) {
              
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(3, notes, durations))
              
              
            }
            
            else if(length(notes) < 3) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 3 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #5 notes expected
          else if(daaCount == 13 | daaCount == 14 | daaCount == 15 | daaCount == 16) {
            no_notes_expected <-  5
            
            if(length(notes) > 5) {
              
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(5, notes, durations))
              
              #avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:4], avg))
            }
            
            else if(length(notes) < 5) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 5 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
            
          }
          
          #4 notes expected
          else if(daaCount == 17) {
            if(length(notes) > 4) {
              no_notes_expected <-  4
              
              
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(4, notes, durations))
              
              
              #avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:3], avg))
            }
            
            else if(length(notes) < 4) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 4 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #3 notes expected
          else if(daaCount == 18) {
            no_notes_expected <-  3
            
            if(length(notes) > 3) {
              
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(3, notes, durations))
              
              
              #avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:2], avg))
              
            }
            
            else if(length(notes) < 3) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 3 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #6 notes expected
          else if(daaCount == 19) {
            no_notes_expected <-  6
            
            if(length(notes) > 6) {
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(6, notes, durations))
              
              
              # avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:5], avg))
            }
            
            else if(length(notes) < 6) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 6 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #3 notes expected
          else if(daaCount == 20) {
            no_notes_expected <-  3
            
            if(length(notes) > 3) {
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(3, notes, durations))
              
              
              #avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:2], avg))
            }
            
            else if(length(notes) < 3) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 3 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
        }
      }
      
      
      count <- count + 1
      
      
    }
    
    
    if(length(melodyVector) < 61) {
      melodyVector <- c(melodyVector, rep(9999, 61 - length(melodyVector)))
    }
    
    
  }
  
  else {
    melodyVector <- c(melodyVector, rep(9999, 60))
  }
  
  
  
  #doo
  dooCount <- 0
  
  if(!is.null(rdsList$MAST21)) {
    count <- 1
    for (melody in rdsList$MAST21) {
      
      if(dooCount < 20) {
        if(grepl("doo",names(rdsList$MAST21)[count], fixed = TRUE)) {
          notes <- melody$pyin_res$freq
          durations <- melody$pyin_res$dur
          
          dooCount <- dooCount + 1
          
          correct_vector <- c()
          
          if(dooCount == 1 || dooCount == 2) {
            correct_vector <- unlist(correctFrequencies[2, grepl(paste("MAST.doo_", dooCount, sep = ""), colnames(correctFrequencies))])[1]
          }
          
          else {
            correct_vector <- unlist(correctFrequencies[2, grepl(paste("MAST.doo_", dooCount, sep = ""), colnames(correctFrequencies))])
          }          
          
          if(any(is.na(notes))) {
            notes <- c(9999)
          }
          
          #1 note expected
          if(dooCount <= 4) {
            if(length(notes) > 1) {
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(1, notes, durations))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #two notes expected
          else if(dooCount == 5 | dooCount == 6 | dooCount == 7 | dooCount == 8) {
            
            if(length(notes) > 2) {
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(2, notes, durations))
              
              
              #avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1], avg))
              
            }
            
            else if(length(notes) < 2) {
              
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 2 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
            
          }
          
          #3 notes expected
          else if(dooCount == 9 | dooCount == 10 | dooCount == 11 | dooCount == 12) {
            if(length(notes) > 3) {
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(3, notes, durations))
              
              #  avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:2], avg))
            }
            
            else if(length(notes) < 3) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 3 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #5 notes expected
          else if(dooCount == 13 | dooCount == 14 | dooCount == 15 | dooCount == 16) {
            if(length(notes) > 5) {
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(5, notes, durations))
              
              
              # avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:4], avg))
            }
            
            else if(length(notes) < 5) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 5 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #4 notes expected
          else if(dooCount == 17) {
            if(length(notes) > 4) {
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(4, notes, durations))
              
              
              # avg <- mean(tail(notes, 2))
              # melodyVector <- c(melodyVector, c(notes[1:3], avg))
            }
            
            else if(length(notes) < 4) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 4 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #3 notes expected
          else if(dooCount == 18) {
            if(length(notes) > 3) {
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(3, notes, durations))
              
              
              #avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:2], avg))
              
            }
            
            else if(length(notes) < 3) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 3 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #6 notes expected
          else if(dooCount == 19) {
            if(length(notes) > 6) {
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(6, notes, durations))
              
              
              #avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:5], avg))
            }
            
            else if(length(notes) < 6) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 6 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #3 notes expected
          else if(dooCount == 20) {
            if(length(notes) > 3) {
              melodyVector <- c(melodyVector, processDataModifiedWeightDurations(3, notes, durations))
              
              
              #avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:2], avg))
            }
            
            else if(length(notes) < 3) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 3 - length(notes))))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
        }
      }
      
      count <- count + 1
      
    }
    
    
    if(length(melodyVector) < 121) {
      melodyVector <- c(melodyVector, rep(9999, 121 - length(melodyVector)))
    }
  }
  
  else {
    melodyVector <- c(melodyVector, rep(9999, 60))
  }
  
  return(melodyVector);
}



# Model 3 Modified - Processes data by finding the consecutive difference of notes and the wighting the durations
processDataModifiedWeightDurations <- function(numExpected, notes, notesDurations) {
  diffArray <- c(9999)
  
  if(length(notes) != numExpected) {
    
    #if(length(notes) > 7) {
    # print('he')
    #return( notes[1:numExpected + 1]);
    # }
    #else {
    
    for(i in 1:length(notes)) {
      if(i != 1) {
        diff <- abs(notes[i] - notes[i-1])
        diffArray <- c(diffArray, diff)
      }
    }
    indexMin <- which.min(diffArray)
    
    sumWeights <- sum(c(notesDurations[indexMin - 1], notesDurations[indexMin]))
    
    weightedNote <- (notes[indexMin - 1] * (notesDurations[indexMin - 1]/sumWeights)) + (notes[indexMin] * (notesDurations[indexMin]/sumWeights))
    notes[indexMin] <-  weightedNote
    notes <- notes[-c(indexMin - 1)]
    
    #change the notes duration to the average note
    meanWeights <- mean(c(notesDurations[indexMin - 1], notesDurations[indexMin]))
    notesDurations[indexMin] <-  meanWeights
    notesDurations <- notesDurations[-c(indexMin - 1)]
    
    
    processDataModifiedWeightDurations(numExpected, notes, notesDurations)
    
  }
  
  else {
    #notes were rounded to whole numbers
    return(round(notes));
  }
  
}

