
library(rtweet)
library(tidyverse)

# tweets <- search_tweets(q = "rstats", n = 100)
# 
# save(tweets, file = "tweetData.Rdata")

load("tweetData.Rdata")

function(input, output) {

    output$tweetText <- renderText({
        
        paste0("<p>", tweets$screen_name, ": ", tweets$text, "</p>")
    })

}
