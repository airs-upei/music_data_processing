readAndProcessData <- function(rdsList) {
  
  #this user data naming is different.
  #rdsList <- readRDS("/Users/mcfrancho/Downloads/MusicCognitionResults/MAST21/output/results/id=19&p_id=Pet23sta&save_id=7&pilot=false&complete=false.rds")
  
  
  
  melodyVector <-  c(rdsList$session$p_id)
  daaCount <- 0
  
  #daa
  #petsta has a different format
  if(!is.null(rdsList$MAST21_daah.MAST21)) {
    
    
    for (melody in rdsList$MAST21_daah.MAST21) {
      
      daaCount <- daaCount + 1
      
      #1 note expected
      if(daaCount <= 4) {
        melodyVector <- c(melodyVector, melody$stimuli)
      }
      
      #two notes expected
      else if(daaCount == 5 | daaCount == 6 | daaCount == 7 | daaCount == 8) {
        notes <- melody$user_response_note
        if(length(notes) > 2) {
          
          melodyVector <- c(melodyVector, processData(2, notes))
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
        notes <- melody$user_response_note
        if(length(notes) > 3) {
          
          melodyVector <- c(melodyVector, processData(3, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 5) {
          melodyVector <- c(melodyVector, processData(5, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 4) {
          melodyVector <- c(melodyVector, processData(4, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 3) {
          melodyVector <- c(melodyVector, processData(3, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 6) {
          melodyVector <- c(melodyVector, processData(6, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 3) {
          melodyVector <- c(melodyVector, processData(3, notes))
          
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
    
    if(daaCount < 21) {
      melodyVector <- c(melodyVector, rep(9999, 61 - length(melodyVector)))
    }
  }
  
  else {
    #petsta has a different format
    if(!is.null(rdsList$MAST21_daah)) {
      
      for (melody in rdsList$MAST21_daah) {
        
        daaCount <- daaCount + 1
        
        if(daaCount <= 4) {
          melodyVector <- c(melodyVector, melody$stimuli)
        }
      }
      
      melodyVector <- c(melodyVector, rep(9999, 56))
      
    }
    
    else {
      melodyVector <- c(melodyVector, rep(9999, 60))
    }
  }
  
  
  
  #doo
  dooCount <- 0
  if(!is.null(rdsList$MAST21_dooo.MAST21)) {
    
    for (melody in rdsList$MAST21_dooo.MAST21) {
      
      dooCount <- dooCount + 1
      
      #1 note expected
      if(dooCount <= 4) {
        melodyVector <- c(melodyVector, melody$stimuli)
      }
      
      #two notes expected
      else if(dooCount == 5 | dooCount == 6 | dooCount == 7 | dooCount == 8) {
        notes <- melody$user_response_note
        if(length(notes) > 2) {
          melodyVector <- c(melodyVector, processData(2, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 3) {
          melodyVector <- c(melodyVector, processData(3, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 5) {
          melodyVector <- c(melodyVector, processData(5, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 4) {
          melodyVector <- c(melodyVector, processData(4, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 3) {
          melodyVector <- c(melodyVector, processData(3, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 6) {
          melodyVector <- c(melodyVector, processData(6, notes))
          
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
        notes <- melody$user_response_note
        if(length(notes) > 3) {
          melodyVector <- c(melodyVector, processData(3, notes))
          
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
    
    
    if(dooCount < 21) {
      melodyVector <- c(melodyVector, rep(9999, 121 - length(melodyVector)))
    }
  }
  
  else {
    melodyVector <- c(melodyVector, rep(9999, 60))
  }
  
  
  return(melodyVector);
}


#62, 60, 60
#(100,2,1,6,5)
#(47,49,50,56,61)
#(47,49.5,56,61)
#(100,2.5,6.5,5)
processData <- function(numExpected, notes) {
  diffArray <- c(100)
  
  if(length(notes) != numExpected) {
    for(i in 1:length(notes)) {
      if(i != 1) {
        diff <- abs(notes[i] - notes[i-1])
        diffArray <- c(diffArray, diff)
      }
    }
    indexMin <- which.min(diffArray)
    minAvg <- mean(c(notes[indexMin - 1], notes[indexMin]))
    notes[indexMin] <-  minAvg
    notes <- notes[-c(indexMin - 1)]
    
    processData(numExpected, notes)
  }
  
  else {
    #notes were rounded to whole numbers
    return(round(notes));
  }
  
}