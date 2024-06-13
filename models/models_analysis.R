source("~/RProjects/MusicDataProcessor/helpers.R", echo=TRUE)


model0_subfolder <- 'model 0'
model1_subfolder <- 'model 1'
model2_subfolder <- 'model 2'
model3_subfolder <- 'model 3'
model4_subfolder <- 'model 4'
modelr_subfolder <- 'model r'
knitr::spin('~/RProjects/MusicDataProcessor/newPraatAnalyzer.R')


#/Users/mcfrancho/2022MusicResearchWork/Pyin_analysers/All Studies/April 2023/april_2023_results <- /Users/mcfrancho/2022MusicResearchWork/Pyin_analyser/new_marg.xlsx
#/Users/mcfrancho/2022MusicResearchWork/Pyin_analysers/All Studies/Mar & Apr 2022/seniors_rds_files <- /Users/mcfrancho/2022MusicResearchWork/seniors_Pyin_analyser/praat_seniors.xlsx
#/Users/mcfrancho/2022MusicResearchWork/Pyin_analysers/All Studies/June 2022/June_study_rds_files <- /Users/mcfrancho/2022MusicResearchWork/Pyin_analyser/praat_young_june_2022.xlsx

start_pyin_analysis <-  function(folderPathToPyinFiles, praatExcelFile, outputFolder) {
  praat_data = readxl::read_xlsx(praatExcelFile)
  folder <- '/Users/mcfrancho/2022MusicResearchWork/Pyin_analysers'
  
  #model 0 - Daa
  #model0Daa(folderPathToPyinFiles, praatData = praat_data, outputFolder = outputFolder)
  
  #model 0 - Doo
  # model0Doo(folderPathToPyinFiles, praatData = praat_data, outputFolder = outputFolder)
  
  # model0_doo_pyin <- readAllFiles(folderPathToPyinFiles, '/Users/mcfrancho/2022MusicResearchWork/Pyin_analyser/pyin_april2023Doo.xlsx', fillInValuesForDoo, dooHeader)
  
  
  #model 1
  #model1(folderPathToPyinFiles, praatData = praat_data, outputFolder = outputFolder)
  
  
  
  #model 2
  model2(folderPathToPyinFiles, praatData = praat_data, outputFolder = outputFolder)
  
  
  #model 3
  #model3(folderPathToPyinFiles, praatData = praat_data, outputFolder = outputFolder)
  
  #model 4
  #model4(folderPathToPyinFiles, praatData = praat_data, outputFolder = outputFolder)
  
  
  #model R
  #modelR(folderPathToPyinFiles, praatData = praat_data, outputFolder = outputFolder)
  
}