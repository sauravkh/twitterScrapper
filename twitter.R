# Saurav Kharb
# Research Assitant
# This script makes calls on the twitteR api using tweet id's

library(twitteR)
library("httr")
library("xlsx")

# set up OAuth
consumer_key <- "aoQ1bAoMZ74pY5RsYcbKJzBUc"
consumer_secret <- "spidig71mvpnQbGOWOuBvQC8vq9wP8ax4eeV9FzjlypeHjenM9"
access_token <- "835019765508788224-WpZ2IPJgu1PKcA6w7rP628DPFystHsD"
access_secret <- "0JDPxoIQvcukZ8rqoFIDDssrxRkglWvCwdG2dtWT7D1Fu"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

oreo <- read.table("data/oreo.txt") #set appropriate path


i = 1
while(i <= 1) { # change number to the total number of id's in the file
  # uncomment to change api calls to 10 at a time
  # ids <- oreo[i,1]
  # count = 2
  # while(count < 11){
  #   ids <- c(ids, oreo[count,1]) 
  #   count <- count + 1
  # }
  # print(ids)
  tryCatch({
    # call api for 10 ids at a time 
    tweet <- showStatus(oreo[i,1])
    data <- as.data.frame(tweet)
    write.table(data, "data/oreo.txt")
    write.xlsx(data, "data/oreo.xlsx")
  })
  
  i <- i + 1 # cahnge to 10 if making 10 calls at a time
}







