#Enter the Na for the ones that do not have data and fill in the original ai values
fillInValues <- function(rdsList) {
  #expected <- c(1,1,1,1,2,2,2,2,3,3,3,3,5,5,5,5,4,3,6,3)
  
  
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
          
          contains_na <- any(is.na(notes))
          # print(notes)
          # print(contains_na)
          #1 note expected
          if(daaCount <= 4) {
            
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
          else if(daaCount == 5 | daaCount == 6 | daaCount == 7 | daaCount == 8) {
            
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
          else if(daaCount == 9 | daaCount == 10 | daaCount == 11 | daaCount == 12) {
            
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
          else if(daaCount == 13 | daaCount == 14 | daaCount == 15 | daaCount == 16) {
            
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
          else if(daaCount == 17) {
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
          else if(daaCount == 18) {
            
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
          else if(daaCount == 19) {
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
          else if(daaCount == 20) {
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