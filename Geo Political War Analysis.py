import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Load dataset
df = pd.read_csv(r"C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\geopolitical_war_impact_dataset.csv")

# -------------------------------
# DATA PREPARATION
# -------------------------------

df["Total_Attacks"] = df["Missiles_Launched"] + df["Drones_Launched"]
df["Total_Casualties"] = df["Deaths"] + df["Injuries"]

# Convert Date
df["Date"] = pd.to_datetime(df["Date"],
format="mixed",dayfirst=True,errors="coerce")
                               

# -------------------------------
# BASIC INFO
# -------------------------------

print("Dataset Shape:", df.shape)
print(df.head())

# -------------------------------
# CORRELATION
# -------------------------------

corr = df.corr(numeric_only=True)
print(corr)

important_cols = [
    "Total_Attacks",
    "Total_Casualties",
    "Deaths",
    "Injuries",
    "Oil_Price_USD",
    "Gold_Price_USD",
    "Stock_Index"
]

corr = df[important_cols].corr()

plt.figure(figsize=(8,6))
sns.heatmap(corr, annot=True, cmap="coolwarm", fmt=".2f")
plt.title("Key Relationship Heatmap")
plt.tight_layout()
plt.show()
# -------------------------------
# ATTACKS vs CASUALTIES
# -------------------------------

plt.figure()
sns.scatterplot(x="Total_Attacks", y="Total_Casualties", data=df)
plt.title("Attacks vs Casualties")
plt.show()

# -------------------------------
# ATTACK TREND
# -------------------------------

attack_trend = df.groupby("Date")["Total_Attacks"].sum()

plt.figure()
attack_trend.plot()
plt.title("Attack Trend Over Time")
plt.xlabel("Date")
plt.ylabel("Total Attacks")
plt.show()

# -------------------------------
# OIL PRICE TREND
# -------------------------------

oil_trend = df.groupby("Date")["Oil_Price_USD"].mean()

plt.figure()
oil_trend.plot()
plt.title("Oil Price Trend")
plt.show()

# -------------------------------
# GOLD PRICE TREND
# -------------------------------

gold_trend = df.groupby("Date")["Gold_Price_USD"].mean()

plt.figure()
gold_trend.plot()
plt.title("Gold Price Trend")
plt.show()

# -------------------------------
# COUNTRY ANALYSIS
# -------------------------------

country_attacks = df.groupby("Country")["Total_Attacks"].sum()

plt.figure()
country_attacks.plot(kind="bar")
plt.title("Attacks by Country")
plt.show()

# -------------------------------
# EVENT TYPE ANALYSIS
# -------------------------------

event_casualties = df.groupby("Event_Type")["Total_Casualties"].sum()

plt.figure()
event_casualties.plot(kind="bar")
plt.title("Casualties by Event Type")
plt.show()

# -------------------------------
# AREA RISK ANALYSIS
# -------------------------------

area_risk = df.groupby("Area")["Total_Casualties"].sum().sort_values(ascending=False).head(10)

plt.figure()
area_risk.plot(kind="bar")
plt.title("Top 10 Dangerous Areas")
plt.show()

# -------------------------------
# INSIGHT PRINT
# -------------------------------

print("\n--- KEY INSIGHTS ---")

print("Total Attacks:", df["Total_Attacks"].sum())
print("Total Casualties:", df["Total_Casualties"].sum())

print("Most Dangerous Area:", area_risk.idxmax())
print("Most Attacked Country:", country_attacks.idxmax())

print("Highest Oil Price:", df["Oil_Price_USD"].max())
print("Highest Gold Price:", df["Gold_Price_USD"].max())
