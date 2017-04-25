setwd("~/CMU/4 Senior Year/Spring/Data Mining/final project")

# load csv files
flights2015 <- read.csv('flights2015.csv')
flights2016 <- read.csv('flights2016.csv')
flights2016_visible <- read.csv('flights2016_visible.csv')
flights2016_guess <- read.csv('flights2016_guess.csv')

# other data
load('departures.rda')
dep2015 <- read.csv('departures2015.csv')

# remove columns that cannot be used to predict
bad_cols <- c('DEP_TIME', 'DEP_DELAY', 'DEP_DELAY_NEW', 'DEP_DELAY_GROUP', 'DEP_TIME_BLK', 'TAXI_OUT',
              'WHEELS_OFF', 'WHEELS_ON', 'TAXI_IN', 'ARR_TIME', 'ARR_DELAY', 'ARR_DELAY_NEW',
              'ARR_DELAY15', 'ARR_DELAY_GROUP', 'ARR_TIME_BLK', 'CANCELLED', 'CANCELLATION_CODE',
              'DIVERTED', 'ACTUAL_ELAPSED_TIME', 'AIR_TIME', 'CARRIER_DELAY', 'WEATHER_DELAY',
              'NAS_DELAY', 'SECURITY_DELAY', 'LATE_AIRCRAFT_DELAY', 'FIRST_DEP_TIME',
              'TOTAL_ADD_GTIME', 'LONGEST_ADD_GTIME')

for(i in 1:length(bad_cols)){
  dep2015[,bad_cols[i]] <- NULL
}

# remove NA's
dep2015 <- na.omit(dep2015)

# set delays to factor
dep2015$DEP_DEL15 <- factor(dep2015$DEP_DEL15)

# set up training and test sets
set.seed(462)
n <- sample(1:nrow(dep2015), size = nrow(dep2015)*.8, replace=FALSE)
train_2015 <- na.omit(dep2015[n,])
test_2015  <- na.omit(dep2015[-n,])