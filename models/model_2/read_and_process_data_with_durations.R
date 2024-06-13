## Using the notes durations to process data
readAndProcessDataWithDuration <- function(rdsList) {
  
  #this user data naming is different.
  #rdsList <- readRDS("/Users/mcfrancho/Downloads/MusicCognitionResults/MAST21/output/results/id=19&p_id=Pet23sta&save_id=7&pilot=false&complete=false.rds")
  
  
  daaCount <- 0
  
  
  if(rdsList$session$p_id == 'joh11tav') {
    melodyVector <-  c('cha20nib')
    
  }
  else {
    melodyVector <-  c(rdsList$session$p_id)
    
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
          
          
          if(any(is.na(notes))) {
            notes <- c(9999)
          }
          
          
          #1 note expected
          if(daaCount <= 4) {
            if(length(notes) > 1) {
              
              # melodyVector <- c(melodyVector, processData(1, notes))
              
              melodyVector <- c(melodyVector, processDataWithDuration(1, notes, duration))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
            
          }
          
          #two notes expected
          else if(daaCount == 5 | daaCount == 6 | daaCount == 7 | daaCount == 8) {
            if(length(notes) > 2) {
              
              # melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, processDataWithDuration(2, notes, duration))
              
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
            if(length(notes) > 3) {
              
              #melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithDuration(3, notes, duration))
              
              
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
            if(length(notes) > 5) {
              #melodyVector <- c(melodyVector, processData(5, notes))
              melodyVector <- c(melodyVector, processDataWithDuration(5, notes, duration))
              
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
              # melodyVector <- c(melodyVector, processData(4, notes))
              melodyVector <- c(melodyVector, processDataWithDuration(4, notes, duration))
              
              
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
            if(length(notes) > 3) {
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithDuration(3, notes, duration))
              
              
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
            if(length(notes) > 6) {
              # melodyVector <- c(melodyVector, processData(6, notes))
              melodyVector <- c(melodyVector, processDataWithDuration(6, notes, duration))
              
              
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
            if(length(notes) > 3) {
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, processDataWithDuration(3, notes, duration))
              
              
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
          
          if(any(is.na(notes))) {
            notes <- c(9999)
          }
          
          
          #1 note expected
          if(dooCount <= 4) {
            if(length(notes) > 1) {
              #melodyVector <- c(melodyVector, processData(1, notes))
              melodyVector <- c(melodyVector, processDataWithDuration(1, notes, duration))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #two notes expected
          else if(dooCount == 5 | dooCount == 6 | dooCount == 7 | dooCount == 8) {
            
            if(length(notes) > 2) {
              #melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, processDataWithDuration(2, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, processDataWithDuration(3, notes, duration))
              
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
              melodyVector <- c(melodyVector, processDataWithDuration(5, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, processDataWithDuration(4, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, processDataWithDuration(3, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, processDataWithDuration(6, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, processDataWithDuration(3, notes, duration))
              
              
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


#Model 2B
##Using the notes durations to process data Modified
## Using the notes durations to process data
readAndProcessDataWithDurationReorder <- function(rdsList) {
  
  #this user data naming is different.
  #rdsList <- readRDS("/Users/mcfrancho/Downloads/MusicCognitionResults/MAST21/output/results/id=19&p_id=Pet23sta&save_id=7&pilot=false&complete=false.rds")
  
  
  daaCount <- 0
  
  
  if(rdsList$session$p_id == 'joh11tav') {
    melodyVector <-  c('cha20nib')
    
  }
  else {
    melodyVector <-  c(rdsList$session$p_id)
    
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
          
          
          if(any(is.na(notes))) {
            notes <- c(9999)
          }
          
          
          #1 note expected
          if(daaCount <= 4) {
            if(length(notes) > 1) {
              
              # melodyVector <- c(melodyVector, processData(1, notes))
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(1, notes, duration))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
            
          }
          
          #two notes expected
          else if(daaCount == 5 | daaCount == 6 | daaCount == 7 | daaCount == 8) {
            if(length(notes) > 2) {
              
              # melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(2, notes, duration))
              
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
            if(length(notes) > 3) {
              
              #melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(3, notes, duration))
              
              
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
            if(length(notes) > 5) {
              #melodyVector <- c(melodyVector, processData(5, notes))
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(5, notes, duration))
              
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
              # melodyVector <- c(melodyVector, processData(4, notes))
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(4, notes, duration))
              
              
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
            if(length(notes) > 3) {
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(3, notes, duration))
              
              
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
            if(length(notes) > 6) {
              # melodyVector <- c(melodyVector, processData(6, notes))
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(6, notes, duration))
              
              
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
            if(length(notes) > 3) {
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(3, notes, duration))
              
              
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
          
          if(any(is.na(notes))) {
            notes <- c(9999)
          }
          
          
          #1 note expected
          if(dooCount <= 4) {
            if(length(notes) > 1) {
              #melodyVector <- c(melodyVector, processData(1, notes))
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(1, notes, duration))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #two notes expected
          else if(dooCount == 5 | dooCount == 6 | dooCount == 7 | dooCount == 8) {
            
            if(length(notes) > 2) {
              #melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(2, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(3, notes, duration))
              
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
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(5, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(4, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(3, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(6, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2B_processDataWithDurationAndReorder(3, notes, duration))
              
              
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


#Model 2C
readAndProcessDataWithDurationShortAveraged <- function(rdsList) {
  
  #this user data naming is different.
  #rdsList <- readRDS("/Users/mcfrancho/Downloads/MusicCognitionResults/MAST21/output/results/id=19&p_id=Pet23sta&save_id=7&pilot=false&complete=false.rds")
  
  daaCount <- 0
  
  
  if(rdsList$session$p_id == 'joh11tav') {
    melodyVector <-  c('cha20nib')
    
  }
  else {
    melodyVector <-  c(rdsList$session$p_id)
    
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
          
          
          if(any(is.na(notes))) {
            notes <- c(9999)
          }
          
          
          #1 note expected
          if(daaCount <= 4) {
            if(length(notes) > 1) {
              
              # melodyVector <- c(melodyVector, processData(1, notes))
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(1, notes, duration))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
            
          }
          
          #two notes expected
          else if(daaCount == 5 | daaCount == 6 | daaCount == 7 | daaCount == 8) {
            if(length(notes) > 2) {
              
              # melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(2, notes, duration))
              
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
            if(length(notes) > 3) {
              
              #melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(3, notes, duration))
              
              
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
            if(length(notes) > 5) {
              #melodyVector <- c(melodyVector, processData(5, notes))
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(5, notes, duration))
              
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
              # melodyVector <- c(melodyVector, processData(4, notes))
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(4, notes, duration))
              
              
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
            if(length(notes) > 3) {
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(3, notes, duration))
              
              
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
            if(length(notes) > 6) {
              # melodyVector <- c(melodyVector, processData(6, notes))
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(6, notes, duration))
              
              
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
            if(length(notes) > 3) {
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(3, notes, duration))
              
              
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
          
          if(any(is.na(notes))) {
            notes <- c(9999)
          }
          
          
          #1 note expected
          if(dooCount <= 4) {
            if(length(notes) > 1) {
              #melodyVector <- c(melodyVector, processData(1, notes))
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(1, notes, duration))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #two notes expected
          else if(dooCount == 5 | dooCount == 6 | dooCount == 7 | dooCount == 8) {
            
            if(length(notes) > 2) {
              #melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(2, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(3, notes, duration))
              
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
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(5, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(4, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(3, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(6, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2C_processDataWithDurationAndAverage(3, notes, duration))
              
              
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


#Model 2C - 1
readAndProcessDataWithDurationShortAveraged_1 <- function(rdsList) {
  
  #this user data naming is different.
  #rdsList <- readRDS("/Users/mcfrancho/Downloads/MusicCognitionResults/MAST21/output/results/id=19&p_id=Pet23sta&save_id=7&pilot=false&complete=false.rds")
  
  daaCount <- 0
  
  
  if(rdsList$session$p_id == 'joh11tav') {
    melodyVector <-  c('cha20nib')
    
  }
  else {
    melodyVector <-  c(rdsList$session$p_id)
    
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
          
          
          if(any(is.na(notes))) {
            notes <- c(9999)
          }
          
          
          
          
          #1 note expected
          if(daaCount <= 4) {
            if(length(notes) > 1) {
              
              # melodyVector <- c(melodyVector, processData(1, notes))
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(1, notes, duration))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
            
          }
          
          #two notes expected
          else if(daaCount == 5 | daaCount == 6 | daaCount == 7 | daaCount == 8) {
            if(length(notes) > 2) {
              
              # melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(2, notes, duration))
              
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
            if(length(notes) > 3) {
              
              #melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(3, notes, duration))
              
              
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
            if(length(notes) > 5) {
              #melodyVector <- c(melodyVector, processData(5, notes))
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(5, notes, duration))
              
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
              # melodyVector <- c(melodyVector, processData(4, notes))
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(4, notes, duration))
              
              
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
            if(length(notes) > 3) {
              # melodyVector <- c(melodyVector, processData(3, notes))
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(3, notes, duration))
              
              
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
            if(length(notes) > 6) {
              # melodyVector <- c(melodyVector, processData(6, notes))
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(6, notes, duration))
              
              
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
            if(length(notes) > 3) {
              # melodyVector <- c(melodyVector, processData(3, notes))
              
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(3, notes, duration))
              
              
              #avg <- mean(tail(notes, 2))
              #melodyVector <- c(melodyVector, c(notes[1:2], avg))
            }
            
            else if(length(notes) < 3) {
              melodyVector <- c(melodyVector, c(notes[1: length(notes)], rep(9999, 3 - length(notes))))
              
            }
            
            else {
              
              melodyVector <- c(melodyVector, notes)
              print("ran")
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
          
          if(any(is.na(notes))) {
            notes <- c(9999)
          }
          
          
          #1 note expected
          if(dooCount <= 4) {
            if(length(notes) > 1) {
              #melodyVector <- c(melodyVector, processData(1, notes))
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(1, notes, duration))
              
            }
            
            else {
              melodyVector <- c(melodyVector, notes)
            }
          }
          
          #two notes expected
          else if(dooCount == 5 | dooCount == 6 | dooCount == 7 | dooCount == 8) {
            
            if(length(notes) > 2) {
              #melodyVector <- c(melodyVector, processData(2, notes))
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(2, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(3, notes, duration))
              
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
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(5, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(4, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(3, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(6, notes, duration))
              
              
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
              melodyVector <- c(melodyVector, model2C_1_processDataWithDurationAndAverage(3, notes, duration))
              
              
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



#Model 2A
processDataWithDuration <- function(numExpected, notes, notesDuration) {
  #if(length(notes) > 7) {
  # print('he')
  #return( notes[1:numExpected + 1]);
  # }
  #else {
  
  sortedDuration <- sort(notesDuration, decreasing = TRUE)
  durationsNeeded <- sortedDuration[1:numExpected]
  
  #print(notes)
  #print(notesDuration)
  
  #print(durationsNeeded)
  
  notesRes <- c()
  for(i in durationsNeeded) {
    notesRes <- c(notesRes, notes[notesDuration == i][1])
    
  }
  
  return (notesRes);
}


#Model 2B
#REmove the shortest notes and then reorder the elements back in the original order
model2B_processDataWithDurationAndReorder <- function(numExpected, notes, notesDuration) {
  
  
  sortedDuration <- sort(notesDuration, decreasing = TRUE)
  durationsNeeded <- sortedDuration[1:numExpected]
  
  
  #We remove the notes that are not needed and return the original order of the notes
  # reorderedNotes <- notesDuration[!notesDuration %in% sortedDuration[(numExpected+1):length(sortedDuration)]] 
  
  
  shortestDurations <- sortedDuration[(numExpected+1):length(sortedDuration)]
  
  #get the indices of the shortest durations
  shortestDurationsPostions <- which(notesDuration %in% shortestDurations)
  
  # print(numExpected)
  # print(notesDuration)
  # print(sortedDuration)
  # print(shortestDurationsPostions)
  # print(notes)
  
  
  return (notes[-shortestDurationsPostions]);
  
}

#Model 2C
#c(330, 450, 670, 500, 320)
#c(1.2, 2.3, 0.5, 1.14, 1.09)
model2C_processDataWithDurationAndAverage <- function(numExpected, notes, notesDuration) {
  
  
  if(numExpected == length(notes)) {
    return (notes)
  }
  sortedDuration <- sort(notesDuration, decreasing = TRUE)
  durationsNeeded <- sortedDuration[1:numExpected]
  
  shortestDurations <- sortedDuration[(numExpected+1):length(sortedDuration)]
  
  #I decided to sort in decreasing order so that the elements at the end of the sequence are paid attention to first
  shortestDurationsPostions <- sort(which(notesDuration %in% shortestDurations), decreasing = TRUE)
  
  
  for (position in shortestDurationsPostions) {
    
    if(position == 1) {
      
      notes[1] <- (notes[1] + notes[2]) / 2
      notes <- notes[-2] 
    }
    
    else if(position == length(notes)) {
      notes[(length(notes)-1)] <- (notes[length(notes) - 1] + notes[length(notes)]) / 2
      notes <- notes[-length(notes)] 
      
    }
    
    else {
      #find the max between the left and right
      maxDuration <- max(notesDuration[(position - 1)], notesDuration[(position + 1)])
      maxDurationIndex <- which(notesDuration == maxDuration)
      
      notes[position] <- (notes[position] + notes[maxDurationIndex]) / 2
      notes <- notes[-maxDurationIndex] 
      
      notesDuration[position] <- (notesDuration[position] + notesDuration[maxDurationIndex]) / 2
      notesDuration <- notesDuration[-maxDurationIndex] 
      
    }
  }
  
  print(numExpected)
  print(notesDuration)
  print(sortedDuration)
  print(shortestDurationsPostions)
  print(notes)
  return (notes);
}


#Model 2C - 1
model2C_1_processDataWithDurationAndAverage <- function(numExpected, notes, notesDuration) {
  
  
  if(numExpected == length(notes)) {
    return (notes)
  }
  
  
  
  
  sortedDuration <- sort(notesDuration, decreasing = TRUE)
  durationsNeeded <- sortedDuration[1:numExpected]
  
  shortestDurations <- sortedDuration[(numExpected+1):length(sortedDuration)]
  
  #I decided to sort in decreasing order so that the elements at the end of the sequence are paid attention to first
  shortestDurationsPositions <- sort(which(notesDuration %in% shortestDurations), decreasing = TRUE)
  
  
  if(length(notes) %in% shortestDurationsPositions) {
    
    if((length(notes) - 1) %in% shortestDurationsPositions) {
      notes[(length(notes)-1)] <- (notes[length(notes) - 1] + notes[length(notes)]) / 2
      notes <- notes[-length(notes)]
      
      notesDuration[(length(notesDuration)-1)] <- (notesDuration[(length(notesDuration)-1)] + notesDuration[length(notesDuration)]) / 2
      notesDuration <- notesDuration[-length(notesDuration)]
      
    }
    
    else {
      ##make the shortest the longest note to make it stay
      notesDuration[length(notesDuration)] <-  sum(notesDuration)
      
    }
    
    
    return (model2C_1_processDataWithDurationAndAverage(numExpected, notes, notesDuration))
    
    
  }
  
  else {
    
    if(1 %in% shortestDurationsPositions) {
      
      notes[1] <- (notes[1] + notes[2]) / 2
      notes <- notes[-2]
      
      notesDuration[1] <- (notesDuration[1] + notesDuration[2]) / 2
      notesDuration <- notesDuration[-2]
      
      
    }
    
    else {
      position <- shortestDurationsPositions[1]
      
      # print(position)
      # 
      # print(numExpected)
      # print(notes)
      # print(notesDuration)
      
      
      if(notesDuration[(position - 1)] == notesDuration[(position + 1)]) {
        minDuration <- notesDuration[(position + 1)]
        minDurationIndex <- position + 1
      }
      
      else {
        #find the max between the left and right
        minDuration <- min(notesDuration[(position - 1)], notesDuration[(position + 1)])
        minDurationIndex <- which(notesDuration == minDuration)
        
      }
      
      
      # print(minDuration)
      # print(minDurationIndex)
      
      
      notes[position] <- (notes[position] + notes[minDurationIndex]) / 2
      notes <- notes[-minDurationIndex]
      
      
      
      # print(notes)
      notesDuration[position] <- (notesDuration[position] + notesDuration[minDurationIndex]) / 2
      notesDuration <- notesDuration[-minDurationIndex]
      
      # print(notes)
      # print(notesDuration)
      
      # if (TRUE) {stop("The value is TRUE, so the script must end here")
      # } else { #continue the script
      #   print("Script did NOT end!")
      # }
      
    }
    
    
    return (model2C_1_processDataWithDurationAndAverage(numExpected, notes, notesDuration))
  }
}


