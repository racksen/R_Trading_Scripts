# POSITIVE TESTS FOR => "filter_symbols"
filter_symbols.input <- c("MOT", "cvx", "123", "Gog2", "XLe")
filter_symbols.output <- c("CVX","MOT","XLE")
expect_that(filter_symbols(filter_symbols.input),equals(filter_symbols.output))