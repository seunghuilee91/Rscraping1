# R scraping with R selenium

* Gecko driver download url as below
https://github.com/mozilla/geckodriver/releases/tag/v0.17.0

* chromedriver download url as below
https://sites.google.com/a/chromium.org/chromedriver/

* selenium download url as below
https://www.seleniumhq.org/download/

* CMD 
cd C:\selenium
java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.8.1.jar -port 4445 (up to version that you got)
for me it works as java -Dwebdriver.gecko.driver="geckodriver.exe" -jar selenium-server-standalone-3.141.59.jar -port 4445


# WordCloud
# KoNLP
remD <- remoteDriver(port=4445L, browserName="chrome")
remD$open()
title_forme <- "광군절" 
 remD$navigate(paste0("https://www.youtube.com/results?search_query=",title_forme))
 html <- remD$getPageSource()[[1]]
 html <- read_html(html)
 youtube_title <- html %>% html_nodes("#video-title") %>% html_text()
 youtube_title[1:10]
 youtube_title <- gsub("\n", " ", youtube_title)
 youtube_title <- trimws(youtube_title)
 youtube_title[1:10]
noun_yt <- extractNoun(youtube_title)
noun_yt <- table(unlist(noun_yt))
noun_yt <- as.data.frame(noun_yt)
noun_yt <- rename(noun_yt,
 word = Var1, 
 freq = Freq
)
noun_yt$word <- as.character(noun_yt$word)
top_50 <- noun_yt %>%
 filter(nchar(word)>=2) %>% 
 arrange(desc(freq)) %>% 
 head(50)
top_50
wordcloud2(top_50, color = "random-light", backgroundColor = "grey",fontFamily = 'HY견고딕')

* <b> result as http://localhost:23027/session/viewhtml3183acb18b3/index.html </b>

# JiebaR

seg <- qseg[product_title]
seg <- seg[nchar(seg)>1]
seg <- table(seg)
seg <- sort(seg, decreasing = TRUE)
wordcloud2(seg, color = "random-light", backgroundColor = "grey")

* referto https://blog.csdn.net/songzhilian22/article/details/49184047
* <b> result as http://localhost:23027/session/viewhtml318474d7d30/index.html </b>
