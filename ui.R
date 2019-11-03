
library(shinydashboard)

dashboardPage(
    dashboardHeader(title = "NHS-R FOMO killer"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Tweets", tabName = "tweets", icon = icon("bird")),
            menuItem("Users", tabName = "users", icon = icon("user")),
            menuItem("Wordcloud", tabName = "wordcloud", icon = icon("cloud"))
        )),
    
    dashboardBody(
        
        tabItems(
            tabItem("tweets",
                    fluidRow(
                        
                        valueBoxOutput("numberOfTweets"),
                        valueBoxOutput("mostFavourites")
                    ),
                    
                    fluidRow(
                        
                        box(title = HTML("Ten most recent"), width = 6, 
                            solidHeader = TRUE,
                            status = "success",
                            htmlOutput("recentText")),
                        
                        box(title = "Ten most favourited", width = 6, 
                            solidHeader = TRUE,
                            status = "danger",
                            htmlOutput("favouriteText"))
                    )
            ),
            tabItem("users",
                    fluidRow(
                        
                        valueBoxOutput("numberOfUsers"),
                        valueBoxOutput("topTweeter", width = 6)
                    )
            ),
            tabItem("wordcloud",
                        plotOutput("wordCloudPlot")

            )
        )
    )
)
