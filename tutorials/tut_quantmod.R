require(quantmod)
require(TTR)

# 1. setup source lookup
lkupSource <- list(Yahoo="yahoo", Google="google", Fred ="FRED", Oanda ="Oanda")

# 2. setup symbols list
setSymbolLookup(Apple=list(name="AAPL", src=lkupSource$Yahoo)) 
setSymbolLookup(Yahoo=list(name="YHOO", src=lkupSource$Yahoo)) 
setSymbolLookup(Google=list(name="GOOG", src=lkupSource$Yahoo)) 
setSymbolLookup(SP500=list(name="GSPC", src=lkupSource$Yahoo)) 
setSymbolLookup(DTB3=list(name="DTB3", src=lkupSource$Fred)) 
setSymbolLookup(UNRATE=list(name="UNRATE", src=lkupSource$Fred)) 
setSymbolLookup(SBUX=list(name="SBUX", src=lkupSource$Yahoo)) #Starbucks Corporation
# non OHLC data
setSymbolLookup(XPTUSD=list(name="XPT/USD",src=lkupSource$Oanda))

# 3.getSymbols
## get xts(extensible Time Series)OHLC data for Apple
getSymbols(c("Apple"))
## view the summary - head and tail equivalent
first(APPLE, 10);last(APPLE, 10);
##use the xts extractor function by col prefix Op,Hi,Lo,Cl,Vo,Ad,HLC,OHLC 
first(Cl(APPLE), 10);first(Op(APPLE), 10);first(HLC(APPLE), 10);first(OHLC(APPLE), 10);first(Vo(APPLE));

# 4.chartSeries
chartSeries(APPLE, subset = "2015", theme = "white")
## configurable theme
whiteTheme <- chartTheme("white")
names(whiteTheme)
whiteTheme$bg.col<- "white"
whiteTheme$dn.col<- "red"
whiteTheme$up.col<- "green"
whiteTheme$border <- "lightgray"

# 5.Subsetting
## draw chart- subset of last 3 months -  no volume subgraph -with witeTheme
last3monthCharg<- chartSeries(APPLE, subset = "last 3 months", theme= whiteTheme, TA= NULL)
class(last3monthCharg)
## chartSeries by monthly
chartSeries(to.monthly(APPLE),up.col = "white", dn.col = "red")
##.xts can be easily subsetting the dataset
## get the 2015 data
chartSeries(APPLE["2015"])
## get the 2012 to 2015 data
chartSeries(APPLE["2012::2015"])
## get the 2015 June data
chartSeries(APPLE["201506"])
## get the 2015 April to June data
chartSeries(APPLE["201504::201506"])

#6. Date and Time introduction
# Date object is stored internall as the number of days since 1970-01-01
myDate <- Sys.Date();myDate; as.integer(myDate);
# Time is stored internally either in POSIXct(since 1970-01-01)  or POSIXlt(list of 9 date time components)
myTime <- Sys.time(); myTime; class(myTime); unclass(myTime); sapply(unclass(as.POSIXlt(myTime)), function(x) x);  

#7 Get historic data and return a time-date class for Starbucks Corporation
#unadjusted historical
getSymbols(c("SBUX"), from="2005-01-01", index.class=c("POSIXt","POSIXct"))
first(OHLC(SBUX), 10); head(index(SBUX)); class(index(SBUX));
chartSeries(SBUX); #unadjusted data

#8 get splits, dividends, adjustOHLC
sbux.splits <- getSplits("SBUX")
sbux.dividends <- getDividends("SBUX")
sbux.exactOHLC <- adjustOHLC(SBUX)
sbux.adjustedOHLC <- adjustOHLC(SBUX,use.Adjusted = TRUE)
#adjusted historical
getSymbols(c("SBUX"), from="2005-01-01", index.class=c("POSIXt","POSIXct"), adjust=TRUE)


#9 getting FRED - Federal Reserve Economic Data
#gettting 3 months T-Bill data
getSymbols(c("DTB3"))
first(DTB3,10);last(DTB3,10); chartSeries(DTB3["2015"]);
#gettting unemployment rate data
getSymbols(c("UNRATE"))
first(UNRATE,10);last(UNRATE,10); chartSeries(UNRATE["2015"]);

#10 other charts
barChart(APPLE["2015"])
## candleChart : Add multi-coloring and change background to white
candleChart(APPLE["201506"], multi.col = TRUE)

#11 Technical Indicators using TTR package - Moving Averages, Oscillators, Price Bands, Trend Indicators
#Ref :Technical Analysis from A to Z by Steven Achelis
#a. add TA after creating the chart
chartSeries(APPLE["2015"],up.col = "white", dn.col = "red")
addMACD()#addMACD() moving average convergence and divergense
addBBands() # add bollinger bands
#b. add TA in the chart command itself
chartSeries(APPLE["2015"], TA= 'addBBands();addBBands(draw="p");addVo()' )
#c. calculate TAs
#Bollinger Bands
apple.bolingerBands2015 <- BBands(HLC = HLC(APPLE["2015"]), n=20, sd=2); tail(apple.bolingerBands2015);
#MACD
apple.macd <- MACD(Cl(APPLE["2015"]),12,26,9,maType="EMA"); tail(apple.macd)
chartSeries(APPLE["2015"], TA= 'addMACD()' )
#RSI
apple.rsi <- RSI(Cl(APPLE["2015"]),n=14) ; tail(apple.rsi)
chartSeries(APPLE["2015"], TA= 'addRSI()' )

#11 Experimental chart_series
chart_Series(APPLE["2015"], TA= 'add_BBands()')