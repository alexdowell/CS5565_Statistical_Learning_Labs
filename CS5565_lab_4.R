# We will begin by examining some numerical and graphical summaries of the Smarket data, 
# which is part of the ISLR2 library.
library(ISLR2)
names(Smarket)

# outputing the dimension of the dataset
dim(Smarket)

#summary of dataset Smarket
summary(Smarket)
#plotting all features vs. all features in a feature by feature sized grid of plots
pairs(Smarket)

# cor() function outputs a correlation matrix 
cor(Smarket[, -9])

# show a correlation in volume over time
attach(Smarket)
plot(Volume)
cor(Smarket[, -9])

# glm() function is similar to that of lm(), except that we must pass 
# in the argument family = binomial in order to tell R to run a logistic regression
glm.fits <- glm(
  Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
  data = Smarket, family = binomial
)
summary(glm.fits)

# access just the coefficients for this fitted model.
coef(glm.fits)

# limits the summary to just show coefficient info
summary(glm.fits)$coef

# limits the summary to just show coefficient info column 4 which is p-value
summary(glm.fits)$coef[, 4]

# The predict() function can be used to predict the probability that the market will go up, 
# given values of the predictors. The type = "response" option tells R to output probabilities of the form P(Y=1|X)
glm.probs <- predict(glm.fits, type = "response")
glm.probs[1:10]

# contrasts() function indicates that R has created a dummy variable with a 1 for Up.
contrasts(Direction)

# The following two commands create a vector of class predictions based on whether 
# the predicted probability of a market increase is greater than or less than 0.5.
# Given these predictions
# The first command creates a vector of 1,250 Down elements. 
# The second line transforms to Up all of the elements for which the predicted 
# probability of a market increase exceeds 0.5
glm.pred <- rep("Down", 1250)
glm.pred[glm.probs > .5] = "Up"

# table() function can be used to produce a confusion matrix in order to 
# determine how many observations were correctly or incorrectly classified.
table(glm.pred, Direction)

# average of correctly classified (507 + 145) / 1250
mean(glm.pred == Direction)

# We will then use this vector to create a held out data set of observations from 2005. 
# a subset of the dataset
train <- (Year < 2005)
Smarket.2005 <- Smarket[!train, ]
dim(Smarket.2005)
Direction.2005 <- Direction[!train]

# logistic regression with subset
glm.fits <- glm(
  Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume,
  data = Smarket, family = binomial, subset = train
)
glm.probs <- predict(glm.fits, Smarket.2005,
                     type = "response")

# confusion matrix of correctly/incorrectly classifying subset of data
glm.pred <- rep("Down", 252)
glm.pred[glm.probs > .5] <- "Up"
table(glm.pred, Direction.2005)

# correctly classified
mean(glm.pred == Direction.2005)

# incorrectly classified
mean(glm.pred != Direction.2005)

# results are 52 % wrongly clssified so random guess would be better!

# trying a logistic regression again but this time only using lag1 and lag2 as predictors
glm.fits <- glm(Direction ~ Lag1 + Lag2, data = Smarket,
                family = binomial, subset = train)
glm.probs <- predict(glm.fits, Smarket.2005,
                     type = "response")
glm.pred <- rep("Down", 252)
glm.pred[glm.probs > .5] <- "Up"
table(glm.pred, Direction.2005)

# correctly classified
mean(glm.pred == Direction.2005)


# we want to predict direction on a day when lagone and lagtwo equal 1.2 and~1.1, 
#respectively, and on a day when they equal 1.5 and $-$0.8.
predict(glm.fits,
        newdata =
          data.frame(Lag1 = c(1.2, 1.5),  Lag2 = c(1.1, -0.8)),
        type = "response"
)

###Linear Discriminant Analysis###
library(MASS)
lda.fit <- lda(Direction ~ Lag1 + Lag2, data = Smarket,
               subset = train)
lda.fit

#plotting lda
plot(lda.fit)

lda.pred <- predict(lda.fit, Smarket.2005)
names(lda.pred)

lda.class <- lda.pred$class
table(lda.class, Direction.2005)

mean(lda.class == Direction.2005)

sum(lda.pred$posterior[, 1] >= .5)
sum(lda.pred$posterior[, 1] < .5)

lda.pred$posterior[1:20, 1]

lda.class[1:20]

sum(lda.pred$posterior[, 1] > .9)

#Quadratic Discriminant Analysis
qda.fit <- qda(Direction ~ Lag1 + Lag2, data = Smarket,
               subset = train)
qda.fit

qda.class <- predict(qda.fit, Smarket.2005)$class
table(qda.class, Direction.2005)

mean(qda.class == Direction.2005)


# Naive Bayes
library(e1071)
nb.fit <- naiveBayes(Direction ~ Lag1 + Lag2, data = Smarket,
                     subset = train)
nb.fit

mean(Lag1[train][Direction[train] == "Down"])

sd(Lag1[train][Direction[train] == "Down"])

nb.class <- predict(nb.fit, Smarket.2005)
table(nb.class, Direction.2005)

mean(nb.class == Direction.2005)

nb.preds <- predict(nb.fit, Smarket.2005, type = "raw")
nb.preds[1:5, ]

##K-Nearest Neighbors
library(class)
train.X <- cbind(Lag1, Lag2)[train, ]
test.X <- cbind(Lag1, Lag2)[!train, ]
train.Direction <- Direction[train]

set.seed(1)
knn.pred <- knn(train.X, test.X, train.Direction, k = 1)
table(knn.pred, Direction.2005)

(83 + 43) / 252

knn.pred <- knn(train.X, test.X, train.Direction, k = 3)
table(knn.pred, Direction.2005)

mean(knn.pred == Direction.2005)

dim(Caravan)

attach(Caravan)
summary(Purchase)

348 / 5822

standardized.X <- scale(Caravan[, -86])
var(Caravan[, 1])

var(Caravan[, 2])

var(standardized.X[, 1])

var(standardized.X[, 2])

test <- 1:1000
train.X <- standardized.X[-test, ]
test.X <- standardized.X[test, ]
train.Y <- Purchase[-test]
test.Y <- Purchase[test]
set.seed(1)
knn.pred <- knn(train.X, test.X, train.Y, k = 1)
mean(test.Y != knn.pred)

mean(test.Y != "No")

table(knn.pred, test.Y)

9 / (68 + 9)

knn.pred <- knn(train.X, test.X, train.Y, k = 3)
table(knn.pred, test.Y)

5 / 26

knn.pred <- knn(train.X, test.X, train.Y, k = 5)
table(knn.pred, test.Y)

4 / 15

glm.fits <- glm(Purchase ~ ., data = Caravan,
                family = binomial, subset = -test)

glm.probs <- predict(glm.fits, Caravan[test, ],
                     type = "response")
glm.pred <- rep("No", 1000)
glm.pred[glm.probs > .5] <- "Yes"
table(glm.pred, test.Y)

glm.pred <- rep("No", 1000)
glm.pred[glm.probs > .25] <- "Yes"
table(glm.pred, test.Y)

11 / (22 + 11)

##Poisson Regression
attach(Bikeshare)
dim(Bikeshare)
names(Bikeshare)

mod.lm <- lm(
  bikers ~ mnth + hr + workingday + temp + weathersit,
  data = Bikeshare
)
summary(mod.lm)

contrasts(Bikeshare$hr) = contr.sum(24)
contrasts(Bikeshare$mnth) = contr.sum(12)
mod.lm2 <- lm(
  bikers ~ mnth + hr + workingday + temp + weathersit,
  data = Bikeshare
)
summary(mod.lm2)

sum((predict(mod.lm) - predict(mod.lm2))^2)

all.equal(predict(mod.lm), predict(mod.lm2))

coef.months <- c(coef(mod.lm2)[2:12],
                 -sum(coef(mod.lm2)[2:12]))

plot(coef.months, xlab = "Month", ylab = "Coefficient",
     xaxt = "n", col = "blue", pch = 19, type = "o")
axis(side = 1, at = 1:12, labels = c("J", "F", "M", "A",
                                     "M", "J", "J", "A", "S", "O", "N", "D"))
coef.hours <- c(coef(mod.lm2)[13:35],
                -sum(coef(mod.lm2)[13:35]))
plot(coef.hours, xlab = "Hour", ylab = "Coefficient",
     col = "blue", pch = 19, type = "o")

mod.pois <- glm(
  bikers ~ mnth + hr + workingday + temp + weathersit,
  data = Bikeshare, family = poisson
)
summary(mod.pois)

coef.mnth <- c(coef(mod.pois)[2:12],
               -sum(coef(mod.pois)[2:12]))
plot(coef.mnth, xlab = "Month", ylab = "Coefficient",
     xaxt = "n", col = "blue", pch = 19, type = "o")
axis(side = 1, at = 1:12, labels = c("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"))

coef.hours <- c(coef(mod.pois)[13:35],
                -sum(coef(mod.pois)[13:35]))
plot(coef.hours, xlab = "Hour", ylab = "Coefficient",
     col = "blue", pch = 19, type = "o")

plot(predict(mod.lm2), predict(mod.pois, type = "response"))
abline(0, 1, col = 2, lwd = 3)



