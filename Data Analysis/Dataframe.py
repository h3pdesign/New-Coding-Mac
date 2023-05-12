# Import the pandas library, renamed as pd
import pandas as pd

# Read IND_data.csv into a DataFrame, assigned to df
df = pd.read_csv("IND_data.csv")

# Prints the first 5 rows of a DataFrame as default
df.head()

# Prints no. of rows and columns of a DataFrame
df.shape

edit
play_arrow
brightness_4
# prints first 5 rows and every column which replicates df.head()
df.iloc[0:5, :]
# prints entire rows and columns
df.iloc[:, :]
# prints from 5th rows and first 5 columns
df.iloc[5:, :5]

edit
play_arrow
brightness_4
# assigning two series to s1 and s2
s1 = pd.Series([1, 2])
s2 = pd.Series(["Ashish", "Sid"])
# framing series objects into data
df = pd.DataFrame([s1, s2])
# show the data frame
df

# data framing in another way
# taking index and column values
dframe = pd.DataFrame(
    [[1, 2], ["Ashish", "Sid"]], index=["r1", "r2"], columns=["c1", "c2"]
)
dframe

# framing in another way
# dict-like container
dframe = pd.DataFrame({"c1": [1, "Ashish"], "c2": [2, "Sid"]})
dframe


# import the required module
import matplotlib.pyplot as plt

# plot a histogram
df["Observation Value"].hist(bins=10)

# shows presence of a lot of outliers/extreme values
df.boxplot(column="Observation Value", by="Time period")

# plotting points as a scatter plot
x = df["Observation Value"]
y = df["Time period"]
plt.scatter(x, y, label="stars", color="m", marker="*", s=30)
# x-axis label
plt.xlabel("Observation Value")
# frequency label
plt.ylabel("Time period")
# function to show the plot
plt.show()
