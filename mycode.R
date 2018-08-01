# ---- Load Packages ----
library(lubridate)
library(dplyr)
library(ggplot2)

# ---- Commenting Code ----
# This is a comment
5

# ---- R can be used as  calculator ----
5 + 9
(9*7)/10

# ---- Functions ----
sqrt(sqrt(81))
sqrt("a")

# ---- Help ----
?mean
??mean

# ---- Packages ----
# base::Date

# Packages:
# lubridate
# dplyr
# ggplot2
# knitr

# Install packages once
# Load packages every time you start up R

# To install:
# install.packages("lubridate")

# Load package:
library(lubridate)

# ---- Objects ----
# Scalar
x <- sqrt(81)
sqrt(x)

# Vectors
a <- 1:500 # all values from 1 to 500
a
b <- c(2, 6, 12, "a", 19)
b
length(b)
b[2]

tail(b, 1)

class(a)
class(b)

e <- c(TRUE, TRUE, FALSE, TRUE)
class(e)

# Exercise
# Create a scalar object called year; birthyear
# Create a vector called birthday; 3 elements, day, month, year
# Create a vector called name; 2 elements, first name last name
# Combine birthday and name into a single vector
birthyear <-1899
birthday <- c(17, 1, 1899)
name <- c("Danielle", "Quinn")
c(birthday, name)
c(paste(birthday, collapse=''), paste(name, collapse=''))
length(paste("a", 5, "hello", sep = "00000"))

# ---- Conditionals ----
vec <- seq(1, 1000, by = 20)
vec

# Greater Than
vec[vec > 40]

# Less Than or Equal
vec <= 70

!vec <= 70 # NOT

vec == 21

vec %in% c(21, 101)

# ---- Data Frames ----
df <- data.frame(year = 2000, 
                 month = c(4,4,4,5,6,7),
                 day = c(12, 13, 14, 3, 8, 11),
                 hour = c(11, 11, 12, 11, 12, 9),
                 minute = 30,
                 second = 0)
df
df[2,3]
df[2,]
df[,3]

summary(df)
str(df)

# ---- Dates in R ----
# Separate Components
df$newcolumntest <- 1
str(df)

# df$date <-

class("2018-02-03")
class(ymd("2018-2-3"))

paste(2018, 2, 3, sep="-")

df$date <- ymd(paste(df$year, df$month, df$day, sep="-"))
str(df)
# dmy()

# Create a column in df called datetime
# Contain the date and time information (formatted correctly)
# Hint: ymd_hms()

df$datetime <- ymd_hms(paste(df$year, df$month, df$day,
                             df$hour, df$minute, df$second,
                             sep="-"))
str(df)

df$datetime <- force_tz(df$datetime, tzone = "EST")
with_tz(df$datetime, "America/Vancouver")
wday(df$date, label = TRUE)

date1<-ymd_hms("2011-09-23-03-45-23")
date2<-ymd_hms("2011-10-03-21-02-19")

difftime(date2, date1, units = "secs")

leap_year(1987)

# ---- Missing Values ----
# NA
test <- c(2,6,3,1,5,7,NA,1,2,4)

min(test, na.rm = TRUE)
min(test[!is.na(test)])

max(test, na.rm = T)
mean(test, na.rm = T)

# Expect: (WRONG) !test == NA
is.na(test) # This works!

# ---- Loops ----
# Shell Loop Syntax:
##for filename in 2 3 4
##do
### do something
##done

for(value in c(2, 3, 4))
{
  print(value * 10)
}

temp <- 1:25
temp2 <- c()
for(i in temp)
{
  newvalue <- if(i > 10) {"yes"} else {"no"}
  temp2 <- c(temp2, newvalue)
}
temp2

# ---- Functions ----
myfunction <- function(x=250)
{
  return(4*x/20)
}

sqrt(myfunction(x=100))
# Shell
# myfunction x | sqrt

# Build a function that converts USD to CAD



# ---- FOR TOMORROW ----
## Make sure you have:
# gapminder
# ggplot2
# dplyr
# knitr
# rmarkdown
install.packages("gapminder")
library(gapminder)
data(gapminder)
gapminder

# ---- Tables ----
library(dplyr)
str(gapminder)
head(gapminder)

gapminder$lifeExp

# select() : selects columns from a data frame
select(gapminder, year, pop, lifeExp)

# filter() : filters rows from a data frame
filter(gapminder, year == 1997)
filter(gapminder, year == 1997 & country %in% c("Austria", "Australia"))
filter(gapminder, year == 1997 | country %in% c("Austria", "Australia"))

# Country and pop from 1997
# Pipe: %>%
# select, filter
gapminder %>% filter(year == 1997) %>% select(country, pop)

# group_by()
# summarise()

gapminder %>% group_by(continent) %>% summarise(mean(pop))

# Find the average and sd of lifeExp for each continent prior to 1970
# Challenge: try to group by continent and country
# Challenge: try naming the columns in your new table ("m_le", "sd_le")
## and store as a new object!

table1 <- gapminder %>% 
  filter(year < 1970) %>% 
  group_by(continent, country) %>%
  summarise(m_le = mean(lifeExp), 
            sd_le = sd(lifeExp)) %>%
  data.frame()

table1

# mutate() : create a new column based on another column
gapminder <- gapminder %>% mutate(new_lifeExp = lifeExp / 1000)
head(gapminder)

# count() : counts occurances
gapminder %>% count(continent)

# count countries by continent
gapminder %>% group_by(continent) %>% summarise(n_distinct(country))

# Create table for report
table2 <- gapminder %>% 
  group_by(continent) %>% 
  summarise(mean(pop), sd(pop))


# ---- Plotting ----
ggplot(gapminder,
       aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

ggplot(gapminder) +
  geom_point(aes(x = gdpPercap, y = lifeExp))

# points blue  
ggplot(gapminder) +
  geom_point(aes(x = gdpPercap, y = lifeExp),
             col = "blue")

# points colour based on continent
ggplot(gapminder) +
  geom_point(aes(x = gdpPercap, y = lifeExp, 
                 col = continent))

# Life exp. by year
# line for each country
# colour by continent
# add points for each country
# hint: ?geom_line
# hint: group = country *or* by = country
ggplot(gapminder) +
  geom_line(aes(x = year, y = lifeExp, 
                group = country, col = continent)) +
  geom_point(aes(x = year, y = lifeExp, 
                col = continent))

# Does the same thing
ggplot(gapminder, aes(x = year, y = lifeExp, 
                      col = continent))+
  geom_line(aes(group = country))+
  geom_point()
  
op1 <- ggplot(gapminder, aes(x = year, y = lifeExp, 
                      col = continent))+
  geom_line(aes(group = country))
op1

op2 <- op1 + geom_point()
op2

# Facetting
op3 <- op2 + facet_wrap(~continent)
op3
# try facet_grid with your own data!

# Plot Details
# themes
op2 + 
  theme_bw(18) + 
  xlab("Year") + 
  ylab("Life Expectancy")


# Gapminder Plot #
#plotdf <- gapminder %>% filter(year == 2007)
#ggplot(gapminder %>% filter(year == 2007))

figure1 <- gapminder %>% 
  filter(year == 2007) %>%
  ggplot(aes(x = continent, y = lifeExp)) +
  geom_boxplot() +
  geom_jitter(aes(col = gdpPercap), 
              shape = 17, width = 0.25) +
  scale_colour_gradient(low = "red", 
                        high = "green",
                        name = "GDP per Capita") +
  xlab("Continent") + ylab("Life Expectancy") +
  ggtitle("Life Expectancy and GDP 2007") +
  theme_bw(18)




