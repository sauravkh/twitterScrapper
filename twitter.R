# Saurav Kharb
# Research Assitant
# This script makes calls on the twitteR api using tweet id's

library(twitteR)
library("httr")
library("xlsx")

# set up OAuth
consumer_key <- "JjqU6C81ZSFttww8Xe2lWXrCg"
consumer_secret <- "7MQDARYlC3f7sX5TlstvEHI3BYVjTOiFvRtoiu8fpb5NjBSwny"
access_token <- "835019765508788224-Twx0VMQM48xsdDV0OQ4Q1ZjGdmGrOTt"
access_secret <- "N950rLZolhw3I1RLhzujjnqZXTRdu8yueS5HVoL62XLHh"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

oreo <- read.table("data/oreo.txt", stringsAsFactors = FALSE)
a <- unique(oreo) #set appropriate path
rm(oreo)
#######################################
#### Code for one id per api call #####
#######################################

for(i in 280000:300000) {
  Sys.sleep(0.5)
  tryCatch({
    tweet <- showStatus(a[1,1])
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

# Code for checking 
tweet <- showStatus(oreo[1,1])
data <- as.data.frame(tweet)
print(data)

# combine multiple data files into one 
require("xlsx")
DF <- read.xlsx("data/tweet_10000.xlsx",1)
temp = list.files(path="data/",pattern="*.xlsx")
first_half <- read.xlsx("data/Merged/first_12075_oreo.xlsx",1)
final <- rbind(first_half,DF)
write.csv(final, "data/merged/89215TWEETS.csv")

for(i in temp) {
  currentDF <- read.xlsx(paste0("data/", i),1)
  DF <- rbind(DF, currentDF)
}

#######################################
#### Code for 10 id's per api call ####
#######################################

big.data <- showStatus(a[695172,1])
big.data <- as.data.frame(big.data)


start.from = 696963
while(start.from < 740001){
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
  #Sys.sleep(1.56)
  big.data <- rbind(big.data, current.dataframe)
  start.from = start.from + 10;
  print(start.from)
  print(lengths(big.data)[1]) # to check in console how many downloads are done
}

write.csv(big.data,"data/first.csv")

#####################################
#### Code from stackoverflow ########
#####################################

big.data <- as.data.frame(showStatus(a[2800006,1]))

start.from <- 2800007
t1 <- Sys.time()
while(start.from < 3100001){  
  list.of.ids <- a[start.from,1] # first id
  # to get 10 id's
  for(id.number in 1:99){
    list.of.ids <- c(list.of.ids, a[start.from + id.number,1]) # rest 8
  }
  # call api
  raw.api.data <- lookupStatus(list.of.ids)
  current.dataframe <- twListToDF(raw.api.data[1])
  for(i in 2:length(raw.api.data)){
    current.dataframe <- rbind(current.dataframe, twListToDF(raw.api.data[i]))
  } 
  #Sys.sleep(1.56)
  big.data <- rbind(big.data, current.dataframe)
  start.from = start.from + 100;
  print(start.from)
  print(lengths(big.data)[1])
  t2 <- Sys.time()
  print(t2-t1) # to check in console how many downloads are done
}

write.csv(big.data,"data/A15_138337_tweets.csv")



lookupStatus <- function (ids, ...){
  lapply(ids, twitteR:::check_id)
  
  batches <- split(ids, ceiling(seq_along(ids)/100))
  
  results <- lapply(batches, function(batch) {
    params <- parseIDs(batch)
    statuses <- twitteR:::twInterfaceObj$doAPICall(paste("statuses", "lookup", 
                                                         sep = "/"),
                                                   params = params, ...)
    twitteR:::import_statuses(statuses)
  })
  return(unlist(results))
}

parseIDs <- function(ids){
  id_list <- list()
  if (length(ids) > 0) {
    id_list$id <- paste(ids, collapse = ",")
  }
  return(id_list)
}

