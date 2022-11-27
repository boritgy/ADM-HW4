#GROUP 13

# 1. Which location has the maximum number of purchases been made?
# 2. In the dataset provided, did females spend more than males, or vice versa?
# 3. Report the customer with the highest average transaction amount in the dataset.

#Using AWS

cd SageMaker #where I uploaded bank_transactions.csv

# take a look to the dataset
head bank_transactions.csv

echo '1. First 10 locations with maximum number of purchases:'

awk -F ',' '{print $5}' bank_transactions.csv | sort | uniq -c | sort -nr | head -10

# verifica python:
# data.groupby(['CustLocation'])['CustLocation'].count().sort_values(ascending=False).head(10)

# CustLocation
# MUMBAI       103595
# NEW DELHI     84928
# BANGALORE     81555
# GURGAON       73818
# DELHI         71019
# NOIDA         32784
# CHENNAI       30009
# PUNE          25851
# HYDERABAD     23049
# THANE         21505


echo '2. In the dataset provided, did females spend more than males, or vice versa?'

echo 'Average of females purchases: '
awk -F ',' '$4=="F"{sum+=$9;cnt++}END{print sum/cnt}' bank_transactions.csv
echo 'Sum of females purchases: '
awk -F ',' '$4=="F"{sum+=$9}END{print sum}' bank_transactions.csv

echo 'Average of males purchases: '
awk -F ',' '$4=="M"{sum+=$9;cnt++}END{print sum/cnt}' bank_transactions.csv
echo 'Sum of males purchases: '
awk -F ',' '$4=="M"{sum+=$9}END{print sum}' bank_transactions.csv

# Results:
# In absolute M spend more:
# M    1.181645e+09
# F    4.668110e+08
# T    3.250000e+04

# On average 'F' spend more, at net of 'T' sex category.
# T    32500.000000  => just 1 person
# F     1655.733753
# M     1543.564378

# verifica python:
# data.groupby('CustGender')['TransactionAmount (INR)'].sum().sort_values(ascending=False)
# data.groupby('CustGender')['TransactionAmount (INR)'].mean().sort_values(ascending=False)


echo '3. Customer with the highest average transaction amount in the dataset: '
awk -F ',' '{seen[$2]+=$9; count[$2]++} END{for (x in seen)print  seen[x]/count[x],x}' bank_transactions.csv | sort -nr | head -n 1
# 991132 C4141768 

# verifica python
# data.groupby('CustomerID')['TransactionAmount (INR)'].mean().sort_values(ascending=False).head(1)
# C4141768     991132.22  

