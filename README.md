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

* CODE 
remD <- remoteDriver(port=4445L, browserName="chrome")
remD$open()
remD$navigate(url)


# PHANTOMJS - CHEAT-KEY!
pJS <- wdman::phantomjs(port=4567L) 
remDr <- remoteDriver(port=4567L, browserName='phantomjs')
remDr$open()
remDr$navigate(url)
remDr$screenshot(display = T)
html <- remDr$getPageSource()[[1]]



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


# WordCloud
1. 설치
Wordcloud2는 Github를 통해서 설치합니다.
require(devtools)
install_github("lchiffon/wordcloud2")	
 

2. 기능
wordcloud2는 크게 2가지의 기능을 제공합니다.

1) Wordcloud2 : 전통적인 워드 클라우드
전통적인 워드 클라우드의 형태(원 혹은 타원형) 로 워드클라우드를 만듭니다. 특이점은 별도의 파라미터 조작이 없어도 HTML5로 저장한다면 반응형 워드클라우드가 생성된다는 점 입니다.

library(wordcloud2)
wordcloud2(data = demoFreq)

WordCloud2에서 추가된 기능인 이미지 파일을 마스크로 사용하여 이미지 파일에 워드 클라우드를 생성할 수도 있습니다. 단, 이미지 파일에 단어가 들어갈 곳이 진한 색으로 되어 있어야 한다는 점 입니다.

figpath 파라미터를 사용하면 이미지 파일 위에 워드클라우드를 그릴 수 있습니다. 그러나 figpath를 사용하려면 아래 패키지를 추가로 설치해야 잘 동작한다고 합니다.

 
실습에 사용될 파일
install.packages("htmlwidgets")
install.packages("tmltools")
install.packages("jsonlite")
install.packages("yaml")
install.packages("base64enc")
라이브러리를 모두 로딩하고 명령어를 사용하여 워드클라우드를 만듭니다.

library(wordcloud2)
library(htmlwidgets)
library(tmltools)
library(jsonlite)
library(yaml)
library(base64enc)
워드클라우드를 만듭니다.

figPath = system.file("examples/football.png",package = "wordcloud2")
wordcloud2(demoFreq, figPath = figPath, size = 1.5,color = "skyblue")

 

(컴퓨터 사양을 많이 탑니다... 많이 느려요)

2) letterCloud : 문자, 단어로 워드 클라우드
letterCloud(demoFreq, word = "R", size = 2)


3. 파라미터
data : 각 열에 word와 freq가 포함 된 데이터 프레임
size : 글꼴 크기, 기본값은 1. 큰 크기는 큰 단어를 의미
fontFamily : 사용할 글꼴.
fontWeight : 사용할 폰트의 무게 (예 : normal, bold or 600)
color : 텍스트의 색상, 'random-dark'및 'random-light'키워드를 사용할 수 있습니다. Color Vector 도 사용할 수 있습니다.
minSize : 자막의 문자열
backgroundColor : 배경색.
gridSize : 캔버스의 가용성을 표시하기 위한 그리드의 크기 (픽셀 단위) 그리드 크기가 클수록 단어 사이의 간격이 커집니다.
minRotation :단어가 회전해야 하는 경우 텍스트가 회전해야하는 최소 회전 (라디안 값)입니다.
maxRotation : 단어가 회전해야하는 경우 텍스트가 회전해야하는 최대 회전 (rad). 모든 텍스트를 한 각도로 유지하는 것과 동일한 두 값을 설정하십시오.
rotateRatio : 단어가 회전 할 확률. 항상 회전하려면 숫자를 1로 설정하십시오.
shape : 그릴 모양의 "구름". 키워드 선물이 될 수 있습니다. 사용할 수있는 선물은 '원형'(기본값), '카디오이드'(사과 또는 심장 모양 곡선, 가장 잘 알려진 극형 방정식), '다이아몬드'(별의 사각형), '삼각형 앞으로', '삼각형', ' 및 '별'.
ellipticity : degree of “flatness” of the shape wordcloud2.js should draw
figPath : 단어 구름에 사용되는 그림.
widgetsize : 위젯의 크기
