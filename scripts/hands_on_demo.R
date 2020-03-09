# First add a brief description of what this R script does: 
# (do this either as you go or at the very end)


# R Packages 
# Note that if we did not install these packages before, then first
# we must type install.packages("tidyverse") to install the packages but 
# tidyverse is a group of several packages, installing it might take a while
# so let's install the ones we'll use...
# Create a vector named packages to include several tidyverse packages:
packages <- c("dplyr", "tidyr", "janitor", "ggplot2")
lapply(packages, library, character.only = TRUE)


# Here, add the code that reads the gapminder.txt data (in the data folder) into R:
# TIP: open the txt file with a text editor, see what separates the individual values
# then check read.table() function and fill the following line: 
my_data <- read.table(, header=TRUE, sep=) # 1- complete the code here.

# 2- Check if read.csv() function gives us a data frame or not:


# 3- Calculate the number of rows (observations) and number of columns (variables):


# 4- Print the first 10 lines of the data frame (useful to check how the data set looks 
# like without printing the whole thing)

# Tip: View(my_data) shows the whole data set in a separate window --in RStudio--!

# take a quick look at basic stats of each variable 
summary(data_set)





####################### DPLYR ################################################################
# we'll go over the five dplyr functions: arrange(), filter(), select(), mutate(), summarize() 
# and group_by() which can be used with one of the above verbs
# write down your notes here and see mine at the end of the workshopb [Tugba]

# 5- Try out the following two lines of code: do they do the same? which one do you prefer?
# What does "%>%" do?
arrange(my_data, desc(year))  
my_data %>% arrange(desc(year))


# 6- Explain what the following does. Change 8 to any other number.
my_data %>% arrange(desc(year)) %>% head(8) 

# 7- What does arrange() do with the character variables? Let's try it out with the country variable:

# 8- Add group_by(year) to the previous line using the pipe operator -- What's changed?



# The filter function is used: <Your notes>

# 9- Subset the my_data data.frame so that the resulting data.frame has the data for all European countries at 2002:

# 10- Save the resulting data.frame, find a proper object name.

# We can also use comparison operators: == for equal, 
# <= and >= for greater/less than and 
# != for not equal
# To combine multiple conditions, we must use logical operators: & for AND,
# | for OR, ! for NOT

# 11- Explain what the following code does:
my_data %>% filter(continent == "Europe" | continent == "Asia", 
                   year == 2002, 
                   substr(country,1,1)=="M")


# 12- Now change it so that it shows all the observations for the countries whose
# names start with a "C" in 1992 or 1997 except for those in Europe.






# 13- How many different countries are listed in the data.frame?


# Select can be used for re-ordering the variables, subsetting the variables
# or deleting some of the variables

# 14- Run the following examples and explain what they do:
my_data %>% select(-(lifeExp:pop)) #explain here
my_data %>% select(country, continent, year, pop) #explain here
my_data %>% select(starts_with("c")) #explain here
my_data %>% select(pop,everything()) %>% head(10) #explain here
 




# 15- Let's change the name of a variable -- guess the dplyr function for it?!
my_data %>% (population=pop)

my_data %>% head() # 16 - is the change permanent?
# If not, how can we make it so?



# 17- Run the following line and explain what mutate does.
my_data %>% mutate(decade=year - (year %% 10))



# 18- Now, use mutate function to create a variable named label in the following format:
# first_three_letter_of_the_continent-country_name. For example: Asi-Afghanistan



# 19- Now in the same line of code, change mutate to transmutate and explain the difference:





# 20- Explain what the following code does:
my_data %>% group_by(continent, year) %>% summarize(meanGDP=mean(gdpPercap), meanPOP=mean(population))




# 21- Calculate the average life expectancy per country. Which has the longest average life expectancy and 
# which has the shortest average life expectancy?




# 22- Calculate the number of countries per continent in the data set:



# 23- For each of the year of 1952 and 2007, calculate the standard error of the life expectancy per continent?






##################################### GGPLOT2 ########################################
# First, we should understand how ggplot grammar works:
ggplot()

# 24- Let's create a mini data set to test the ggplot() function:
test_data <- data.frame(vector_a = seq(-10,10), vector_b = seq(-10,10)**2)
ggplot(test_data, mapping=aes(x=vector_a,y=vector_b)) #still nothing?! WHY?



# 25- Let's plot vector_b vs vector_a as a scatter plot:
ggplot(test_data, mapping = aes(x = vector_a, y = vector_b)) + 




# 26- Let's go back to our data and plot a scatter graph of lifeExp vs year:
ggplot(my_data, aes(x = year, y = lifeExp, col = continent)) +
  geom_point(alpha = 0.25)
# delete alpha=0.25 and rerun the code. What changed?




# 27- Let's try the following chunk of code:
ggplot(my_data %>% 
         group_by(continent,year) %>% 
         summarize(lifeExp_by_continent=mean(lifeExp)),
       aes(x = year, y = lifeExp_by_continent, col = continent)) +
  geom_point() +
  theme(legend.title = element_blank())

# Is this plot different than the previous one? 
# 28- Change "col" to "shape" and explain the difference.



ggplot(my_data,aes(x = gdpPercap)) + geom_histogram(col = "gray", fill = "lightblue") + theme_bw()
   
# 29- Explain the graph we created with the previous line:
# 30- Add the following layer:facet_grid( continent ~ .) -- what changed?
# 31- Change "facet_grid( continent ~ .)" to "facet_grid( . ~ continent)" --  what happened?
# 32- Change theme_bw() to theme_minimal
# 33- save this plot as an object and generate a PNG file 





# 34- What does the following chunk of code do?
my_data %>%
  # your comment goes here
  mutate(startsWith = substr(country, start = 1, stop = 1)) %>%
  # your comment goes here
  filter(startsWith %in% c("A", "Z")) %>%
  # your comment goes here
  ggplot(aes(x = year, y = lifeExp, color = continent)) +
  geom_line() +
  facet_wrap( ~ country)
ggsave("lifeExp_vs_year.png", plot=last_plot())











# 35- Finally, inspect the following graph and let's calculate the values we see only using dplyr:
ggplot(my_data %>% filter(year==2002),aes(x = continent)) + geom_bar(col = "gray", fill = "lightblue")

### type the dplyr version below:
