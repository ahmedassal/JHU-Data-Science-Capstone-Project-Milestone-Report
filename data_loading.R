downloadData <- function (dataURL, dataZipPath, dataZipFilename) {
  zipFile = paste0(dataZipPath, dataZipFilename)
  flog.info(zipFile)
  if(file.exists(zipFile)) {
    message("File is already downloaded")
  } else {
    download.file(dataURL, dataZipFilename, method="wget")    
  }
}

readLines2=function(fname) {
  s = file.info( fname )$size 
  buf = readChar( fname, s, useBytes=T)
  strsplit( buf,"\r\n",fixed=T,useBytes=T)[[1]]
}

loadData <- function (language, dataPath, profanityWordsFile, serializationPath) {
  langRelPath = paste0(language,"/")
  textDataPath = paste0(dataPath, langRelPath)
  
  newsTextSerFile = paste0(serializationPath,"0news_text.rds")
  blogsTextSerFile = paste0(serializationPath,"0blogs_text.rds")
  twitterTextSerFile = paste0(serializationPath,"0twitter_text.rds")
  profanityWordsTextSerFile = paste0(serializationPath,"0profanity_words.rds")
  
  newsTextFile = paste0(language,".news.txt")
  blogsTextFile = paste0(language,".blogs.txt")
  twitterTextFile = paste0(language,".twitter.txt")
  
  if ( !(file.exists(newsTextSerFile)) ){
    newsText <- readLines2(fname=paste0(textDataPath, newsTextFile))
    saveRDS(newsText, newsTextSerFile)
  } else {
    newsText <- readRDS(newsTextSerFile)
  }
  
  if( !(file.exists(blogsTextSerFile)) ){
    blogsText <- readLines2(fname=paste0(textDataPath, blogsTextFile))
    saveRDS(blogsText, blogsTextSerFile)
  } else {
    blogsText <- readRDS(blogsTextSerFile)
  }
  
  if( !(file.exists(twitterTextSerFile)) ){
    twitterText <- readLines2(fname=paste0(textDataPath, twitterTextFile))
    saveRDS(twitterText, twitterTextSerFile)
  } else {
    twitterText <- readRDS(twitterTextSerFile)    
  }
  
  if( !(file.exists(profanityWordsTextSerFile)) ){
    profanityWords <- readLines2(fname=paste0("", profanityWordsFile))
    saveRDS(profanityWords, profanityWordsTextSerFile)
  } else {
    profanityWords <- readRDS(profanityWordsTextSerFile)
  }
  
  text <- list(news = newsText, blogs = blogsText, twitter = twitterText, profanity = profanityWords)
  return(text)
}
  
sampleText <- function (sampleSize, text, serializationPath) {
  sampleSizePostfix = sub("\\.", "_", toString(sampleSize))
  newsSamplesSerFile = paste0(serializationPath,"1news_samples", sampleSizePostfix, ".rds")
  blogsSamplesSerFile = paste0(serializationPath,"1blogs_samples", sampleSizePostfix, ".rds")
  twitterSamplesSerFile = paste0(serializationPath,"1twitter_samples", sampleSizePostfix, ".rds")
  samplesSerFile = paste0(serializationPath,"1samples", sampleSizePostfix, ".rds")
  
  if (!file.exists(newsSamplesSerFile)){
    newsSamples <- sample(text$news, length(text$news) * sampleSize, replace = FALSE)
    saveRDS(newsSamples, newsSamplesSerFile)
  } else {
    newsSamples <- readRDS(newsSamplesSerFile)
  } 
  
  if (!file.exists(blogsSamplesSerFile)){
    blogsSamples <- sample(text$blogs, length(text$blogs) * sampleSize, replace = FALSE)
    saveRDS(blogsSamples, blogsSamplesSerFile)
    
  } else {
    blogsSamples <- readRDS(blogsSamplesSerFile)
  }  
  
  if (!file.exists(twitterSamplesSerFile)){
    twitterSamples <- sample(text$twitter, length(text$twitter) * sampleSize, replace = FALSE)
    saveRDS(twitterSamples, twitterSamplesSerFile)
  } else {
    twitterSamples <- readRDS(twitterSamplesSerFile)
  }  
  
  if (!file.exists(samplesSerFile)){
    samples <- list(news = newsSamples, blogs = blogsSamples, twitter = twitterSamples)
    saveRDS(samples, samplesSerFile)
  } else {
    samples <- readRDS(samplesSerFile)
  } 
  
  return(samples)
}

createCorpus <- function (samples, sampleSize, serializationPath) {
  sampleSizePostfix = sub("\\.", "_", toString(sampleSize))
  preCleanCorpusSerFile = paste0(serializationPath,"2preclean_corpus", sampleSizePostfix, ".rds")
  if (!file.exists(preCleanCorpusSerFile)){
    corpus = VCorpus(VectorSource(samples))
    # inspect(corpus)
    # length(corpus)
    saveRDS(corpus, preCleanCorpusSerFile)
  } else {
    corpus = readRDS(preCleanCorpusSerFile)
  }
  return(corpus)
}
  
    
   
    
    
    
    
    
    
