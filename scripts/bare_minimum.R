# R Workshop Notes --- Script 1
# This script shows basic data structures in R; reads a csv file; manipulates the data;
# and finally plots a graph. In order to make this script work, I have to install and load
# certain R packages (note that installing an R package is done ONCE per PC, whereas
# loading an R package is necessary every time I restart my RStudio.)


#I can use R like a calculator

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
vector_a <- c() #it should be numeric and include at least 6 elements
vector_b <- seq()
vector_c <- 4:17

vector_d <- c("apple", "banana", "watermelon")


# to combine two or more vectors, we can use the function c()

vector_all <- c()



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

names <- c("","")
ages <- c(24,32)
jobs <- c("student", "artist")

customers <- data.frame(name = names,
                        age = ages,
                        job = jobs)

dim()
colnames(customers)
rownames(customers)
customers[2,3]
customers[c(2,1), ]


print(customers$name)

customers$city <- c("","")
customers <- cbind(customers, hometown = c("MTL", "ONT"))

# think of the rows [observables] and columns [variables] of a data frame as vectors
# you can apply the vector functions such as length, substr, paste, etc.









