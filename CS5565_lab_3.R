library(MASS)
library(ISLR2)
head(Boston)
?Boston

# using the lm() function to fit a simple linear regression model, with medv as the response and lstat as the predictor.
attach(Boston)
lm.fit <- lm(medv ~ lstat)
#lm.fit <- lm(medv ~ lstat, data = Boston) # an alternative method
summary(lm.fit)
names(lm.fit)
lm.fit$coefficients
#coef(lm.fit) # alternative method to extract coefficients

# confidence intervals
predict(lm.fit, data.frame(lstat = (c(5, 10, 15))),
        interval = "confidence")
# prediction intervals 
predict(lm.fit, data.frame(lstat = (c(5, 10, 15))),
        interval = "prediction")

# Plotting lstat vs medv 
# The abline() function can be used to draw any line, not just the least squares regression line.
plot(lstat, medv)
abline(lm.fit, lwd = 3, col = "red") # lwd = 3 is line width * 3
# various ploting styles
plot(lstat, medv, col = "red")
plot(lstat, medv, pch = 1)
plot(lstat, medv, pch = 2)
plot(lstat, medv, pch = 3) 
plot(lstat, medv, pch = '+') # alternative method to select marker symbol
plot(lstat, medv, pch = 4)
plot(lstat, medv, pch = 5)
plot(lstat, medv, pch = 10)
plot(lstat, medv, pch = 20)
plot(lstat, medv, pch = 40)
plot(lstat, medv, pch = 50)
plot(1:125, 1:125, pch = 1:125) # plots a line of all markers as to easily visualizes marker choices in a range
# plots Four diagnostic plots 
# Using the par() and mfrow() functions, which tell R to split the display screen into separate 
# panels so that multiple plots can be viewed simultaneously.
par(mfrow = c(2, 2))
plot(lm.fit)
plot(predict(lm.fit), residuals(lm.fit))
plot(predict(lm.fit), rstudent(lm.fit))
plot(hatvalues(lm.fit))

# which.max() function identifies the index of the largest element of a vector. 
# In this case, it tells us which observation has the largest leverage statistic.
which.max(hatvalues(lm.fit))
# multiple linear regression
lm.fit <- lm(medv ~ lstat + age, data = Boston)
summary(lm.fit)
# multiple regression using all regressor "." signifies all features
lm.fit <- lm(medv ~ ., data = Boston)
summary(lm.fit)
# output is residual standard error
summary(lm.fit)$sigma

## Loading required package: carData
library(car)
# The vif() function, part of the car package, can be used to compute variance inflation factors. 
vif(lm.fit)

#perform a regression using all of the variables but one(Response ~ "all predictors" "except this feature", dataset)
lm.fit1 <- lm(medv ~ . - age, data = Boston)
summary(lm.fit1)

# The lm() function can also accommodate non-linear transformations of the predictors.
# The function I() is needed since the ^ has a special meaning in a formula object;
lm.fit2 <- lm(medv ~ lstat + I(lstat^2))
summary(lm.fit2)

# plot lm.fit2
# Using the par() and mfrow() functions, which tell R to split the display screen into separate 
# panels so that multiple plots can be viewed simultaneously.
par(mfrow = c(2, 2))
plot(lm.fit2)

# We use the anova() function to further quantify the extent to which the quadratic fit is superior to the linear fit.
anova(lm.fit, lm.fit2)

# we can include a predictor of the form I(X^3). 
# However, this approach can start to get cumbersome for higher-order polynomials. 
# the poly() function to create the polynomial within lm(). 
# For example, the following command produces a fifth-order polynomial fit:
lm.fit5 <- lm(medv ~ poly(lstat, 5))
summary(lm.fit5)

# using the log of a predictor doing a linear regression
summary(lm(medv ~ log(rm), data = Boston))

# We will attempt to predict Sales (child car seat sales) in 400
# locations based on a number of predictors.
head(Carseats)

lm.fit <- lm(Sales ~ . + Income:Advertising + Price:Age, 
             data = Carseats)
summary(lm.fit)

# The contrasts() function returns the coding that R uses for the dummy variables.
attach(Carseats)
contrasts(ShelveLoc)

# creating a funtion called loadlibraries()
LoadLibraries <- function() {
  library(ISLR2)
  library(MASS)
  print("The libraries have been loaded.")
}
LoadLibraries()