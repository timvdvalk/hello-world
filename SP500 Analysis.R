# Data inladen & beetje cleanen
SP500 <- read.csv2("C:/Users/Amaur/Desktop/hello-world/Data/SP500.csv")
colnames(SP500)
names(SP500)[1] <- "Date"
SP500 <- transform(SP500, Year = substr(Date, 1, 4), Month = substr(Date, 5, 6))

# packages inladen
library(ggplot2)
library(dplyr)
library(tidyr)
library(gridExtra)

#Crisis vergelijken
Crisis2008 <- SP500[,c("Real.Price", "Year")] %>%
  filter(Year == "2006" | Year == "2007" | Year == "2008" | Year == "2009")
Months <- seq(1:48)
Crisis2008 <- cbind(Crisis2008, Months)
ts(Crisis2008)

Crisis2020 <- SP500[,c("Real.Price", "Year")] %>%
  filter(Year == "2019" | Year == "2020")
Months <- seq(1:15)
Crisis2020 <- cbind(Crisis2020, Months)


# Figuur maken
p1 <- SP500 %>%
  ggplot(aes(x= Year, y = Real.Price)) + geom_point() + scale_x_discrete(breaks=seq(1871,2020,20))
p2 <- Crisis2008 %>%
  filter(Months == c(1:39)) %>%
  ggplot(aes(x= Months, y = Real.Price)) + geom_line() 
p3 <- Crisis2020 %>%
  ggplot(aes(x= Months, y = Real.Price)) + geom_line()
grid.arrange(p2, p3, ncol=2)
