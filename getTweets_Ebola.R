# get tweets with a hashtag -> for date since = n, until = n + 1d
getTweets <- searchTwitter("#Ebola", n=10000, since="2014-12-19", until="2014-12-20")
# get text of each tweet
getTweets_txt <- sapply(getTweets, function(x) x$getText())
# get info on whether the tweet is a retweet
getTweets_rt <- sapply(getTweets, function(x) x$getIsRetweet())
# get the date tweet was created
getTweets_date <- do.call(c,lapply(getTweets, function(x) x$created))
getTweets_date <- as.Date(getTweets_date,format="%Y%m%d")
# combine tweet info into a data frame
getTweets_df <- data.frame(date = getTweets_date, text = getTweets_txt, rt = getTweets_rt)
table(getTweets_df$date)
# save data
save(getTweets_df,file="getTweets_df_20141219.Rdata")
write.csv(getTweets_df, "getTweets_df_20141219.csv")