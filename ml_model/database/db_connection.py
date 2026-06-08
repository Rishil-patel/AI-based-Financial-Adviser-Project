from sqlalchemy import create_engine
import pandas as pd

# PostgreSQL Connection URL
DATABASE_URL = "postgresql://postgres:your_password@localhost:5432/financial_advisor"
# DATABASE_URL = "postgresql://postgres:THIS_IS_DEFINITELY_WRONG_123456@localhost:5432/financial_advisor"

# Create Engine
engine = create_engine(DATABASE_URL)


def test_connection():
    try:
        with engine.connect():
            print("✅ Database Connected Successfully")
    except Exception as e:
        print("❌ Connection Failed:", e)


def fetch_data(query):
    try:
        return pd.read_sql(query, engine)
    except Exception as e:
        print("❌ Error:", e)
        return None


# Test Connection
test_connection()

tables = [
    "users",
    "departments",
    "expense_categories",
    "expenses",
    "revenue",      
    "budgets"
]

print("\n=== TABLE SHAPES ===")

for table in tables:
    df = fetch_data(f"SELECT * FROM {table};")

    if df is not None:
        print(f"{table:<20} {df.shape}")
    else:
        print(f"{table:<20} FAILED")