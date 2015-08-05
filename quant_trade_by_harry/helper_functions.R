filter_symbols <- function(tickers){
  #' <summary>
  #'  <purpose>Convert to uppercase if not. And remove any non valid symbols</purpose>
  #'  <params>
  #'    <param name="tickers" type="vector">Stock indicators</param>
  #'  </params>
  #'  <returns>Vector of valid symbols</returns>
  #' </summary>

  #Convert the symbols to uppercase
  mySymbols <- toupper(tickers)
  
  #Validate the symbol name
  valid <- regexpr("^[A-Z]{2,4}$", tickers)
  
  #Return only the valid ones
  return(sort(tickers[valid==1]))
}


ohlc_data_from_yahoo <- function(tickers,from_date, to_date){
  #' <summary>
  #'  <purpose>Get the OHLC trade data for the given valid symbols and between the given from and to dates.</purpose>
  #'  <params>
  #'    <param name="tickers" type="vector"/>
  #'    <param name="from_date" type="string"/>
  #'    <param name="to_date" type="string"/>
  #'  </params>
  #'  <returns>Vector of valid symbols</returns>
  #' </summary>
  
  #Filter the symbols
  tickers <- filter_symbols(tickers)
  fromdate <- ymd(from_date)
  todate <-  ymd(to_date)
  retList <- lapply(tickers, 
                    function(ticker){ 
                      as.xts(
                          na.omit(getSymbols(ticker,src="yahoo", 
                                                from=fromdate,to=todate, 
                                                auto.assign = FALSE)))
                     })
}
