library(tidyverse)
library(nycflights23)

## Data sets in package ‘nycflights13’:
  
# airlines             Airline names.
# airports             Airport metadata
# flights              Flights data
# planes               Plane metadata.
# weather              Hourly weather data

df <- tibble(flights)

# Top 10 airlines fly to nyc?

df %>%
   select(carrier) %>%
   count(carrier) %>%
   right_join(airlines) %>%
   arrange(-n) %>%
   rename("total_flights" = "n") %>%
   head(10) %>%
   tibble()

ggplot(flights,
       aes(carrier, month))

# 10 Farthest Flights

farthest_flights <-
df %>%
  select(carrier, origin, dest, air_time, distance) %>%
  arrange(-distance) %>%
  right_join(airlines) %>%
  distinct(carrier,distance) %>%
  right_join(airlines) 



# Which months have the most frequent flight in the year

flights_by_month <- df %>%
                        select(carrier, month) %>%
                        count(month) %>%
                        rename("total_flights" = "n")


ggplot(flights_by_month, aes(x = month, y = total_flights)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Total Flights per Month", x = "Month", y = "Total Flights") +
  scale_x_continuous(breaks = seq(1, 12), labels = month.abb) +
  theme_minimal()
                       


       
# Delay flights, how many minutes, which airlines

df %>%
  select(carrier, flight, dep_delay, origin, dest) %>%
  left_join(airlines) %>%
  arrange(-dep_delay) %>%
  tibble() %>%
  head(20)


# Earliest flights, how many minutes, and which airlines?
df %>%
  select(carrier, flight, arr_delay, origin, dest) %>%
  left_join(airlines) %>%
  arrange(arr_delay) %>%
  tibble() %>%
  head(20)


## Busiest airports

df %>%
  select(origin, dest) %>%
  count(origin) %>%
  arrange(-n) %>%
  left_join(airports, by=c("origin" = "faa")) %>%
  rename("total_flights" = "n")
  
