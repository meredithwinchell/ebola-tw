Oct17_list <- apply(Oct17, 1, function(r) paste(names(Oct17), r, sep=":", collapse=" "))
## Preliminary Analyses
install.packages("tm", dependencies=TRUE)
library("tm")
Oct17_list <- sapply(Oct17, function(x) x$getText())
Oct17_corpus <- Corpus(VectorSource(Oct17_list))
Oct17_corpus <- tm_map(Oct17_corpus, tolower)
Oct17_corpus <- tm_map(Oct17_corpus, removePunctuation)
Oct17_corpus <- tm_map(Oct17_corpus, function(x)removeWords(x,stopwords()))

install.packages("wordcloud")
library("wordcloud")

# errata: add 'unlist' to this call, thanks to John Whitehouse
wordcloud(unlist(Oct17_corpus))

Oct17_tdm <- TermDocumentMatrix(Oct17_corpus)

Oct17_tdm

# identify terms used at least 10 times
findFreqTerms(Oct17_tdm, lowfreq=10)

# the word you choose, and its association level, obviously depend on the data you scraped from Twitter!
findAssocs(Oct17_tdm, 'cloud', 0.2)

# Remove sparse terms from the term-documnet matrix
Oct172_tdm <- removeSparseTerms(Oct17_tdm, sparse=0.92)

# Convert the term-document matrix to a data frame
# errata: add the 'inspect' call here.  Thanks to John Whitehouse.
Oct172_df <- as.data.frame(inspect(Oct172_tdm))

# scale the data
Oct172_df_scale <- scale(Oct172_df)

# Create the distance matrix
Oct17_dist <- dist(Oct172_df_scale, method="euclidean")

# Cluster the data
Oct17_fit <- hclust(Oct17_dist, method="ward")

#Visualize the result
plot(Oct17_fit, main="Cluster - Big Data")

# An example with five (k=5) clusters (assumes your data has at least 5 terms!)
groups <- cutree(Oct17_fit, k=5)
# Dendrogram wiht blue clusters (k=5)
rect.hclust(Oct17_fit, k=5, border="blue")
