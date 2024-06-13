#Model 4s


## Using an Absolute Difference matrix to process data and pick our notes
readAndProcessDataWithAbsoluteDifferenceMatrix <- function(rdsList) {
  
  #this user data naming is different.
  #rdsList <- readRDS("/Users/mcfrancho/Downloads/MusicCognitionResults/MAST21/output/results/id=19&p_id=Pet23sta&save_id=7&pilot=false&complete=false.rds")
  
  
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
          duration <- melody$pyin_res$dur
          correct_vector <- c()
          voice_range <- 2
          
          # print(melody$voice_range)
          # if(length(melody$voice_range) > 0) {
          #   if(melody$voice_range == 'Soprano') {
          #     voice_range <- 1
          #   }
          #   else if(melody$voice_range == 'Tenor') {
          #     voice_range <- 2
          #   }
          #   
          #   else if(melody$voice_range == 'Alto') {
          #     voice_range <- 2
          #   }
          #   
          #   else {
          #     voice_range <- 2
          #     
          #   }
          # }
          
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
              
              # melodyVector <- c(melodyVector, processData(1, notes))
              # print(correct_vector)
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(1, notes, correct_vector))
              
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
              
              # melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(2, notes, correct_vector))
              
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
              
              #melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(3, notes, correct_vector))
              
              
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
              
              #melodyVector <- c(melodyVector, processData(5, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(5, notes, correct_vector))
              
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
              
              
              # melodyVector <- c(melodyVector, processData(4, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(4, notes, correct_vector))
              
              
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
              
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(3, notes, correct_vector))
              
              
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
              # melodyVector <- c(melodyVector, processData(6, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(6, notes, correct_vector))
              
              
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
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(3, notes, correct_vector))
              
              
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
          duration <- melody$pyin_res$dur
          
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
              #melodyVector <- c(melodyVector, processData(1, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(1, notes, correct_vector))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #two notes expected
          else if(dooCount == 5 | dooCount == 6 | dooCount == 7 | dooCount == 8) {
            
            if(length(notes) > 2) {
              #melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(2, notes, correct_vector))
              
              
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
              #melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(3, notes, correct_vector))
              
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
              #melodyVector <- c(melodyVector, processData(5, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(5, notes, correct_vector))
              
              
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
              #melodyVector <- c(melodyVector, processData(4, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(4, notes, correct_vector))
              
              
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
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(3, notes, correct_vector))
              
              
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
              #melodyVector <- c(melodyVector, processData(6, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(6, notes, correct_vector))
              
              
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
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithMinAbsDiff(3, notes, correct_vector))
              
              
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


## Using an Absolute Difference matrix to process data and pick our notes
readAndProcessDataWithSequentialNoteCombinations <- function(rdsList) {
  
  #this user data naming is different.
  #rdsList <- readRDS("/Users/mcfrancho/Downloads/MusicCognitionResults/MAST21/output/results/id=19&p_id=Pet23sta&save_id=7&pilot=false&complete=false.rds")
  
  
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
          duration <- melody$pyin_res$dur
          correct_vector <- c()
          voice_range <- 2
          
          # print(melody$voice_range)
          # if(length(melody$voice_range) > 0) {
          #   if(melody$voice_range == 'Soprano') {
          #     voice_range <- 1
          #   }
          #   else if(melody$voice_range == 'Tenor') {
          #     voice_range <- 2
          #   }
          #   
          #   else if(melody$voice_range == 'Alto') {
          #     voice_range <- 2
          #   }
          #   
          #   else {
          #     voice_range <- 2
          #     
          #   }
          # }
          
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
              
              # melodyVector <- c(melodyVector, processData(1, notes))
              # print(correct_vector)
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(1, notes, correct_vector))
              
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
              
              # melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(2, notes, correct_vector))
              
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
              
              #melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(3, notes, correct_vector))
              
              
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
              
              #melodyVector <- c(melodyVector, processData(5, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(5, notes, correct_vector))
              
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
              
              
              # melodyVector <- c(melodyVector, processData(4, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(4, notes, correct_vector))
              
              
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
              
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(3, notes, correct_vector))
              
              
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
              # melodyVector <- c(melodyVector, processData(6, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(6, notes, correct_vector))
              
              
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
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(3, notes, correct_vector))
              
              
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
          duration <- melody$pyin_res$dur
          
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
              #melodyVector <- c(melodyVector, processData(1, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(1, notes, correct_vector))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #two notes expected
          else if(dooCount == 5 | dooCount == 6 | dooCount == 7 | dooCount == 8) {
            
            if(length(notes) > 2) {
              #melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(2, notes, correct_vector))
              
              
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
              #melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(3, notes, correct_vector))
              
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
              #melodyVector <- c(melodyVector, processData(5, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(5, notes, correct_vector))
              
              
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
              #melodyVector <- c(melodyVector, processData(4, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(4, notes, correct_vector))
              
              
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
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(3, notes, correct_vector))
              
              
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
              #melodyVector <- c(melodyVector, processData(6, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(6, notes, correct_vector))
              
              
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
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithSequentialNoteCombinations(3, notes, correct_vector))
              
              
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




#4th model
processDataWithMinAbsDiff <- function(numExpected, notes, correctFrequenciesVector) {
  #if(length(notes) > 7) {
  # print('he')
  #return( notes[1:numExpected + 1]);
  # }
  #else {
  #print(notes)
  #print(correctFrequenciesVector)
  diff_matrix <- abs(outer(correctFrequenciesVector, notes, '-'))
  notesRes <- c()
  
  # for(i in 1:nrow(diff_matrix)) {
  #   notesRes <- c(notesRes, notes[which.min(diff_matrix[i,])])
  # }
  
  drop = numeric(0)
  
  for(i in 1:nrow(diff_matrix)) {
    notesRes <- c(notesRes, notes[which.min(diff_matrix[i,])])
    
    
    to_drop = which.min(diff_matrix[i, -drop])
    drop = c(drop, to_drop)
    notesRes <- c(notesRes, notes[to_drop])
  }
  
  return (notesRes);
}



processDataWithMinAbsDiffModified <- function(numExpected, notes, correctFrequenciesVector) {
  #if(length(notes) > 7) {
  # print('he')
  #return( notes[1:numExpected + 1]);
  # }
  #else {
  #print(notes)
  #print(correctFrequenciesVector)
  diff_matrix <- abs(outer(correctFrequenciesVector, notes, '-'))
  notesRes <- c()
  
  # for(i in 1:nrow(diff_matrix)) {
  #   notesRes <- c(notesRes, notes[which.min(diff_matrix[i,])])
  # }
  
  drop = numeric(0)
  
  for(i in 1:nrow(diff_matrix)) {
    notesRes <- c(notesRes, notes[which.min(diff_matrix[i,])])
    
    
    to_drop = which.min(diff_matrix[i, -drop])
    drop = c(drop, to_drop)
    notesRes <- c(notesRes, notes[to_drop])
  }
  
  return (notesRes);
}




#New
processDataWithSequentialNoteCombinations <- function(numExpected, notes, correctFrequenciesVector){
  MT <- correctFrequenciesVector
  SD <- notes
  CT <- combn(SD, length(MT))
  ML <- 1:length(MT)
  CL <- 1:ncol(CT)
  n <- seq(1, length(MT), 1)
  m <- seq(1, ncol(CT))
  d <- c()
  for (k in m){
    d[k] <- sum(abs(CT[ML[n],CL[k]] - MT[n]))
  }
  
  return (CT[,which.min(d)])
}


#Old
processDataWithMinAbsDiffModified <- function(numExpected, notes, correctFrequenciesVector) {
  #if(length(notes) > 7) {
  # print('he')
  #return( notes[1:numExpected + 1]);
  # }
  #else {
  #print(notes)
  #print(correctFrequenciesVector)
  diff_matrix <- abs(outer(correctFrequenciesVector, notes, '-'))
  notesRes <- c()
  
  # for(i in 1:nrow(diff_matrix)) {
  #   notesRes <- c(notesRes, notes[which.min(diff_matrix[i,])])
  # }
  
  drop = numeric(0)
  
  for(i in 1:nrow(diff_matrix)) {
    notesRes <- c(notesRes, notes[which.min(diff_matrix[i,])])
    
    
    to_drop = which.min(diff_matrix[i, -drop])
    drop = c(drop, to_drop)
    notesRes <- c(notesRes, notes[to_drop])
  }
  
  return (notesRes);
}