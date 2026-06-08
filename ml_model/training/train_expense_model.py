import pandas as pd
import numpy as np
import joblib

from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import (
    mean_absolute_error,
    mean_squared_error,
    r2_score
)

from ml_model.database.db_connection import fetch_data


# =========================================
# FETCH DATA
# =========================================

query = """
SELECT *
FROM expenses;
"""

df_raw = fetch_data(query)

if df_raw is None or df_raw.empty:
    print("No data found.")
    exit()


# =========================================
# WORKING COPY
# =========================================

df = df_raw.copy()

print("\nColumns:")
print(df.columns.tolist())


# =========================================
# DATE FEATURES
# =========================================

expense_date = pd.to_datetime(df["expense_date"])

df["month"] = expense_date.dt.month
df["year"] = expense_date.dt.year


# =========================================
# MONTHLY AGGREGATION
# =========================================

monthly_df = (
    df.groupby(
        ["user_id", "month", "year"]
    )["amount"]
    .sum()
    .reset_index()
)

print("\nMonthly Dataset:")
print(monthly_df.head())

print(monthly_df.shape[0], "rows in monthly dataset.",)
# =========================================
# FEATURES / TARGET
# =========================================

X = monthly_df[["user_id", "month", "year"]]

y = monthly_df["amount"]


# =========================================
# TRAIN TEST SPLIT
# =========================================

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.2,
    random_state=42
)


# =========================================
# RANDOM FOREST MODEL
# =========================================

model = RandomForestRegressor(
    n_estimators=300,
    max_depth=10,
    random_state=42,
    n_jobs=-1
)

model.fit(X_train, y_train)


# =========================================
# PREDICTIONS
# =========================================

predictions = model.predict(X_test)


# =========================================
# EVALUATION
# =========================================

mae = mean_absolute_error(y_test, predictions)

rmse = np.sqrt(
    mean_squared_error(y_test, predictions)
)

r2 = r2_score(y_test, predictions)

print("\n===== MODEL EVALUATION =====")
print(f"MAE  : {mae:.2f}")
print(f"RMSE : {rmse:.2f}")
print(f"R²   : {r2:.4f}")


# =========================================
# SAVE MODEL
# =========================================

# joblib.dump(
#     model,
#     "ml_model/trained_models/expense_prediction_model.pkl"
# )

print("\nModel saved successfully.")

