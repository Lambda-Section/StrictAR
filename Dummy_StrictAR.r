install.packages(c("forecast", "tseries"))  # For modeling and diagnostics
library(forecast)  # For easier AR modeling and forecasting
library(tseries)   # For stationarity tests

# Generating or Loading Time Series Data
set.seed(123)  # For reproducibility
n <- 100       # Number of observations
phi <- 0.7     # AR coefficient (must be |phi| < 1 for stationarity)
error <- rnorm(n, mean = 0, sd = 1)  # White noise
y <- numeric(n)
y[1] <- error[1]  # Initial value
for (t in 2:n) {
  y[t] <- phi * y[t-1] + error[t]  # AR(1) process: y_t = phi * y_{t-1} + e_t
}
ts_data <- ts(y)  # Convert to time series object
plot(ts_data, main = "Simulated AR(1) Time Series", ylab = "Value")
#data <- read.csv("your_data.csv")
#ts_data <- ts(data$column_name, frequency = 1)  # Adjust frequency if seasonal