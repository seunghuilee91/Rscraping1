url <- "https://www.bluer.co.kr/search?searchMode=ribbonType#filter-restaurant"
remD <- remoteDriver(port=4445L, browserName="chrome")
remD$open()
remD$navigate(url)

webElem = remD$findElement(using = 'css selector', "#page-selection > ul > li:nth-child(3? > a")
webElem$clickElement()
remD$screenshot(display = T)

front <- "#page-selection > ul > li:nth-child("
back <- ") > a"

all_restautant <- c() 
for(i in 1:100){
webElem_blue = remD$findElement(using = 'css selector', paste0(front, i, back))
webElem_blu?$clickElement()
remD$getPageSource()[[1]] %>% 
 read_html() %>% 
 html_nodes(".anchor-restaurant-detail") %>% 
 html_text() %>% 
 unique() %>% 
 trimws() -> restaurant
all_restautant <- c(all_restautant, restaurant)}

all_reviews <- c() 
for(i in 1:100){
 ?ebElem_blue = remD$findElement(using = 'css selector', paste0(front, i, back))
 webElem_blue$clickElement()
 remD$getPageSource()[[1]] %>% 
  read_html() %>% 
  html_nodes(".content") %>%
  html_text() %>% 
  unique() %>% 
  trimws() -> reviews
 all_review? <- c(all_reviews, reviews)}


all_info <- c() 
for(i in 1:100){
 webElem_blue = remD$findElement(using = 'css selector', paste0(front, i, back))
 webElem_blue$clickElement()
 remD$getPageSource()[[1]] %>% 
  read_html() %>% 
  html_nodes("div.info") %>% 
? html_text() %>% 
  unique() %>% 
  trimws() -> info
 all_info <- c(all_info, info)}
gsub("전화\n", " ", all_info) -> all_info  
gsub("주소\n", " ", all_info) -> all_info 
gsub("\n", " ", all_info) -> all_info 
gsub("^ +", "", all_info) -> all_info 

df <-?cbind(all_restautant,all_info,all_reviews)

view(df)

