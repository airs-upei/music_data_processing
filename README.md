# Music Data Processing (Models Creation and Analysis)
Short Summary: This repo contains all the codes for our data processing and models generation (Models 0 - 4)

## Brief Background
During the several singing studies conducted in our Music Lab, we collected and conducted several analysis on the singing data of our research participants. Out of all the data collected, we paid the most attention to 20 tone sequences from the MAST-21 singing data. This repository outlines and explains in detail each of the analysis conducted as well as the models developed to solve some major problems we encountered during pitch analysis.

## Problem Definition
In our music laboratory, the analysis of pitches has always been important in understanding the musical abilities of our research participants. Traditionally, this pitch analysis has been conducted manually by human listeners who make use of the Praat software() to listen carefully to audio wav files produced from our lab's various research studies conducted. These files, which consists of different tone sequences sang by research participants, are closely looked at to find the ideal pitch in which a participant produced melodies fall in.

This type of manual analysis, while effective in providing detailed data can be very time-consuming, especially when the files are countles. Our human analyst must listen to each individual audio wav file, and then picking out the various pitch changes, and any noticeable patterns that might show. If you consider the huge quantity of audio data generated from our research studies, this process is really slow, and it prolongs our research process, possibly causing a delay in getting our research questions answered.

To address this problem and improve the efficiency of our research, we introduced an advanced pitch analysing software, pYIN into our singing programs, which has given us a new approach to how we analyse our data – automated pitch analysis.

pYIN is basically designed to automatically analyse the musical pitches in an audio recording. While our participants perform their singing tests, the pYIN program steadily operates in the background, carefully analysing the pitches of the participants as they sing. Indeed, this solved our problem of automating our pitch analysis 

However, while the pitch analysing software, pYIN, has greatly improved the efficiency of our data analysis, it is not a perfect system yet. From time to time, we encounter errors relating to what we have called errors of commission (overproduction of frequencies) for tone sequences. For instance, a participant might be presented with a sequence of three frequencies in their singing test, but pYIN might analyse and report more than that, like say, five frequencies. This error has the potential to affect our overall results and possibly, the validity of our research.

As a result of this, our need for a solution to correct this errors of commission was required. We created and introduced five separate traditional algorithms (models) to remove the excess notes produced by pYIN, and pick out the correct notes.

These five algorithms work with the same goal- pick the best possible number of notes from a list of produced notes. In practice, if three frequencies were presented to the participant, but pYIN produces five or six or seven or eight or ... notes, these algorithms then get to work with their unique solutions to identify and recognize the ideal frequencies out of those detected by pYIN.

Finally, in order to test the efficiency of our algorithms, the results produced by each of the five algorithms were correlated with the results obtained by our human analyst(using praat). The purpose of this was basically to compare the results from both pYIN and the manual process (praat) to see if our automated pitch analyzer outperforms our human analyser.


## Getting Started
**Step 1**: Get this repo in your machine either of the folloing ways:

a. Download the zip folder by clicking this link: https://github.com/airs-upei/music_data_processing/archive/refs/heads/main.zip 

b. Clone the repo by running this command in your terminal: **git clone** https://github.com/airs-upei/music_data_processing.git

**Step 2**: After downloading, unzip the folder in any location of your choice.

**Step 3**: Open the project in RStudio or any R supported IDE of your choice.


## Introduction to the Models (Model 0 - 4)
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
Choose any of of the folders, **model_0_Daa** or **model_0_Doo**
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
