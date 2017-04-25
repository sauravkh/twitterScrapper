# Saurav Kharb
# Research Assitant
# This script makes calls on the twitteR api using tweet id's

library(twitteR)
library(httr)
library(xlsx)

token1 <- c("L8GeTUqQPbKcwdUml25xljl3G",
            "0umS59pqd4AcEsGgEMzvfhsYT9RFnQyt5RsdU53qoc7LLoqjkP",
            "835019765508788224-QAvxxTsImlQKLXDBZcRtfbMlFDxM7pM",
            "6LaX7rgIMde1H55B3huYT3unThbqdaf420WPNaINlxqRe")

token2 <- c("49iRCpw1UaM8kSr27zYmlWlyP",
            "SSIw3Ck5S1Lknq8OqHnRYBDZDSyHYsRxeEOqkVSNUvIokBTbAK",
            "835019765508788224-z7mQIISkQy1eX6CxWFWMCW2znIrnOnG",
            "pPjgmwjrjOliDvFhhI0Q5jHxFSUKEC61dIKYtjf4uRhzg")

token3 <- c("QHJgBeTm2KW5yyKu5jwzFxioT",
            "TEvaRBKUaTM41lFzsiiclO7bIUHBZrarPsRPdL647ACMPO6uZe",
            "835019765508788224-HUGrNbQLek454Mwf6NBLJNRIxPYwFsI",
            "xNzEIhcuO1WaV5hKGQItIhtCHLLbmAMHg5Y9Jy8S4zJfk")


setup_twitter_oauth(token2[1],token2[2],token2[3],token2[4])
num = 1;

oreo <- read.table("data/oreo.txt", stringsAsFactors = FALSE)
a <- unique(oreo)
rm(oreo)

#######################################
#### Code for one id per api call #####
#######################################

for(i in 640000:590000) {
  Sys.sleep(0.7)
  tryCatch({
    tweet <- showStatus(a[640000,1])
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

big.data <- showStatus(a[648502,1])
big.data <- as.data.frame(big.data)


#########################################################
#### Code for 100 id's per call with error catch ########
#########################################################
end = 651923
oops = 1
while(oops != 3){
  print("entered while loop")
  tryCatch({
    print("entered tryCatch")
    callTwitter(end)
  }, error=function(e){
    fileName <- paste0("data/tokenTrial",oops,".csv")
    write.csv(big.data,fileName)
    print(paste("entered error catch and file written till", fileName))
    print(paste("earlier using using authentication " , num))
    if(num == 1){
      setup_twitter_oauth(token2[1],token2[2],token2[3],token2[4])
      num <- 2;
    }else if(num == 2){
      setup_twitter_oauth(token3[1],token3[2],token3[3],token3[4])
      num <-  3;
    }else if(num == 3){
      setup_twitter_oauth(token4[1],token4[2],token4[3],token4[4])
      num <-  4;
    }else {
      setup_twitter_oauth(token1[1],token1[2],token1[3],token1[4])
      num <-  1;
    }
    print(paste("Now using authentication " , num))
    end = end + 890
  })
  oops <- oops + 1
}

start.from <- 650000
callTwitter(start.from)
  
callTwitter <- function(start.from){
  big.data <- showStatus(a[1,1])
  while(start.from < 690001) {
    # for every 10 from selected id's
    for(repeat.calls in 1:10){ 
      list.of.ids <- a[start.from,1] # first id
      # to get 10 id's
      for(id.number in 1:99){
        list.of.ids <- c(list.of.ids, a[start.from + id.number,1]) # rest 8
      }
      # call api
      raw.api.data <- lookup_statuses(list.of.ids)
      current.dataframe <- as.data.frame(raw.api.data[[1]])
      for(i in 2:length(raw.api.data)){
        current.dataframe <- rbind(current.dataframe, as.data.frame(raw.api.data[[i]]))
      } 
    }
    Sys.sleep(0.6)
    big.data <- rbind(big.data, current.dataframe)
    start.from = start.from + 100;
    print(start.from)
    print(lengths(big.data)[1])# to check in console how many downloads are done
  }
}

###########################################################
#### Code for 10 id's per call without error catch ########
###########################################################


start.from = 651933
while(start.from < 690001) {
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
  Sys.sleep(1.5)
  big.data <- rbind(big.data, current.dataframe)
  start.from = start.from + 10;
  print(start.from)
  print(lengths(big.data)[1]) # to check in console how many downloads are done
}

l <- a[1,1]
for(i in 1:250){
  l <- c(l,a[i,1])
}
write.csv(big.data,"data/secondfmjks.csv")

#####################################
#### Code from stackoverflow ########
#####################################

big.data <- as.data.frame(showStatus(a[2600007,1]))

start.from <- 2600008
t1 <- Sys.time()
while(start.from < 2800006){  
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


write.csv(first,"data/A0_tweets.csv")


temp = list.files(path="data/",pattern="*.csv")

first <- read.csv(paste0("data/",temp[1]))
first$X <- NULL
first$NA. <- NULL

for(i in 2:16) {
  currentDF <- read.csv(paste0("data/",temp[i]))
  first <- rbind(first, currentDF)
  print(paste("finished",i))
}




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
