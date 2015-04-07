gc()

# Path #######################################################################

workingPath = "D:/Woking/Courses/Data Science/Data Science/The Data Science Specialization/Data Science Capstone Project/Milestone Report/JHU-Data-Science-Capstone-Project-Milestone-Report"
setwd(workingPath)

dataURL = "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
dataZipPath = "../../data/"
dataZipFilename = "Coursera-SwiftKey.zip"
dataUnzipPath = paste0(dataZipPath,"Coursera-SwiftKey/final/")

profanityDataPath = "../../data/"
profanityWordsFile = paste0(profanityDataPath,"bad-words(CMU).txt")

serializationPath = "serialization/"

paths = list(workingPath = workingPath, dataURL = dataURL, 
             dataZipPath = dataZipPath, dataZipFilename = dataZipFilename, 
             dataUnzipPath = dataUnzipPath, profanityDataPath = profanityDataPath, 
             profanityWordsFile = profanityWordsFile, serializationPath = serializationPath)
rm(workingPath, dataURL, dataZipPath, dataZipFilename, dataUnzipPath, profanityDataPath, profanityWordsFile, serializationPath)

globals = list(paths = paths)
rm(paths)

# Packages and Sourcing ######################################################################

source("G:/DEV/R/library/packages_management.R")
source("data_loading.R")

packages = c("futile.logger", "SnowballC", "tm","RWeka", "stringi", "stringr", "ggplot2", "dplyr", "wordcloud", "RColorBrewer", "doParallel")
setup_packages(packages)
globals$packages = packages
rm(packages)

# Globals ######################################################################

language = "en_US"
sampleSize_01 = 0.01
sampleSize_05 = 0.05
sampleSize_10 = 0.10
sampleSize_20 = 0.20
sampleSize_30 = 0.30
sampleSize_50 = 0.50
sampleSize_100 = 1.00
sampleSize = list(sampleSize_01 = sampleSize_01 , sampleSize_05 = sampleSize_05, sampleSize_10 = sampleSize_10, sampleSize_20 = sampleSize_20, sampleSize_30 = sampleSize_30, sampleSize_50 = sampleSize_50, sampleSize_100 = sampleSize_100)

globals$sampleSize = sampleSize
globals$language = language
rm(sampleSize, sampleSize_01, sampleSize_05, sampleSize_10, sampleSize_20, sampleSize_30, sampleSize_50, sampleSize_100, language)

# Setup ######################################################################

cl = options(cores=4)
registerDoParallel(cl)  # register cluster
globals$parallel = list(cl=cl)
currentSampleSize = globals$sampleSize$sampleSize_01
rm(cl)
gc()

# Downloading Data ######################################################################

downloadData(dataURL = globals$paths$dataURL, dataZipPath = globals$paths$dataZipPath, dataZipFilename = globals$paths$dataZipFilename)

# Text Loading ######################################################################

textLoadingStartTime = proc.time()
text <- loadData(language = globals$language, dataPath = globals$paths$dataUnzipPath, profanityWordsFile = globals$paths$profanityWordsFile, serializationPath = globals$paths$serializationPath)
textLoadingEndTime = proc.time()
timeTextLoading = textLoadingEndTime - textLoadingStartTime
timeTextLoading = timeTextLoading[3]

rm(textLoadingEndTime, textLoadingStartTime)
# rm(timeTextLoading)
gc()

# Sampling ######################################################################
sampleStartTime = proc.time()

samples = sampleText(sampleSize = currentSampleSize, text = text, serializationPath = globals$paths$serializationPath)

sampleEndTime = proc.time()
timeSampling = sampleEndTime - sampleStartTime
timeSampling = timeSampling[3]

rm(text, sampleEndTime, sampleStartTime)
# rm(timeSampling)
gc()

# Create Corpus ######################################################################

createCorpusStartTime = proc.time()

corpus = createCorpus(samples = samples, sampleSize = currentSampleSize, serializationPath = globals$paths$serializationPath)

createCorpusEndTime = proc.time()
timeCreateCorpus = createCorpusEndTime - createCorpusStartTime
timeCreateCorpus = timeCreateCorpus[3]

rm(samples, createCorpusEndTime, createCorpusStartTime)
# rm(timeCreateCorpus)
gc()

# Create Corpus ######################################################################

