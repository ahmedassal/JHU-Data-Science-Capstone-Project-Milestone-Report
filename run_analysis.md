# JHU Data Science Capstone Project - Milestone Report
Sunday, March 29, 2015  

#Synopsis
This report explains the explores the corpus, HC Corpora, from http://www.corpora.heliohost.org/ in preparation for the John Hopkins Data Science Capstone project. The project is a Shiny app that takes as input a phrase (multiple words) in a text box input and outputs a prediction of the next word. This document explains only the major features identified of the data including summary statistics about the data sets. It also reports any interesting findings that we amassed so far.

In addition, the report elaborates our goals for the eventual app and algorithm and briefly summarize our plans for creating the prediction algorithm and Shiny app. It also serves as a basis for collecting feedback on our plans for creating a prediction algorithm and Shiny app.      

#Data Processing   

##Loading packages    

We used different R packages for producing report. More specifically:         
* For text manipulation, we used: RWeka, stringi    
* For text mining, we used: SnowballC, tm    
* For data visualization, we used: ggplot2      

##Downloading data
[The HC Corpora](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) where downloaded from www.corpora.heliohost.org . See the readme file at http://www.corpora.heliohost.org/aboutcorpus.html for details on the corpora available. The files have been language filtered but may still contain some foreign text.    



The file downloaded had a large size of 548MB. After unzipping the file, we find the following directories:   

```
## [1] "de_DE" "en_US" "fi_FI" "ru_RU"
```
Each of them represent Corpora for a specific language. We will use English Corpora here for our proficiency with the English language.
If we list the files in the english corpora directory, we see that it contains files for news, blogs and twitter.    


```
## [1] "en_US.blogs.txt"   "en_US.news.txt"    "en_US.twitter.txt"
```

##Loading data   





When loading all of the english Corpora in the data file, we are actually loading around 151 million words in 2 million lines. That's about four times the size of the Encyclopedia Britannica.        

![15th edition of the Britannica._Wikipedia._](http://cdn.afterdawn.com/v3/news/600x400/220px-Encyclopaedia_Britannica_15_with_2002.jpg)          

##Data Features    

###Summary Statistics
To get a better sense of the size of this data, the following summary statistics elaborates the main features of the corpora.     

```
##            filename  size_MB total_words   lines mean_words
## 1   en_US.blogs.txt 200.4242    38154238  899288   42.42716
## 2    en_US.news.txt 196.2775    35010782 1010242   34.65584
## 3 en_US.twitter.txt 159.3641     2136398  167155   12.78094
## 4             Total 556.0658    75301418 2076685   34.65582
```













###Word Cloud of Most Frequent Unigrams (1 word)     

![](./run_analysis_files/figure-html/drawUgWc-1.png) 



###Word Cloud of Most Frequent Bigrams (2 words)           

![](./run_analysis_files/figure-html/drawBgWc-1.png) 



###Word Cloud of Most Frequent Trigrams (3 words)       

![](./run_analysis_files/figure-html/drawTgWc-1.png) 



###Word Cloud of Most Frequent Quadgrams (4 words)       

![](./run_analysis_files/figure-html/drawQgWc-1.png) 



#Shiny App Strategy     

#Conclusion
