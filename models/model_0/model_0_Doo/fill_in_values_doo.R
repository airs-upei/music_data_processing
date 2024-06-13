fillInValuesForDoo <- function(rdsList) {
  #expected <- c(1,1,1,1,2,2,2,2,3,3,3,3,5,5,5,5,4,3,6,3)
  
  
  errors_tracker <-  c(rdsList$session$p_id)
  dooCount <- 0
  
  if(rdsList$session$p_id == 'joh11tav') {
    errors_tracker <-  c('cha20nib')
  }
  else {
    errors_tracker <-  c(rdsList$session$p_id)
  }
  
  #doo
  #petsta has a different data format
  if(!is.null(rdsList$MAST21)) {
    count <- 1
    for (melody in rdsList$MAST21) {
      
      if(dooCount < 20) {
        if(grepl("doo",names(rdsList$MAST21)[count], fixed = TRUE)) {
          dooCount <- dooCount + 1
          notes <- melody$pyin_res$freq
          duration <- melody$pyin_res$dur
          
          contains_na <- any(is.na(notes))
          
          
          
          #1 note expected
          if(dooCount <= 4) {
            
            
            if(contains_na) {
              
              errors_tracker <- c(errors_tracker, rep('NS', 1))
            }
            else if(length(notes) == 1 && !contains_na) {
              
              # melodyVector <- c(melodyVector, processData(1, notes))
              errors_tracker <- c(errors_tracker, notes)
              
            }
            
            else {
              errors_tracker <- c(errors_tracker, rep(NA, 1))
              
            }
            
          }
          
          #two notes expected
          else if(dooCount == 5 | dooCount == 6 | dooCount == 7 | dooCount == 8) {
            
            if(contains_na) {
              errors_tracker <- c(errors_tracker, rep('NS', 2))
            }
            
            else if(length(notes) == 2 && !contains_na) {
              
              errors_tracker <- c(errors_tracker, notes)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, rep(NA, 2))
            }
            
          }
          
          #3 notes expected
          else if(dooCount == 9 | dooCount == 10 | dooCount == 11 | dooCount == 12) {
            
            if(contains_na) {
              errors_tracker <- c(errors_tracker, rep('NS', 3))
            }
            
            else if(length(notes) == 3 && !contains_na) {
              errors_tracker <- c(errors_tracker, notes)
            }
            
            else {
              errors_tracker <- c(errors_tracker, rep(NA, 3))
            }
          }
          
          #5 notes expected
          else if(dooCount == 13 | dooCount == 14 | dooCount == 15 | dooCount == 16) {
            
            if(contains_na) {
              errors_tracker <- c(errors_tracker, rep('NS', 5))
            }
            
            else if(length(notes) == 5 && !contains_na) {
              errors_tracker <- c(errors_tracker, notes)
              
            }
            
            
            
            else {
              errors_tracker <- c(errors_tracker, rep(NA, 5))
            }
            
          }
          
          #4 notes expected
          else if(dooCount == 17) {
            if(contains_na) {
              errors_tracker <- c(errors_tracker, rep('NS', 4))
            }
            
            else if(length(notes) == 4 && !contains_na) {
              errors_tracker <- c(errors_tracker, notes)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, rep(NA, 4))
            }
          }
          
          #3 notes expected
          else if(dooCount == 18) {
            
            if(contains_na) {
              errors_tracker <- c(errors_tracker, rep('NS', 3))
            }
            
            else if(length(notes) == 3 && !contains_na) {
              errors_tracker <- c(errors_tracker, notes)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, rep(NA, 3))
            }
          }
          
          #6 notes expected
          else if(dooCount == 19) {
            if(contains_na) {
              errors_tracker <- c(errors_tracker, rep('NS', 6))
            }
            
            else if(length(notes) == 6 && !contains_na) {
              errors_tracker <- c(errors_tracker, notes)
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, rep(NA, 6))
            }
          }
          
          #3 notes expected
          else if(dooCount == 20) {
            if(contains_na) {
              errors_tracker <- c(errors_tracker, rep('NS', 3))
            }
            
            else if(length(notes) == 3 && !contains_na) {
              errors_tracker <- c(errors_tracker, notes)
              
            }
            
            
            else {
              errors_tracker <- c(errors_tracker, rep(NA, 3))
            }
          }
        }
      }
      
      count <- count + 1
      
    }
    
    if(length(errors_tracker) < 61) {
      errors_tracker <- c(errors_tracker, rep(NA, 61 - length(errors_tracker)))
    }
    
  }
  
  else {
    errors_tracker <- c(errors_tracker, rep(NA, 60))
  }
  
  return(errors_tracker);
  
}