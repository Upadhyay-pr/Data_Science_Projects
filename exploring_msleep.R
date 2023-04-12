library(dplyr)
library(ggplot2)
data(msleep)

# Task 1: Calculate the proportion of each category of vore as a percentage and visualize the results using a bar chart.
# getting the vore count
vore_number<- msleep %>%
  group_by(vore) %>%
  count(vore)

# finding percentage of vore proportion
vore_prop <- prop.table(vore_number$n)*100
vore_prop
# The proportion of carnivore is 22.891566, Herbivore is 38.554217, insectivore is 6.024096, omnivore is 24.096386. 

# generating the bar plot
ggplot(data=vore_number, aes(x=vore, y=vore_prop)) +
  geom_bar(stat="identity")

# The bar graph shows the proportion of each type on vore on y axis and all the types of vore on x axis. 
# Here it can be seen that in the msleep dataset the number of herbivores is highest and the number of insectivores is the lowest. 

# Task 2: Filter the data to extract data for just omnivores. Calculate the mean sleep_total for that group.

# Mean for the sleep_total
msleep %>%
  filter(vore == "omni") %>%
  summarize(mean_sleep_total= mean(sleep_total))

# The mean of the sleep_total is 10.925

# Create a scatterplot showing the relationship between bodywt and brainwt. Comment on any correlation that is visually apparent.
# Generating scatterplot between bodyweight and brainweight
ggplot(msleep, aes(x=bodywt, y=brainwt)) + geom_point() + scale_x_log10() + scale_y_log10()

# The graph shows brainweight on y axis and bodyweight on x axis. The scatterplot shows that bodyweight and brainweight are positively correlated. 
# As the bodyweight increases, the brainweight also increases. 

# Calculate the Pearson coefficient of correlation in R, to evaluate the strength of the correlation between bodywt and brainwt.
x <- msleep$bodywt
y<- msleep$brainwt
cor.test(x, y , method = c("pearson"))

# p-value is less than significance level hence we can reject the null hypothesis and we can say that strength of the correlation between bodywt and brainwt exists .
# The Pearson coefficient = 0.9337822 supports that the bodyweight and brainweight are positively corealted as in the previous question.

# Determine which mammals are outliers in terms of sleep_total. Outliers, for the sake of this question, are defined as values that are more than 1.5 standard deviations from the mean. 
# Display the name and sleep_total of the mammals which are outliers.

# finding mean and Standard deviation
me_an <- mean(msleep$sleep_total)
s_dev <- sd(msleep$sleep_total)

# getting threshold values for outliers
min_thresh <- me_an-(1.5*s_dev)
max_thresh <- me_an+(1.5*s_dev)

# find outlier
x <- msleep$sleep_total

outliers <- x[which(x < min_thresh | x > max_thresh)]
outliers <- as.integer(outliers)
outlier_mammals <- msleep[outliers, c("name","sleep_total")]
outlier_mammals

