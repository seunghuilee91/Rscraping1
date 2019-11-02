
library(httr)
library(rvest)
library(dplyr)
library(RSelenium)

remD <- remoteDriver(port=4445L,
 browserName="chrome")

remD$open()

title_shampoo <- "á©???â©"

remD$navigate(paste0("https://list.tmall.hk/search_product.htm?q=",title_shampoo))

html <- remD$getPageSource()[[1]]
html <- read_html(html)

tmall_title <- html %>% html_nodes(xpath = '//*[@id="J_ItemList"]/div/div/div/a') %>% html_text()


tmall_ti?le[1:10]

tmall_title <- gsub("\n","",tmall_title)
tmall_title <- trimws(tmall_title)
tmall_title[1:30]

tmall_title <- html %>% html_nodes(xpath = '//*[@id="J_ItemList"]/div/div/div[2]/a') %>% html_text()
tmall_title <- gsub("\n","",tmall_title)
tmall_tit?e <- trimws(tmall_title)
tmall_title[1:10]

