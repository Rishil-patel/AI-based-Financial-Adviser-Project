from ml_model.database.db_connection import fetch_data

tables = ["users", "departments", "expense_categories",
          "expenses", "revenues", "budgets"]

for table in tables:
    df = fetch_data(f"SELECT * FROM {table};")
    print(f"{table}: {df.shape}")