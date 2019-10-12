library(tidyverse)
library(dplyr)
library(data.table)
train_store %>% select(Store, Sales, StoreType)

train_store %>% 
  filter(StoreType == 'a') %>% 
  group_by(Store)

train_store$Year <- strftime(train_store$Date, format = "%Y", tz="tz")

#  taking a long time....
# aggregate(x= train_store, list(train_store$Store, train_store$Date), FUN ="mean")

 
#Not needed at all...
# s1 <- train_store %>% 
#   group_by(.dots = c("Store", "Year")) %>%
#   mutate(rnk = row_number(), TotalSales = sum(Sales)) 
#   # filter( rnk == max(rnk))

# unnecessary
s3 <- train_store %>% 
  group_by(.dots = c("Store", "Year"))

# s4 <- train_store %>% 
#   group_by(.dots = c("Store", "Year")) %>% 
#   summarise(Sales = 365*mean(Sales)) #Wrong because 2015 doesn't have 365 days

s4 <- train_store %>% 
  group_by(.dots = c("Store", "Year")) %>% 
  tally(Sales)

s41 <- train_store %>% 
  group_by(.dots = c("Store", "Year")) %>% 
  tally(Sales, sort = TRUE)

# top 10 sales years has average for each item

# d <- data.table(mtcars, key="cyl")
# d.out <- d[, .SD[mpg %in% head(sort(unique(mpg)), 3)], by=cyl]

# top_Sales <- s4[ s4$Sales >= s4$Sales[order(s4$Sales, decreasing=TRUE)][2] , ]

s5 <- s4 %>% 
  group_by(.dots = c("Store")) %>% 
  mutate(rank = 1:n()) %>% 
  filter( rank == c(1:2))

s51 <- s41 %>% 
  group_by(.dots = c("Store")) %>% 
  mutate(rank = 1:n()) %>% 
  filter( rank == c(1:2))

# s6 <- train_store %>% 
#   group_by(.dots = c("Store", "Year")) %>%
#   mutate(rnk = row_number(), TotalSales = sum(Sales)) %>% 
#   filter( rnk == max(rnk))

#If summation of these top stores sales is needed
s7 <- s5 %>% 
  group_by(.dots = c("Store")) %>% 
  tally(n)

# for our requirement of Averages
s8 <- s5 %>% 
  group_by(.dots = c("Store")) %>% 
  summarise(Sales = mean(n))

s81 <- s51 %>% 
  group_by(.dots = c("Store")) %>% 
  summarise(Sales = mean(n))

# Notes:
# take S1 and then s4 then s5 then s8, 
# s1 to s41: tally and total sales in that year - all the years are mentioned
# s41 to s51: introducing rankings to the years and picking top 2
# s51 to s81: selected top n stores' sales are averaged to get the golden number
