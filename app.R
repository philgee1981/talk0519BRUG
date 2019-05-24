#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

get_image<-function(coin){
  test <- jsonlite::read_json('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=3&page=1&sparkline=true&price_change_percentage=24h', simplifyVector = T)
  test$last_updated <- as.POSIXct(sapply(1:nrow(test),FUN=function(X) as.POSIXct(test$last_updated[X],format = '%Y-%m-%dT%H:%M:%OSZ')),origin='1970-01-01')
  i<-which(test$name==coin)
  temp<-xts::xts(test$sparkline_in_7d[[1]][[i]],
                 order.by= seq(test$last_updated[i]-(length(test$sparkline_in_7d[[1]][[i]])-1)*3600,test$last_updated[i],3600))
  plot(temp,main=test$name[i])
}
ui <- navbarPage("BTC-ECHO",
                 tabPanel("Title",titlePanel("R as a workhorse for presenting financial Data to Bitcoin enthusiasts"),img(src='title.png', align = "center")),
                 tabPanel("About me", sidebarPanel(includeMarkdown("about.md")),
                 mainPanel(img(src='Phil.png', align = "center",width=500))),
                 tabPanel("Goal",sidebarPanel(includeMarkdown("goals.md")),
                          mainPanel(img(src='goal.png', align = "center",width=500))),
                 tabPanel("Idea",sidebarPanel(includeMarkdown("idea.md")),
                          mainPanel(img(src='idea.png', align = "center",width=700))),
                 tabPanel("Fetching data",sidebarPanel(includeMarkdown("fetch.md"),textAreaInput("text1",rows=10,label = h3("Code input"), value = "data_raw <- jsonlite::read_json('https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=3&page=1&sparkline=true&price_change_percentage=24h', simplifyVector = T)
data_raw"),
                          actionButton("goButton1", "Eval")),
                          mainPanel(fluidRow(verbatimTextOutput("value1")))),
                 tabPanel("Generating images", sidebarPanel(selectInput("coin","Cryptocurrency",c("Bitcoin","Ethereum","XRP")),textAreaInput("text5",rows=10,label = h3("Code input"), 
                                value = "data_raw$last_updated <- as.POSIXct(sapply(1:nrow(data_raw),FUN=function(X) as.POSIXct(data_raw$last_updated[X],format = '%Y-%m-%dT%H:%M:%OSZ')),origin='1970-01-01')
for(i in 1:nrow(data_raw)){
     temp<-xts::xts(data_raw$sparkline_in_7d[[1]][[i]],
     order.by= seq(data_raw$last_updated[i]-(length(data_raw$sparkline_in_7d[[1]][[i]])-1)*3600,data_raw$last_updated[i],3600))
     png(paste(data_raw$id[i],'.png',sep=''),width=900,height=300,pointsize=25)
     print(plot(temp,main=data_raw$name[i]))
     dev.off()
}
file.info(list.files(pattern = 'png'))[,c(1,4)]"),
                                                            actionButton("goButton5", "Eval"),
                                includeMarkdown("generate_image_1.md")),
                          mainPanel(plotOutput("genpic"),
                                    fluidRow(verbatimTextOutput("value5")))),
                 tabPanel("Wordpress", includeMarkdown("Wordpress.md")),
                 tabPanel("Sending images", sidebarPanel(textAreaInput("text6",rows=10,label = h3("Code input"), 
                                                       value = "for(i in 1:nrow(data_raw)){
  command<-paste('curl --request POST --url https://https://url_to_your.blog/wp-json/wp/v2/media --header \"authorization: Basic Your_token_here\" --header \"content-disposition: attachment; filename=',data_raw$id[i],'.png; \" --header \"content-type: image/png\" --data-binary \"@\',data_raw$id[i],'.png\"',sep='')
  out<-system(command,intern = T)
  data_raw$image[i]<-jsonlite::fromJSON(out)$id
  system(paste('rm ',data_raw$id[i],'.png',sep=''))
                                                       }
print(out)
print(data_raw$image) 
file.info(list.files(pattern = 'png'))[,c(1,4)]
                                                      "),
                                                            actionButton("goButton6", "Eval"),
                                                         includeMarkdown("generate_image_2.md")),
                          mainPanel(fluidRow(verbatimTextOutput("value6")))),
                 tabPanel("Selecting data", sidebarPanel(textAreaInput("text2",rows=10,label = h3("Code input"), value = "data_raw$image<-c(71692,71693,71694)
data_all<-data_raw[,c(3,1,4,5,8,9,10,12)]
data_all"),
                                                          actionButton("goButton2", "Eval")),
                          mainPanel(fluidRow(verbatimTextOutput("value2")))),
                 tabPanel("Generating text",sidebarPanel(textAreaInput("text3",rows=10,label = h3("Code input"), value = "texte <- read.csv('Kursbeschreibungen.csv')
data_all$structure[abs(data_all[,8])< 1] <- sample(as.character(texte$description[texte$sentiment=='flat']),nrow(data_all[abs(data_all[,8])<1,]),replace = F)
data_all$structure[data_all[,8]< -1] <- sample(as.character(texte$description[texte$sentiment=='down']),nrow(data_all[data_all[,8]< -1,]),replace = F)
data_all$structure[data_all[,8]> 1] <- sample(as.character(texte$description[texte$sentiment=='up']),nrow(data_all[data_all[,8]> 1,]),replace = F)
data_all$sentence <- paste(data_all$structure,sample(as.character(texte$description[texte$sentiment=='price']),nrow(data_all),replace = F))
data_all[,10] <- sapply(1:nrow(data_all), FUN=function(X) gsub('XXX',data_all[X,1],data_all[X,10]))
data_all[,10] <- sapply(1:nrow(data_all), FUN=function(X) gsub('YYY',round(abs(data_all[X,8])),data_all[X,10]))
data_all[,10] <- sapply(1:nrow(data_all), FUN=function(X) gsub('TTT',round(data_all[X,8]),data_all[X,10]))
data_all[,10] <- sapply(1:nrow(data_all), FUN=function(X) gsub('ZZZ',format(round(as.numeric(data_all[X,4]),digits=2),nsmall=2),data_all[X,10]))

data_all
text_final<-paste(sapply(1:nrow(data_all), FUN=function(X) paste('<h2>',data_all[X,1],' <img class=\"alignnone size-large wp-image-',data_all[X,3],'\" src=\"https://url_to_your.blog/wp-content/uploads/2019/05/',data_all[X,2],'.png\" /></h2><br>',data_all[X,10],'<br><ul><li>24h-High: USD ',format(round(data_all[X,6],2),nsmall=2),'</li><li>24-h-Low: USD ',format(round(data_all[X,7],2),nsmall=2),'</li><li>Trading Volume: USD ',format(round(data_all[X,5]/10^9,2),nsmall=2),' bln</li></ul><br>',sep='')),sep='',collapse='<br><br>')
text_final                                                                       "),
                                                         actionButton("goButton3", "Eval")),
                          mainPanel(fluidRow(verbatimTextOutput("value3")))),
                 tabPanel("Writing Post",sidebarPanel(textAreaInput("text4",rows=10,label = h3("Code input"), value = 'header<- "--header \'Authorization: Basic Your_token_here\'"
thumbnail<-66507
title<- "\'title=Price update for Bitcoin, Ethereum and XRP\'"
url <- paste("-d \'slug=bitcoin-ethereum-ripple-",Sys.Date(),"\'",sep="")
content<-paste("Within the last 24 hours, the cryptocurrencies behaved as follows:<br>",text_final,sep="")
excerpt<- "-d \'excerpt=Lets look at the price developments of the top three cryptocurrencies\'"
command<-paste("curl ",header," -X POST -d ",title," -d \'status=publish\' -d \'content=",content,"\' -d \'featured_media=",thumbnail,"\' -d \'author=4328\' ",url," ",excerpt," https://url_to_your.blog/wp-json/wp/v2/post_type",sep="")
out<-system(command,intern=T)
print(out)'),
                                                      actionButton("goButton4", "Eval")),
                          mainPanel(fluidRow(verbatimTextOutput("value4")))),
                 tabPanel("R on Heroku",includeMarkdown("Heroku.md")),
                 tabPanel("Outlook",includeMarkdown("outlook.md"))
)

server <- function(input, output) {
  
  output$value1<-renderPrint(eval(parse(text=texteval1())))
  texteval1<-eventReactive(input$goButton1, {
    input$text1
  })
  output$value2<-renderPrint(eval(parse(text=paste(texteval1(),texteval2(),sep="\n"))))
  texteval2<-eventReactive(input$goButton2, {
    input$text2
  })
  output$value3<-renderPrint(eval(parse(text=paste(texteval1(),texteval2(),texteval3(),sep="\n"))))
  texteval3<-eventReactive(input$goButton3, {
    input$text3
  })
  output$value4<-renderPrint(eval(parse(text=paste(texteval1(),texteval2(),texteval3(),texteval4(),sep="\n"))))
  texteval4<-eventReactive(input$goButton4, {
    input$text4
  })
  output$value5<-renderPrint(eval(parse(text=paste(texteval1(),texteval5(),sep="\n"))))
  texteval5<-eventReactive(input$goButton5, {
    input$text5
  })
  output$value6<-renderPrint(eval(parse(text=paste(texteval1(),texteval5(),texteval6(),sep="\n"))))
  texteval6<-eventReactive(input$goButton6, {
    input$text6
  })
  output$genpic<-renderPlot(get_image(input$coin))
  autoInvalidate <- reactiveTimer(10000)
  observe({
    autoInvalidate()
    cat(".")
  })  
  }

# Run the application 
shinyApp(ui = ui, server = server)

