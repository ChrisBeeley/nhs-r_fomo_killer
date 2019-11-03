
library(shinydashboard)

dashboardPage(
    dashboardHeader(title = "NHS-R FOMO killer"),
    dashboardSidebar(),
    dashboardBody(
        fluidRow(
            
            valueBoxOutput("numberOfTweets"),
            
            valueBoxOutput("mostFavourites")
            
        ),
        
        fluidRow(
            # most recent
            
            box(title = HTML("Ten most recent"), width = 6, 
                solidHeader = TRUE,
                status = "success",
                htmlOutput("recentText")),
            
            box(title = "Ten most favourited", width = 6, 
                solidHeader = TRUE,
                status = "danger",
                htmlOutput("favouriteText"))
        )
    )
)
