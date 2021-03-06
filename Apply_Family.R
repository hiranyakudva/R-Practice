# We will look at some 'apply' family functions that can make our life easier!

# Lets do this using built in dataset 'mtcars'
attach(mtcars)
df <- data.frame(mtcars, stringsAsFactors = FALSE)
df['name'] <- row.names(mtcars) # Just to have a column with unique values

# 'apply' : apply functions over array margins (rows or columns)
# Usage: apply(Array, Margin, Function)
apply(df[c(-12)], 2, mean) # find mean of all numerical variables
apply(df[c(-12)], 2, max) # find max value of all numerical variables

# We could also define our own function

apply(df[c(-12)], 2, function (x) x+100)

power <- function(x){
	# just a silly function to show if..else.. syntax
	if (x>95 && x<110){
		return (x^2)
	} else {
		return (x^3)
	}
}

apply(df[c(3,4)], 2, power)

# 'lapply' : Apply a function to each element of a list in turn and returns list
# Usage : lapply(Array, Function)
lapply(df[c(2,3,4)], function(x) x^2)

# 'sapply' : Apply a function to each element of a list in turn and returns vector
# Usage : sapply(Array, Function)
sapply(df[c(2,3,4)], function(x) x^2)

# NOTE : sapply(*, simplify = FALSE) is equivalent to lapply(*)
# NOTE : unlist(lapply(*)) is equivalent to sapply(*)

# 'vapply' : Apply a function to each element of a list in turn and specify type of return value
# Usage : vapply(Array, Function, Fun.value)
vapply(df$hp, function(x) x>100, TRUE)
vapply(df$hp, function(x) x>100, 1)

# 'tapply' : Apply function on groups, group column 1 by column 2 and then apply function on it, returns matrix
# Usage: tapply(Summary Variable, Group Variable, Function)
cyl_mpg <- tapply(df$mpg, df$cyl, mean) # I am trying to find the average milage for each cylinder value

# I can create a new variable with values for average milage for each entry of cyl
df['cyl_mpg'] <- cyl_mpg[as.character(df$cyl)] # need to convert cyl into string

# Group by 2 columns in place of 1
tapply(df$mpg, list(df$cyl, df$gear), mean)

# Using tapply to mimic apply function
df$ones <- 1
tapply(df$hp, df$ones, mean)

# 'by' : A wrapper to tapply
# A data frame is split by row into data frames subsetted by the values of one or more factors, and function is applied to each subset in turn
# Usage : by(data, INDICES, FUN, ..., simplify = TRUE)
by(df$mpg, df$cyl, mean)
by(df$mpg, list(df$cyl, df$gear), mean)

# 'aggregate' : Similar to 'tapply', returns dataframe
aggregate(df$mpg, list(cyl=df$cyl, gear=df$gear), mean)

# 'mapply' : Apply function to first elements of each ... argument, the second elements, the third elements, and so on
# Usage : maaply(Function, Arg1, Arg2, ....)
power_3 <- function(x,y){
	# Again a silly function to make mapply clear
	if (y == 4){
		return (x^2)
	} else if (y == 6){
		return (x^3)  
	} else {
		return (x^4)
	}
}

df$new_gear <- mapply(power_3, x=df$gear, y=df$cyl) # create a new column with the new values
