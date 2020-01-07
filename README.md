# Data-driven approach to learning salience models of indoor landmarks by using genetic programming
By Xuke, Lei Ding, Jianga Shang, Hongchao Fan, Tessio Novack, Alexey Noskov, Alexander

## Introduction

This paper addresses the problem of determining the 
most salient landmark from several candidates at decision 
points in landmark-based way-finding. Our method significantly 
outperforms existing methods and achieves around 76% precision, 
This accuracy rate is considerably higher than the ones achieved 
by conventional linear models. To learn more, please refer to our paper(https://www.tandfonline.com/doi/full/10.1080/17538947.2019.1701109)

## Code
Our code is under "code/" folder. 
The code is implemented by Matlab R2018a.
The algorithm is based on GPTIPS Symbolic Machine Learning Platform 
for MATLAB (https://sites.google.com/site/gptips4matlab/home)

## Data
Our data is under "data/" folder. 
Lists of "data/scencePic" folder are navigation scence images.
The sheet of "featuresAttributes" in landmarkDataSets.xlsx file is 
landmarks attributes value, and the sheet of "questionnairesResult" 
is questionnaire results from volunteer.

## Usage
The main function is Main_fold_5cross_validation.m, you could run the main function.

## Contact
Comments, queries and bug reports are appreciated.
Email: mylovedinglei@gmail.com
