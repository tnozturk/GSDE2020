# R Workshop Notes --- Script 1
# This script shows basic data structures in R; reads a csv file; manipulates the data;
# and finally plots a graph. In order to make this script work, you have to install and load
# certain R packages (note that installing an R package is done ONCE per PC, whereas
# loading an R package is necessary every time you restart my RStudio.)


#you can use R like a calculator

2

4

2+4

#If I need R to remember a value in order to be used again, I need to use the assignment operator: <-
#Here is a value (5) that is saved as a numeric variable named my_number.
my_number <- 5

#Here is a few character variables:
my_name <- "a"
my_fruit <- "apple"

# If I need to change the value later on, I can simply put the new value into the variable name I chose!
my_fruit <- "blackberry"

# If I tell R to print my_fruit, it'll tell me its value
print(my_fruit)



# Let's define a vector variable:
vector_a <- c(1,2,3,4,5,6) #it should be numeric and include at least 6 elements
vector_b <- seq(6,1,-1)
vector_c <- 4:17

vector_d <- c("apple", "banana", "watermelon")


# to combine two or more vectors, we can use the function c()

vector_all <- c(vector_a, vector_d)



# arithmetic operations on numeric vectors are performed item-wise:
vector_a * 2

print(vector_c)
vector_c <- vector_c %% 2
print(vector_c)

# using the square brackets, we can slice a vector; try the following commands to see how:
vector_a[1]
vector_a[c(2,4,1)]
vector_a[3:5]

# the base-R has a lot of functions work with vectors:
length(vector_c)
cities <- c("MTL", "NYC", "ORL", "FLR")
substr(cities,1,2)
paste(substr(cities,1,1), substr(cities,3,3), sep="*")

my_pattern <- c(0, 1, 7)
rep(my_pattern, times = 2)
# try the rep() function with the following arguments: each=2, length.out=9, and times=c(1,2,4)
rep(my_pattern, each=2)
rep(my_pattern, length.out=9)
rep(my_pattern, times=c(1,2,4))


# figure out what the following functions do:
any(my_pattern > 0)
all(my_pattern >= 0)

# now, how about the expression given below?
my_pattern[my_pattern > 3]


# for R to treat a variable as a categorical variable, the vector needs to be a "factor".
# a factor is like a vector, but with levels. You can convert any vector into a factor by typing 
# the following:
factor(my_pattern)
# this is especially crucial when visualizing data with ggplot2.

# finally, we should talk about data frames :) handling tabular data is the easiest thing in R
# if you know the basics of this variable type.

# create any two (or more) vectors of the same length, and combine them to be a data.frame

names <- c("tugba","alice")
ages <- c(24,32)
jobs <- c("student", "artist")

#use the three vectors given above to form a data.frame
customers <- data.frame(name = names,
                        age = ages,
                        job = jobs)
print(customers) #print the data frame onto the screen

dim(customers) #gives you the dimension of a data frame [row, column]
colnames(customers) #column names of the data frame
rownames(customers) #row names of the data frame
customers[2,3] #gives you the data in the 2nd row and 3rd col
customers[c(2,1), ] #gives you the data from the second row and then the first rows with ALL the columns




print(customers$name) #prints the name column of the customers data.frame
#$ operator gives you access to the columns as separate vectors

customers$city <- c("MTL","TRT") #you can create a new column named city with $ operator
customers <- cbind(customers, hometown = c("MTL", "ONT")) #another way of adding a new column
#check rbind() function to add a row 

# think of the rows [observables] and columns [variables] of a data frame as vectors
# you can apply the vector functions such as length, substr, paste, etc.









