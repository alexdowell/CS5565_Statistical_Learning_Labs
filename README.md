# CS5565 Statistical Learning Labs  

## Description  
This repository contains R scripts for **CS5565**, covering topics in statistical learning, regression models, classification methods, and machine learning techniques. These labs involve practical implementations of regression, logistic regression, discriminant analysis, k-nearest neighbors, naive Bayes, and other machine learning models.  

## Files Included  

### **Lab 3: Linear Regression and Model Selection**  
- **File:** CS5565_lab_3.R  
- **Topics Covered:**
  - Simple and multiple linear regression using the lm() function.
  - Confidence and prediction intervals.
  - Model diagnostics with residual plots.
  - Variance inflation factors (VIF) for multicollinearity.
  - Polynomial regression and interaction terms.
  - Model comparison using ANOVA.
  - Working with datasets such as Boston and Carseats.

### **Lab 4: Classification and Model Evaluation**  
- **File:** CS5565_lab_4.R  
- **Topics Covered:**
  - Logistic regression using glm().
  - Confusion matrices and model accuracy evaluation.
  - Linear and Quadratic Discriminant Analysis (lda, qda).
  - Naive Bayes classifier using naiveBayes().
  - K-Nearest Neighbors (knn()) classification.
  - Poisson regression for count data.
  - Application to datasets such as Smarket and Caravan.

## Installation  
Ensure R and the required libraries are installed before running the scripts.  

### Required R Packages  
- MASS  
- ISLR2  
- e1071  
- class  
- car  

To install the necessary packages, run:  
install.packages(c("MASS", "ISLR2", "e1071", "class", "car"))

## Usage  
1. Open RStudio or an R console.  
2. Load the dataset with library(ISLR2) or library(MASS).  
3. Run the script using:  
   source("CS5565_lab_3.R")  
   source("CS5565_lab_4.R")  
4. View model summaries and results in the R console or through plots generated in RStudio.

## Example Output  
- **Linear Regression (Lab 3)**  
  summary(lm(medv ~ lstat, data = Boston))  
  - Returns coefficients, R-squared, and residual statistics.  
- **Logistic Regression (Lab 4)**  
  glm.fits <- glm(Direction ~ Lag1 + Lag2, data = Smarket, family = binomial)  
  summary(glm.fits)  
  - Displays coefficients and model accuracy.

## Contributions  
This repository is designed for educational purposes. Feel free to fork and modify the scripts.  

## License  
This project is licensed under the **MIT License**.

---
**Author:** Alexander Dowell  
