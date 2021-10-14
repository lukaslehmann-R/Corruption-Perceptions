library(tidyverse)
library(ggplot2)
library(dplyr)
library(tidytext)
library(ggthemes)
library(lubridate)
library(janitor)
library(plotly)
library(readr)
library(stringr)

library(devtools)
devtools::install_github("jaredhuling/jcolors")
library(jcolors)

data <- read_csv("CPI Time Series.csv")

test2 <- data %>%
  select(1, 3, 4, 8, 12, 16, 20, 23, 26, 29, 32) %>%
  filter(Region == "WE/EU")

test3 <- test2%>%
  select(-Region) %>%
  pivot_longer(!Country, names_to = "year", values_to = "score")

test3$year<-gsub("CPI Score ","",as.character(test3$year))
transform(test3, year = as.numeric(year))

str(test3)

test3$year <- as.numeric(as.character(test3$year))

str(test3)

viz <- test3 %>%
  filter(Country %in% c("Germany", "Poland", "Austria", "Czechia", "Switzerland", "Slovenia", "Hungary", "Slovakia")) %>%
  ggplot(aes(x = year, y = score, color = Country)) +
  geom_line(stat = "identity") +
  scale_color_jcolors(palette = "rainbow") +
  geom_point() +
  labs(title = "Corruption Perceptions in Central Europe", 
       subtitle = "Produced by Lukas Lehmann",
       x = "Year",
       y = "CPI Score",
       caption = "Source: Transparency International Corruption Perceptions Index") +
  theme(panel.background = element_rect(fill = "#dddddd", colour = "#615c5b",
                                          size = 0.5, linetype = "solid"))
 
viz  
  
