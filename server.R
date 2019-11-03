
library(rtweet)
library(tidyverse)

# tweets <- search_tweets(q = "NHSRconf2019", n = 100)
# 
# save(tweets, file = "tweetData.Rdata")

load("tweetData.Rdata")

function(input, output) {
  
  output$numberOfTweets <- renderValueBox({
    
    tweet_df <- tweets %>% 
      filter(created_at > Sys.time() - 60 * 60 * 24)
    
    valueBox(
      nrow(tweet_df), HTML("Number of tweets in <br>last 24 hours"), icon = icon("clock"),
      color = "green"
    )
  })
  
  output$mostFavourites <- renderValueBox({
    
    tweet_df <- tweets %>% 
      filter(created_at > Sys.time() - 60 * 60 * 24)
    
    valueBox(
      sum(tweet_df$favorite_count), 
      HTML("Number of favourites<br>in last 24 hours"), icon = icon("clock"),
      color = "red"
      )
  })
  
  output$recentText <- renderText({
    
    tweet_df <- tweets %>% 
      arrange(desc(created_at)) %>% 
      slice(1 : 10)
    
    paste0("<p>", tweet_df$screen_name, ": ", tweet_df$text, "</p>")
  })
  
  output$favouriteText <- renderText({
    
    tweet_df <- tweets %>% 
      arrange(desc(favourites_count)) %>% 
      slice(1 : 10)
    
    paste0("<p>", tweet_df$screen_name, ": ", tweet_df$text, "</p>")
  })
}
