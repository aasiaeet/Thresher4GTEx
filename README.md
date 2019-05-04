---
author: Amir, Asiaee
date: 03 May 2019
title: Thresher for GTEx
---

# Overview
This project was set up to apply the Thresher algorithm to the set of all transcription facotr expression data from Genotype-Tissue Expression (GTEx).

The project uses our standard directory structure. Scripts to perform the analysis are stored in `code`. Fundamental results of the analysis are stored in `results`, with the figures stored in `results/figures`. Documentation of the code is storted in `doc`. 
manuscript resulting from the analysis is stored in `doc/paper`. 

We store `raw` data, `clean` (processed) data, and intermediate `scratch` results in their own folders. Each user of the code must
decide how they want to store and access these folders on their own machine. However, they must document those choices in a file in their
home directory; specifically, in `$HOME/Paths/mirtcga.json`. On Windows devices, `$HOME` is the user's `Document` folder. This requirement makes it possible for the code to run on everyone's machines without requiring the data to be stored in the same place
(and especially not requiring it to be stored in the git repository). 

Note that you should not commit any file that you can reconstruct from the code or latex to the repository. So for Latex documents you should only keep `.tex` files and required images and for code only the scripts that are necessary to read the raw data and generate the outcome. `raw` data is the original received files (data) of the project and the intermediate data should get stored in `scratch` but sometimes because of comutational burden for regenerating those results, you may decide to save processed data in `clean`.  

Make sure that you commit the code to the `develop` branch and then if you want to edit the manuscript *check out* the manuscript branch and start editing.  

