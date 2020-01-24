# rselenium scraping 

library(tidyverse)
library(httr)
library(rvest)
library(dplyr)
library(RSelenium)
library(xml2)
library(stringr)
library(wordcloud2)
library(KoNLP)
remD <- remoteDriver(port=4445L, browserName="chrome")
remD$open()
remD$navigate("htt?s://www.nejm.org/toc/nejm/381/1")
html <- remD$getPageSource()[[1]]
html

a <- list()
b <- list()
for(i in 1:26){
 req_url <- paste0('https://www.nejm.org/toc/nejm/381/',i)
 req <- read_html(req_url)
 article <- req %>% html_nodes(xpath = '//*[contains(con?at( " ", @class, " " ), concat( " ", "f-h4", " " ))]') %>% html_text()
 author <- req %>%  html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "f-author", " " ))]') %>% html_text()
 if(length(req)==0) break
 a <- c(a, article)
 b <- c?b, author)
 print(i)
}


a
b


a <- gsub("\n", " ", a)
a <- gsub("and", " ", a)
a <- gsub("of", " ", a)
a <- gsub("if", " ", a)
a <- gsub("for", " ", a)
a <- gsub("in", " ", a)
a <- gsub("the", " ", a)
a <- gsub("from", " ", a)
a <- gsub("about", " ", a)
a?<- gsub("with", " ", a)
a <- gsub("that", " ", a)
a <- gsub("that", " ", a)
a <- gsub("Year", " ", a)
a <- gsub("[0-9]", " ", a)


a <- trimws(a)
Noun <- extractNoun(a)
Noun
Noun <- table(unlist(Noun))
Noun <- as.data.frame(Noun)
Noun <- rename(Noun,
 word?= Var1,
 freq = Freq
)
Noun$word <- as.character(Noun$word)

gg <- Noun %>%
 filter(nchar(word)>=4) %>%
 arrange(desc(freq)) %>%
 head(15)
ggplot(gg, aes(x= word, y=freq))+geom_col(stat = identity)

top_200 <- Noun %>%
 filter(nchar(word)>=4) %>%
 arrange(?esc(freq)) %>%
 head(200)
top_200 <- as.data.frame(top_200)

wordcloud2(top_200, color = "random-light", backgroundColor = "grey")

remD$close
