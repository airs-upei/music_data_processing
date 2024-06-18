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

As a result of this, our need for a solution to correct this errors of commission was required. We formulated and introduced five separate traditional algorithms to remove the excess notes produced by pYIN, and pick out the correct notes.

These five algorithms work with the same goal- pick the best possible number of notes from a list of produced notes. In practice, if three frequencies were presented to the participant, but pYIN produces five or six or seven or eight or ... notes, these algorithms then get to work with their unique solutions to identify and recognize the ideal frequencies out of those detected by pYIN.

Finally, in order to test the efficiency of our algorithms, the results produced by each of the five algorithms were correlated with the results obtained by our human analyst(using praat). The purpose of this approach was essentially to compare the results from both pYIN and the manual process (praat).



