
library(rtweet)
library(tidyverse)
library(wordcloud)
library(tm)
library(shinydashboard)

if(file.info("tweetData.Rdata")$mtime < Sys.time() - 3600){
  
  tweets <- search_tweets(q = "NHSRconf2019", n = 1000)
  
  save(tweets, file = "tweetData.Rdata")
} else {
  
  load("tweetData.Rdata")
}

function(input, output) {
  
  twentyFourHourTweets <- reactive({
    
    tweets %>% 
      filter(created_at > Sys.time() - 60 * 60 * 24)
  })
  
  output$numberOfTweets <- renderValueBox({
    
    valueBox(
      nrow(twentyFourHourTweets()), 
      HTML("Number of tweets in <br>last 24 hours"), 
      icon = icon("clock"),
      color = "green"
    )
  })
  
  output$mostFavourites <- renderValueBox({
    
    valueBox(
      sum(twentyFourHourTweets()$favorite_count), 
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
  
  # user tab
  
  output$numberOfUsers <- renderValueBox({
    
    twenty_four_hour_users <- twentyFourHourTweets() %>% 
      filter(created_at > Sys.time() - 60 * 60 * 24) %>% 
      group_by(screen_name) %>% 
      nrow()

    valueBox(
      twenty_four_hour_users, 
      HTML("Number of users<br>in last 24 hours"), icon = icon("clock"),
      color = "red"
    )
  })
  
  output$topTweeter <- renderValueBox({
    
    top_tweeter <- twentyFourHourTweets() %>% 
      group_by(screen_name) %>% 
      count() %>% 
      ungroup() %>% 
      arrange(desc(n)) %>% 
      slice(1) %>% 
      pull(screen_name)
    
    valueBox(
      top_tweeter, 
      HTML("Top tweeter<br>in last 24 hours"), icon = icon("smile"),
      color = "green"
    )
  })
  
  # wordcloud plot
  
  output$wordCloudPlot <- renderPlot({
    
    tweets_processed <- gsub("nhsrconf2019", "", tweets$text,
                             ignore.case = TRUE)
    
    wordcloud(tweets_processed,
              random.color = TRUE)
  })
  
}
