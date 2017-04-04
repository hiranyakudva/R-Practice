# Some more functions in R

# Let us create dataframes to work on
df1 = data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 3)))
df2 = data.frame(CustomerId = c(2, 4, 6, 7, 8, 9), State = c(rep("Alabama", 3), rep("Ohio", 3)))
df3 = data.frame(CustomerId = c(7:12), Product = c(rep("Microwave", 3), rep("TV", 3)))

# 'rbind' : Join two dataframes on common variables
rbind(df1, df3)

# 'cbind' : Join two dataframes with equal number of rows horizontally
cbind(df1, df2)

# We will look at some merge functions to perform SQL style joins on our data

# INNER JOIN : Return only the rows in which the left table have matching keys in the right table
merge(df1, df2, by = "CustomerId")

# OUTER JOIN : Returns all rows from both tables, join records from the left which have matching keys in the right table
merge(x = df1, y = df2, by = "CustomerId", all = TRUE)

# LEFT JOIN : Return all rows from the left table, and any rows with matching keys from the right table
merge(x = df1, y = df2, by = "CustomerId", all.x = TRUE)

# RIGHT JOIN: Return all rows from the right table, and any rows with matching keys from the left table
merge(x = df1, y = df2, by = "CustomerId", all.y = TRUE)

# CROSS JOIN
merge(x = df1, y = df2, by = NULL)

df <- merge(x = df1, y = df2, by = "CustomerId", all = TRUE)

# 'table' : A simple but a very powerful function to create tabular results of variables
table(df$State)
table(df$State, useNA = "always")
table(df$Product, is.na(df$State))
table(df$State=='Ohio')

# We shall use 'mtcars' dataset for the following part
attach(mtcars)
mtcars$name <- row.names(mtcars)

# 'match' : Returns a vector of the positions of (first) matches of its first argument in its second
v <- c(3,4,5,6)
match(v, mtcars$cyl)
mtcars$name[match(v, mtcars$cyl)]

# '%in%' : Returns a logical vector indicating if there is a match or not for its left operand
v %in% mtcars$cyl

# 'which' : gives the TRUE indices of a logical object
which(mtcars$cyl==8)
mtcars$name[which(mtcars$cyl==8)]

# 'which.min()', 'which.max()' : Location of min/max
mtcars$name[which.min(mtcars$mpg)]
mtcars$name[which.max(mtcars$mpg)]

# 'replicate' : Repeated evaluation of an expression 
replicate(5, mtcars$mpg)

# 'rank' : Returns the sample ranks of the values in a vector
rank(mtcars$mpg, ties.method = 'first') # ascending
rank(-mtcars$mpg, ties.method = 'first') # descending
rank(mtcars$name)
