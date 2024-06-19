# Music Data Processing (Models Creation and Analysis)
Short Summary: This repo contains all the codes for our data processing and models generation (Models 0 - 4, +R)

## Brief Background
During the several singing studies conducted in our Music Lab, we collected and conducted several analysis on the singing data of our research participants. Out of all the data collected, we paid the most attention to 20 tone sequences from the MAST-21 singing data. This repository outlines and explains in detail each of the analysis conducted as well as the models developed to solve some major problems we encountered during pitch analysis.

## Problem Definition
In our music laboratory, the analysis of pitches has always been important in understanding the musical abilities of our research participants. Pitch analysis has always been conducted manually by our human listeners who make use of the Praat software() to listen carefully to audio wav files produced from our lab's various research studies conducted. These files, which consists of different tone sequences sang by research participants, are closely looked at to find the ideal pitch in which a participant produced melodies fall in.

This type of manual analysis, while effective in providing detailed data can be very time-consuming, especially when the files are countles. Our human analyst must listen to each individual audio wav file, and then picking out the various pitch changes, and any noticeable patterns that might show. If you consider the huge quantity of audio data generated from our research studies, you would guess that this process is really slow, and it prolongs our research process, possibly causing a delay in getting our research questions answered.

To address this problem and improve the efficiency of our research, we introduced an advanced pitch analysing software, pYIN into our singing programs, which has given us an improvement to how we analyse our data – automated pitch analysis.

pYIN is basically designed to automatically analyse the musical pitches in an audio recording. While our participants perform their singing tests, the pYIN program steadily operates in the background, carefully analysing the pitches of the participants as they sing. Indeed, this solved our problem of automating our pitch analysis 

However, while the pitch analysing software, pYIN, has greatly improved the efficiency of our data analysis, it is not a perfect system yet. From time to time, we encounter errors relating to what we have called errors of commission (overproduction of frequencies) for tone sequences. For instance, a participant might be presented with a sequence of three frequencies in their singing test, but pYIN might analyse and report more than that, like say, five frequencies. This error has the potential to affect our overall results and possibly, the validity of our research.

As a result of this, our need for a solution to correct this errors of commission was required. We created and introduced six separate traditional algorithms (models) to remove the excess notes produced by pYIN, and pick out the correct notes.

These six algorithms work with the same goal- pick the best possible number of notes from a list of produced notes. In practice, if three frequencies were presented to the participant, but pYIN produces five or six or seven or eight or ... notes, these algorithms then get to work with their unique solutions to identify and recognize the ideal frequencies out of those detected by pYIN.

Finally, in order to test the efficiency of our algorithms, the results produced by each of the six algorithms were correlated with the results obtained by our human analyst(using praat). The purpose of this was basically to compare the results from both pYIN and the manual process (praat) to see if our automated pitch analyzer outperforms our human analyser.


## Getting Started
**Step 1**: Get this repo in your machine either of the folloing ways:

a. Download the zip folder by clicking this link: https://github.com/airs-upei/music_data_processing/archive/refs/heads/main.zip 

b. Clone the repo by running this command in your terminal: **git clone** https://github.com/airs-upei/music_data_processing.git

**Step 2**: After downloading, unzip the folder in any location of your choice.

**Step 3**: Open the project in RStudio or any R supported IDE of your choice.


## Introduction to the Models (Model 0 - 4, +R)
As metioned before, the purpose of this Readme file is to explain each of the models, including the thought process behind the algorithm design, where to find specific models and files, and how to setup up your machine to run the models.

### Model 0
As explained in our paper, model 0, employs a straightforward method of eliminating the excess notes that occur during pitch analysis. The principle is simple: it eliminates or deletes all tone sequences which generate more frequencies than expected. This means that it retains only those that produce the correct number of notes. To demonstrate this better, if a sequence is expected to deliver three frequencies, but it ends up producing five, Model 0 will entirely discard that sequence. However, if the expected result is three frequencies and the tone sequence produces three, it will be retained.

The result from running this was used to perform a correlation of the retained tone sequences (those not deleted) with the expert results obtained by our human analyst.

Even though this is our simplest model, it does not really do any work except throw out valuable data. Each of the other models later developed perfomr more complex work compared to this basic Model 0.

#### Model 0 Code Description

**Navigating Files**
Step 1:

From the root folder, navigate to the models folder, and open folder named **model_0**

Step 2:
Choose **model_0_Daa** from the 2 folders, **model_0_Daa** or **model_0_Doo**

You would notice 2 R scripts,  **model0Daa.R** and **fill_in_values_daa.R**

**model0Daa.R**

This file is the starting point(main) for all of the data processing for model 0. It handles tasks such as:
i. Reading all the RDS files from pYIN.

ii. Calling the function (fillInValues) that handles the picking of random notes.

iii. Performing correlations with corresponding R data.

iv. Creating new excel sheet for data to be written and saving the sheet.

**fill_in_values_daa.R**

This file contains the logic/algorithm for picking the notes for Model 0. It is used by model0Daa.R to perform the major operation

**Running Model 0 Daa**
To run model 0, source all the files in model_0_Daa folder and call the function like this:

<pre>
model0Daa(folderPathToPyinFiles, praatData, outputFolder)
</pre>

_Parameter Descriptions_

@param **folderPathToPyinFiles**: The folder path to where all your pYIN RDS files for a particular study are stored.

@param **praatData** The dataframe containing the corresponding praat data for that study.

@param **outputFolder**: Where do you want the results to be stored


**model_0_Doo**

This same process applies to model 0 Doo, except that the function names and file names are different. But you can call model 0 Doo like this:

<pre>
model0Doo(folderPathToPyinFiles, praatData, outputFolder)
</pre>


### Model 1: Consecutive Difference Average
Model 1 takes a different approach to the processing and analysis of all the notes returned by the pYIN software. Unlike Model 0, which discards sequences with more than the expected frequencies, Model 1, explained in our paper, conducts a unique analysis for each trial where the number of notes generated by pYIN exceeds the ground truth.

It operates under the assumption that excess frequencies (errors of commission) are closest to the intended note and are thus processed accordingly. The main idea of this model involves identifying the differences between successive notes using a recursive function to then average the two notes that produce the smallest difference. This process is repeated until the number of notes matches the intended "ground truth" number.

Considering the example from our paper, let’s consider Trial 7, where the ground truth is 2, but pYIN generates 4 different frequencies: 
353.27, 351.51, 334.03, 332.13

In this case, Model 1 calculates the difference between successive pairs of frequencies:
<pre>
1st and 2nd: 353.27 – 351.51 = 1.76
2nd and 3rd: 351.51 – 334.03 = 17.48
3rd and 4th: 334.03 – 332.13 = 1.90
</pre>

Taking the smallest difference, in this case 1.76, between the 1st and 2nd note, the model averages the two frequencies (353.27 and 351.51). This yields 352.39. The excess note is then eliminated, leaving three frequencies: 352.39, 334.03, 332.13.

However, since the ground truth contains just two pitches, the process needs to be repeated again. The calculation of differences and averaging of notes continues until the number of notes matches the ground truth. 


#### Model 1 Code Description

**Navigating Files**
Step 1:

From the root folder, navigate to the models folder, and open folder named **model_1**

Step 2:
You would notice 2 R scripts,  **model1.R** and **read_and_process_data.R**

**model1.R**

This file is the starting point(main) for all of the data processing for model 1. It handles tasks such as:
i. Reading all the RDS files from pYIN.

ii. Calling the algorithmic function (readAndProcessData) that handles the main logic for model 1.

iii. Performing correlations with corresponding R data from Praat.

iv. Creating new excel sheet for data to be written and saving the sheet.

**read_and_process_data.R**

This file contains the logic/algorithm for picking the notes for Model 1. It contains 2 major functions, readAndProcessData and processData. It is used by model1.R to perform the major logic behind model 1.

**Running Model 1**
To run model 1, source all the files in model_1 folder and call the function like this:

<pre>
model1(folderPathToPyinFiles, praatData, outputFolder)
</pre>

_Parameter Descriptions_

@param **folderPathToPyinFiles**: The folder path to where all your pYIN RDS files for a particular study are stored.

@param **praatData** The dataframe containing the corresponding praat data for that study.

@param **outputFolder**: Where do you want the results to be stored


### Model 2: Longest Durations
Model 2 introduces the concept of observing not only the frequencies of the notes but also their durations. It operates under the assumption that the longest notes are likely to be the intended ones. To that effect, we created three variations of Model 2: 2A, 2B, and 2C, each with its unique method of handling the duration of pitches.


**Model 2A** assumes that the notes with the longest durations are the ones that should be considered. Based on this assumption, we arrange the the durations of the notes produced by pYIN in descending order. Then the first n notes, with n corresponding to the ground truth number of expected notes, are selected. The problem with this model variation is that we forget the original sequence in which the notes were presented, which may affect the results of the analysis.

Consider the example from Trial 7, where pYIN produced pitches with varying durations, the durations are reorganized from longest to shortest, and the corresponding notes are selected, without us paying attention to their original sequence.

<pre>
Durations: 0.57   0.53    0.80     0.14 
Notes:    353.27  351.51  334.03   332.13 
</pre>
 
But we need only 2 of the notes 
 
When durations are arranged in descending order, we have 

<pre>
0.80    0.57    0.53    0.14 
334.03  353.27  351.51  332.13 
</pre>

Pick the first 2

**Model 2B** is an improvement on Model 2A by paying attention to the original sequence of the notes. Just like Model 2A, it arranges the notes' durations in descending order and accordingly makes the note selection based on the ground truth number of expected nuotes. However, unlike Model 2A, it reorders the chosen frequencies to match their original sequence or indices. 

Taking the same example from Trial 7, as in Model 2A, the durations are sorted in a descending order, and the last two smallest durations are discarded. After discarding the shorter durations, the remaining durations are rearranged to align with their original order. As you can see, notes are selected not only based on their durations but also while maintaining their original presentation sequence. 

From the example in model 2A, after sorting the notes in descending order, we discard unwanted notes and reset the notes back to their original sequence or order as shown below

<pre>
Durations: 0.57      0.80        
Notes:     353.27    334.03 
</pre>

**Model 2C**





