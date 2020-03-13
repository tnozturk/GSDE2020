
#here, I'll list all the R packages I use in this script, so that I know what I'll need to do the same in the future
library("dplyr")
library("tidyr")
library("janitor")
library("naniar")
library("ggplot2")


#read the data file given as a "csv" file and keep it as apartments (a data frame!)
apartments <- read.csv("data/toronto_apartment_building_evaluation.csv")

#let's see how the data look, by printing first 10 lines from it:
head(apartments)
#alternatively, I could just click on the data file and choose View option from Rstudio


#the data look messy. personally, I dislike having uppercase letters in the variable names.
#let's print the variable names on the screen (column names)
names(apartments)

#one way to "clean" it is to use "clean_names" function from the R package named janitor
#just a quick try
apartments %>% clean_names() 

#if it looks okay, let's make this change "permanent". In other words, let's save the apartments data frame after the change
apartments <- apartments %>% clean_names()

#there are a few missing values, and they're given as N/A. But R only understands "NA". So we need to change those:
apartments <- apartments %>% naniar::replace_with_na_all(~.x == "N/A")
#here, naniar::replace_with_na_all means that replace_with_na_all function from naniar package


#now, let's plot a histogram of the year_built variable
ggplot(apartments,
       aes(x = year_built)) + 
  geom_histogram()


#since there aren't much data before 1900s, I want to create a sub-data set for apartments built after 1900.
#this new data set is named apartments_built_1900s
#I also want to create a new column to keep the decade info: decade_built

apartments_built_1900s <- apartments %>% 
  filter(year_built >= 1900 & year_built < 2000) %>% 
  mutate(decade_built=year_built - year_built %% 10)

#now, let's generate a scatter plot of "decade built vs number of "confirmed" storeys" for the apartments built after 1900:

ggplot(apartments_built_1900s,
       aes(x = decade_built,
           y = confirmed_storeys)) + 
  geom_point()


#we can't see all the data points. geom_jitter instead of geom_point can help!
ggplot(apartments_built_1900s,
       aes(x = decade_built,
           y = confirmed_storeys)) + 
  geom_jitter(alpha = 0.2)


#finally, let's polish up this figure:
ggplot(apartments_built_1900s %>%
         filter(confirmed_storeys >= 3),
       aes(x = decade_built,
           y = confirmed_storeys)) + 
  geom_jitter(alpha = 0.2, colour = "deeppink4") +
  scale_x_continuous(breaks = seq(1900, 1990, 10)) + 
  labs(title = "Apartment storeys by decade built",
       x = "Decade built",
       y = "Number of storeys",
       caption = "Source: Toronto Open Data"
  ) + 
  theme_minimal(16)

# ggsave saves a plot (I mostly use the following extensions: pdf, jpeg, or png).
# if needed, width and height (as well as dpi -plot resolution-) can also be specified.
# the options for units: cm, mm, in.
# how do I know all these things? I googled "ggplot2 ggsave" and read the reference page:
# https://ggplot2.tidyverse.org/reference/ggsave.

ggsave("toronto_apartments.png", width = 20, height = 10, units = "cm")


print(summary(apartments_built_1900s))