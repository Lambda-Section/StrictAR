install.packages(c("forecast", "tseries", "quantmod"))
library(forecast)
library(tseries)
library(quantmod)

# Fetch real gold price data (e.g., from Yahoo Finance)
getSymbols("GC=F", src = "yahoo", from = "2020-01-01", to = "2025-04-07")
gold_prices <- Cl(`GC=F`)  # Closing prices
ts_data <- ts(gold_prices, frequency = 252)  # Daily data, ~252 trading days/year

# Check stationarity
adf.test(ts_data)  # If p > 0.05, data is non-stationary
ts_data_diff <- diff(log(ts_data))  # Use log returns to stabilize variance

# Fit ARIMA model
fit <- auto.arima(ts_data_diff)
summary(fit)

# Forecast next 30 days
forecast_result <- forecast(fit, h = 30)
plot(forecast_result, main = "Gold Price Forecast (Log Returns)")

# Convert back to price levels (optional, approximate)
last_price <- tail(gold_prices, 1)
forecast_prices <- last_price * exp(cumsum(forecast_result$mean))
plot(forecast_prices, type = "l", main = "Approximate Gold Price Forecast")