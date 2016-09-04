####
# prep-traffic-data.R
###

setwd("~/Documents/SD-open-data/")

df = read.csv("./data/traffic_counts.csv", header = TRUE, stringsAsFactors = FALSE)

library(dplyr)


df %>%
  group_by(street_name) %>%
  summarise(total_counts = sum(total_count),
            uniq.dates = length(unique(count_date))) %>%
  as.data.frame() -> df.agg

df %>%
  group_by(street_name, count_date) %>%
  summarise(total_counts = sum(total_count)) %>%
  as.data.frame() -> df.date.agg

df %>%
  group_by(street_name, limits) %>%
  summarise(total_counts = sum(total_count),
            uniq.dates = length(unique(count_date))) %>%
  as.data.frame() -> df.street.limits

library(plotly)

ggplot(df.street.limits, aes(x = street_name, y = uniq.dates, label = limits)) + geom_point() -> p

write.csv(df.agg, file = "./data/traffic_counts_aggregated.csv", quote = FALSE, row.names = FALSE)
