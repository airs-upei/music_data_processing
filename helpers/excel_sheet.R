library("openxlsx")


#create a new sheet and write data
createNewSheet <- function(excelFilePath, sheetName, data) {
  
  wb <- createWorkbook()
  
  
  addWorksheet(wb, sheetName = sheetName)
  
  writeData(wb, sheet = sheetName, data, startCol = 1, startRow = 1)
  
  saveWorkbook(wb, excelFilePath, overwrite = TRUE)
}

addNewSheet <- function(excelFilePath, sheetName, data) {
  
  wb <- loadWorkbook(excelFilePath)
  
  
  addWorksheet(wb, sheetName = sheetName)
  
  writeData(wb, sheet = sheetName, data, startCol = 1, startRow = 1)
  
  saveWorkbook(wb, excelFilePath, overwrite = TRUE)
}