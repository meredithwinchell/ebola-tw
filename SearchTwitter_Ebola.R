# get tweets with a hashtag -> for date since = n, until = n + 1d
tweets <- searchTwitter("#Ebola", n=10000, since="2014-12-19", until="2014-12-20")
# get text of each tweet
tweets_txt <- sapply(tweets, function(x) x$getText())
# get info on whether the tweet is a retweet
tweets_rt <- sapply(tweets, function(x) x$getRetweetCount())
# get info on who sent the tweet
tweets_sn <- sapply(tweets, function(x) x$getScreenName)
# get the date tweet was created
tweets_date <- do.call(c,lapply(tweets, function(x) x$created))
tweets_date <- as.Date(tweets_date,format="%Y%m%d")
# combine tweet info into a data frame
tweets_df <- data.frame(date = getTweets_date, text = getTweets_txt, rt = getTweets_rt)
table(getTweets_df$date)
# save data
save(getTweets_df,file="getTweets_df_20141219.Rdata")
write.csv(getTweets_df, "getTweets_df_20141219.csv")