
library(shinydashboard)

fluidPage(

    titlePanel("NHS-R FOMO killer"),

    sidebarLayout(
        sidebarPanel(
        ),

        mainPanel(
            htmlOutput("tweetText")
        )
    )
)