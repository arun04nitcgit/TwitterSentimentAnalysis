#  Install Requried Packages
installed.packages("SnowballC")
installed.packages("tm")
installed.packages("twitteR")
installed.packages("syuzhet")

# Load Requried Packages
library(NLP)
library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")
library("tidytext")

# api_key <- "xxxxxxxxxxxxxxxxxxxxxxxxx"
# api_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# access_token <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# access_token_secret <- "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
tw = twitteR::searchTwitter('#realDonaldTrump + #HillaryClinton', n = 100, since = '2018-01-04', retryOnRateLimit = 1e3)
d = twitteR::twListToDF(tw)
d
nrow(d)

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
tweets <- userTimeline("elonmusk", n=2000)

n.tweet <- length(tweets)

tweets.df <- twListToDF(tweets) 

head(tweets.df)
head(tweets.df$text)

tweets.df2 <- gsub("http.*","",tweets.df$text)
tweets.df2 <- gsub("https.*","",tweets.df2)
tweets.df2 <- gsub("#.*","",tweets.df2)
tweets.df2 <- gsub("@.*","",tweets.df2)
tweets.df2 <- iconv(tweets.df2, to = "ASCII", sub = " ")  

head(tweets.df2)

word.df <- as.vector(tweets.df2)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(tweets.df2, emotion.df) 

head(emotion.df2)

sent.value <- get_sentiment(word.df)

most.positive <- word.df[sent.value == max(sent.value)]

most.positive

most.negative <- word.df[sent.value <= min(sent.value)] 
most.negative 

sent.value

positive.tweets <- word.df[sent.value > 0]
negative.tweets <- word.df[sent.value < 0]
head(negative.tweets)
neutral.tweets <- word.df[sent.value == 0]
category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
head(category_senti)
category_senti2 <- cbind(tweets,category_senti,sent)
category_senti2 <- cbind(tweets,category_senti,senti) 
head(category_senti2)  
tweets 
category_senti 


table(category_senti)
category_senti
