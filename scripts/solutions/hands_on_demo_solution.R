# First add a brief description of what this R script does:
# this script (1) reads a data file named gapminder.csv;
# (2)then does data wrangling with dplyr, janitor and tidyr packages;
# and (3)finally visualizes data by plotting scatter and histogram graphs

# R Packages 
# Note that if we did not install these packages before, then first
# we must type install.packages("tidyverse") to install the packages 
# Create a vector named packages to include several tidyverse packages:
packages <- c("dplyr", "tidyr", "janitor", "ggplot2")
lapply(packages, library, character.only = TRUE)


# Here, add the code that reads the NY_flights_2013.csv data into R:
# In this part of the workshop, we will use a data set from the gapminder R package 
# that provides a data set consisting of values for 
# life expectancy, GPD per capita, population in every five years from 1952 to 2007. 
# The data is available at Gapminder.org and more details
# can be found at https://cran.r-project.org/web/packages/gapminder/index.html

# But, for practice purposes, here we'll read the data from a txt file
# using the read.table() function
my_data <- read.table("data/gapminder.txt", header=TRUE, sep=":")

# let's double check if read.csv() function gives us a data frame or not:
is.data.frame(my_data)

# what are the number of rows (observations) and number of columns (variables)?
dim(my_data) 

# let's print the first 10 lines of the data frame (useful to check how the data set looks 
# like without printing the whole thing)
head(my_data,10) 
# Tip: View(my_data) shows the whole data set in a separate window!

# take a quick look at basic stats of each variable 
summary(my_data)

####################### DPLYR ################################################################
# we'll go over the five dplyr functions: arrange(), filter(), select(), mutate(), summarize() 
# and group_by() which can be used with one of the above verbs
# All these verbs work in a similar way: (1) they take a data.frame as an input and give the 
# result as a data.frame, (2) they sometimes take arguments that describe what to do with the
# data.frame, using the variable (column) names
# Even though these verbs can work as any other function in R: 
# function_name(argument1, argument2,...)
# this is NOT the way we'll use it. We'll use these verbs with the pipe operator, %>%

arrange(my_data, desc(year))  #takes the my_data data.frame and rearranges its rows so that
# the year variable is in a descending order
# With the pipe operator, we can do the same as follows:
my_data %>% arrange(desc(year))


# While we try out things, it's best not to print the resulting data.frame on the screen
# To avoid it, we can pipe everything to the head() function at the very end:
my_data %>% arrange(desc(year)) %>% head(8) #prints out the first 8 row of the resulting data.frame

# What does arrange() do with the character variables? Let's try it out with the country variable:
my_data %>% arrange(country) %>% head(8)
# Now try the following:
my_data %>% group_by(year) %>% arrange(country) %>% head(8)
# What's changed?
# The latter first groups the observations by the year and then arranges the country variable
# in the alphabetical order! The former simply just rearranges the rows in a way that the country
# variable is in the alphabetical order.


# The filter function is used:
# for subsetting observations based on their values.
# For example, we can use this verb to save all 2002 data from the countries in Europe:

Europe2002 <- my_data %>% filter(year == 2002, continent=="Europe")

# We can also use comparison operators: == for equal, 
# <= and >= for greater/less than and 
# != for not equal
# To combine multiple conditions, we must use logical operators: & for AND,
# | for OR, ! for NOT

# Explain what the following code does:
my_data %>% filter(continent == "Europe" | continent == "Asia", 
                   year == 2002, 
                   substr(country,1,1)=="M")
# Now change it so that it shows all the observations for the countries whose
# names start with a "C" in 1992 or 1997 except for those in Europe.
my_data %>% filter(year %in% c(1992,1999), 
                   substr(country,1,1)=="C",
                   continent != "Europe")

# How many different countries are listed in the data.frame?
n_countries <- length(unique(my_data$country))

# Select can be used for re-ordering the variables, subsetting the variables
# or deleting some of the variables

# Run the following examples and explain what they do:

my_data %>% select(-(lifeExp:pop))
my_data %>% select(country, continent, year, pop)
my_data %>% select(starts_with("c"))
my_data %>% select(pop,everything()) %>% head(10)

# You can also use the following helper functions: ends_with and contains

# let's change the name of a variable:
my_data %>% rename(population=pop)

my_data %>% head() # is the change permanent?
# If not, how can we make it so?
my_data <- my_data %>% rename(population=pop)


my_data %>% mutate(decade=year - (year %% 10))

# Use mutate function to create a variable named label in the following format:
# first_three_letter_of_the_continent-country_name. For example Asi-Afghanistan

my_data %>% mutate(label=paste0(substr(continent,1,3),"-",country)) %>% head()

# Now in the same line of code, change mutate to transmutate and explain the difference:
# mutate keeps all the columns, whereas transmutate keeps only the resulting variable 

# Explain what the following code does:

my_data %>% group_by(continent, year) %>% summarize(meanGDP=mean(gdpPercap), meanPOP=mean(population))

# It groups the data by the continent and year, then calculates the mean GDP per cap and mean population
# for each group.

# Calculate the average life expectancy per country. 
# Which has the longest average life expectancy and which has the shortest average life expectancy?

lifeExp_bycountry <- my_data %>%
  group_by(country) %>%
  summarize(mean_lifeExp = mean(lifeExp))

# The longest life expectancy:
lifeExp_bycountry %>%
  arrange(desc(mean_lifeExp)) %>%
  head(1)

# The shortest:
lifeExp_bycountry %>%
  arrange(mean_lifeExp) %>%
  head(1)


# Calculate the number of countries per continent in the data set:
my_data %>% filter(year %in% c(1952,2007)) %>% group_by(continent,year) %>% summarize(n()) 


# For each of the year of 1952 and 2007, calculate the standard error of the life expectancy per continent?
my_data %>% filter(year %in% c(1952,2007)) %>% group_by(continent,year) %>% 
  summarize(SE_lifeExp = sd(lifeExp)/sqrt(n())) %>%  arrange(SE_lifeExp)
# What happens in order: my_data is filtered so that there are data only for the years 1952 and 2007;
# next, it is grouped by the continent and year variables; then the standard error for life expentancy
# is calculated by dividing the standard deviation by the number of data points for each (continent,year) group;
# finally the result is shown after arranging the standard error variable in the increasing order.

##################################### GGPLOT2 ########################################
# First, we should understand how ggplot grammar works:
ggplot() #nothing happens, no errors but no plots either. since ggplot doesn't know what to do...
# if ggplot2 library wasn't loaded, this function would have been unknown & R would have given us an error.

# let's create a mini data set to test the ggplot() function:
test_data <- data.frame(vector_a = seq(-10,10), vector_b = seq(-10,10)**2)
ggplot(test_data, mapping=aes(x=vector_a,y=vector_b)) #still nothing?! WHY?

# we must tell ggplot() what kind of plot we want. The simplest is a scatter plot:
ggplot(test_data, mapping = aes(x = vector_a, y = vector_b)) + 
  geom_point(colour = "blue") + geom_line(lty = 2) +
  theme_bw(16) + xlab("x") + ylab(expression("f(x) = x"^2)) 

# ggplot creates a coordinate system that you can add layers too. Each layer can be added with a "+" operator.
# ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

# let's go back to our data and plot a scatter graph of lifeExp vs year:
ggplot(my_data, aes(x = year, y = lifeExp, col = continent)) +
  geom_point(alpha = 0.25)
# delete alpha=0.25 and rerun the code. What changed?


ggplot(my_data %>% 
         group_by(continent,year) %>% 
         summarize(lifeExp_by_continent=mean(lifeExp)),
       aes(x = year, y = lifeExp_by_continent, col = continent)) +
  geom_point() +
  theme(legend.title = element_blank())

# Is this plot different than the previous one? 
# Change "col" to "shape" and explain the difference.


ggplot(my_data,aes(x = gdpPercap)) + geom_histogram(col = "gray", fill = "lightblue") + theme_bw()
   
# Explain the graph we created with the previous line:
# Add the following layer:facet_grid( continent ~ .) -- what changed?
# Change "facet_grid( continent ~ .)" to "facet_grid( . ~ continent)" --  what happened?
# Change theme_bw() to theme_minimal
# save this plot as an object and generate a PNG file 

# Option 1 (will save a 400x400 file at 100 ppi) is to use the ggsave() function:
ggsave("hist_gdpPercap_1.png", width=4, height=4, dpi=100)
# Any problem?

# Option 2 is to use png device:
hist_plot <- ggplot(my_data,aes(x = gdpPercap)) + geom_histogram(col = "gray", fill = "lightblue") + theme_bw(18) +
  theme(plot.margin=grid::unit(c(2,8,2,2), "mm"))
ppi <- 300
png("hist_gdpPercap_2.png",width = 6*ppi, height = 6*ppi, res=ppi)
print(hist_plot)
dev.off()

# What does the following chunk of code do?
my_data %>%
  # Get the start letter of each country
  mutate(startsWith = substr(country, start = 1, stop = 1)) %>%
  # Filter countries that start with "A" or "Z"
  filter(startsWith %in% c("A", "Z")) %>%
  # Make the plot
  ggplot(aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  facet_wrap( ~ country)

ggsave("lifeExp_vs_year.png", plot=last_plot())

# It takes the data; creates a variable named startsWith that contains the first letter from the country variable
# (extracted by the substr() function); then filters the observations so that countries starting with A or Z are
# the only ones; then sends the resulting data frame to the ggplot() function; this function adds the aesthetics
# (i.e. x axis represents the year variable, y axis represents the lifeExp variable, each continent is color-coded)
# the plot type is the line; facet_wrap will return a symmetrical matrix of plots for the different countries; finally
# ggsave saves the last plot generated as "lifeExp_vs_year.png"

# Finally, inspect the following graph and let's calculate the values we see only using dplyr:
ggplot(my_data %>% filter(year==2002),aes(x = continent)) + geom_bar(col = "gray", fill = "lightblue")

### dplyr version:
my_data %>% filter(year==2002) %>% group_by(continent) %>% summarize(n())