Codebook
========================================================

This is a cookbook describing variables and data cleaning of the tidy data set.

## Data manipulation logic

The purpose of the data manipulation logic is to combine data in separate source files. Data consists of subject (the persons doing activities), activity master data (ie. names of the activities) and measurements. 

Data is loaded only for the measurements which name contains either "std" or "mean".

## Variables

Variables in the tidy data set are:
* Activity - Name of the activity performed by the person
* Subject_id - Id of the person who performed the activity
* Measurements - Measurement data is described in http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



