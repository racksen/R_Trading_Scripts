#CNX IT index stocks list
#NSE accepts download if the request contains useragent entry
#Therefore, downloading it through RCurl with useragent setting
require(dplyr)
require(plyr)
require(RCurl)

#There are many type of indexes exist in NSE. 
#Ref:http://www.nse-india.com/products/content/equities/indices/about_indices.htm
nse.indexDF <- as.data.frame(read.csv("./data/nse_index_list.csv"))
nse.indexStocksDF <- data.frame()
head(nse.indexDF)
lapply(head(nse.indexDF,n=2), function(nseIndex){
  #if(nseIndex["INDEX_STOCK_LIST_URL"]!=""){
    csvData <- getURL(nseIndex["INDEX_STOCK_LIST_URL"],useragent= getOption("HTTPUserAgent"))
    indexStocks <- read.csv(textConnection(csvData))
    indexStocks["INDEX_NAME"] <- nseIndex["INDEX_NAME"]
    nse.indexStocksDF<-rbind.fill(nse.indexStocksDF,indexStocks)
  #}
})

csvData <- getURL("http://www.nse-india.com/content/indices/ind_niftylist.csv",useragent= getOption("HTTPUserAgent"))
indexStocks <- read.csv(textConnection(csvData))



# nse.indexStocksDF <- "http://www.nse-india.com/content/indices/ind_cnxitlist.csv"
# 
# #Define the url content with useragent entry
# csvData <- getURL(cnxIT.stocksFileURL,useragent= getOption("HTTPUserAgent"))
# #Read the csv using textconnection
# cnxIT.stocksCSV <- read.csv(textConnection(csvData))
# 
# #Convert into dplyr, just in case
# cnxIT.stocksDF <- tbl_df(cnxIT.stocksCSV) 
# cnxIT.stocksCSV <- getURLContent(cnxIT.stocksFileURI,useragent= getOption("HTTPUserAgent"),verbose = TRUE)
# cnxIT.stocks <- tbl_df(read.table(cnxIT.stocksFileURI))
# cnxIT.stocks
