library(dplyr)
library(ggplot2)
library(tidyr)
library(scales)

#Task 1: Load the NYC Green Taxi Trip Records data into a data frame called tripdata_df. Inspect the data to 
#identify its dimensions and the frequency of missing values. Helpful functions: dim(), glimpse() and 
#summary().

# Reading the csv file
taxidata_df<- read.delim2("2018_Green_Taxi_Trip_Data.csv", header= TRUE,sep=",",na.strings=c(""))

# Checking the dimensions and the summary
dim(taxidata_df)
glimpse(taxidata_df) 
summary(taxidata_df)
sapply(taxidata_df, function(x) sum(is.na(x)))

# The dimensions of the data are "1048575*19". This means the data has 1048575 rows and 19 columns. 
# The column ehail_fee shows "NA", that is it is completely empty. The trip_type has 3 missing values. 

# Task 2 :  Explore the data to determine if there are any inconsistent or invalid data; for example, examine the dates 
#within the dataset to see if they align with your expectations. Identify at least Three (3) things that stand 
#out to you and remember that this is based on your observations about the data, so it's important to 
#demonstrate what you found. 
# Inspect the data and identify at least three columns/fields that should be represented as factors and 
# convert their respective data types to a factor. Hint: make use of the data dictionary to understand the 
# range of values for each field. 

taxidata_df

# 1.The dataset is from 2018, NYC Green taxi record. It has 1048575 rows and 19 columns. 
# 2. It shows VendorID, pick up and drop off date and time, the number of passengers per trip, the distance of the trip, tip amount, fare etc. The ehail_fee column is empty and there are 3 missing values in trip_type. There are 5 types of payment methods in the dataset. 

#3. The frequency of the payments can be seen by following code:
taxidata_df %>%
  group_by(payment_type) %>%
  summarise(frequency= n() )

#4. The types of trip can be seen as follows:
taxidata_df %>%
  group_by(trip_type) %>%
  summarise(frequency=n())

# The single round trips made by the taxi were 1030020 and double trips made by the taxi were 18552

#5. The pickup and date and time can be seen as follows:
taxidata_df %>%
  filter(lpep_pickup_datetime < "2018-01-01" | lpep_pickup_datetime > "2018-03-01" | lpep_dropoff_datetime < "2020-02-01" | lpep_dropoff_datetime > "2020-03-01" ) %>%
  select(lpep_pickup_datetime, lpep_dropoff_datetime)

