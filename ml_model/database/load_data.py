from ml_model.database.db_connection import fetch_data

query = """
SELECT *
FROM expenses;
"""

df = fetch_data(query)

if df is not None:
    print(df.head())
    print("\nShape:", df.shape)
else:
    print("Failed to fetch data")