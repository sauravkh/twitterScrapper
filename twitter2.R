# Saurav Kharb
# Research Assitant
# This script makes calls on the twitteR api using tweet id's

library(twitteR)
library(httr)
library(xlsx)
consumer_key <- "QHJgBeTm2KW5yyKu5jwzFxioT"
consumer_secret <- "TEvaRBKUaTM41lFzsiiclO7bIUHBZrarPsRPdL647ACMPO6uZe"
access_token <- "835019765508788224-HUGrNbQLek454Mwf6NBLJNRIxPYwFsI"
access_secret <- "xNzEIhcuO1WaV5hKGQItIhtCHLLbmAMHg5Y9Jy8S4zJfk"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

oreo <- read.table("data/oreo.txt", stringsAsFactors = FALSE)
a <- unique(oreo)

#######################################
#### Code for one id per api call #####
#######################################

for(i in 640000:590000) {
  Sys.sleep(0.7)
  tryCatch({
    tweet <- showStatus(a[2,1])
    data <- as.data.frame(tweet)
    print(paste0("*********  ", i , "  **********"))
    print(data)
    name <- paste0("data/new/tweet_", i, ".xlsx")
    write.xlsx(data, name)
    rm(tweet,data)
  }, error=function(e){
    print("I AM DUMB AND I AM BEHAVING WEIRDLY")
  })
}


write.csv(second.half,"data/merged/lastpeices.csv")
first.half <- read.csv("data/merged/89215TWEETS.csv")
second.half <- read.csv("data/merged/lastHalf.csv")
boss <- rbind(boss,second.half)

write.csv(boss,"FINAL_297679_TWEETS.csv")


write.xlsx(boss,"data/merged/FINAL_XLSX_VERSION.xlsx")

newData <- boss[65534,]

for(i in 65535:297679){
  newData <- rbind(newData,boss[i,])
  print(i)
}

#######################################
#### Code for 10 id's per call ########
#######################################

big.data <- showStatus(a[1,1])
big.data <- as.data.frame(big.data)
start.from = 1
while(start.from < 41) {
  # for every 10 from selected id's
  for(repeat.calls in 1:10){ 
    list.of.ids <- a[start.from,1] # first id
    # to get 10 id's
    for(id.number in 1:9){
      list.of.ids <- c(list.of.ids, a[start.from + id.number,1]) # rest 8
    }
    # call api
    raw.api.data <- lookup_statuses(list.of.ids)
    current.dataframe <- as.data.frame(raw.api.data[[1]])
    for(i in 2:length(raw.api.data)){
      current.dataframe <- rbind(current.dataframe, as.data.frame(raw.api.data[[i]]))
    } 
  }
  
  big.data <- rbind(big.data, current.dataframe)
  start.from = start.from + 10;
}

