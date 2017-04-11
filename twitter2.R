library(twitteR)
library(xlsx)
consumer_key <- "JjqU6C81ZSFttww8Xe2lWXrCg"
consumer_secret <- "7MQDARYlC3f7sX5TlstvEHI3BYVjTOiFvRtoiu8fpb5NjBSwny"
access_token <- "	835019765508788224-Twx0VMQM48xsdDV0OQ4Q1ZjGdmGrOTt"
access_secret <- "N950rLZolhw3I1RLhzujjnqZXTRdu8yueS5HVoL62XLHh"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

oreo <- read.table("data/oreo.txt")
a <- unique(oreo)

for(i in 40364:80000) {
  Sys.sleep(2)
  tryCatch({
    tweet <- showStatus(a[5,1])
    data <- as.data.frame(tweet)
    print(data)
    name <- paste0("data/tweet_", i, ".xlsx")
    write.xlsx(data, name)
    rm(tweet,data)
  }, error=function(e){
    print("I AM DUMB AND I AM BEHAVING WEIRDLY")
  })
}
