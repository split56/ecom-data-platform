import argparse
import os
from dotenv import load_dotenv
import pandas as pd
from sqlalchemy import create_engine, text
from sqlalchemy.engine import URL

COLUMNS = ["user_id", "item_id", "category_id", "behavior", "ts"]
START_TS = 1511539200   # 2017-11-25 00:00 Beijing
END_TS = 1512316800     # 2017-12-04 00:00 Beijing

load_dotenv("docker/.env")

def extract(path):
    return pd.read_csv(path, header=None, names=COLUMNS)


def clean(df):
    df["behavior"] = df["behavior"].str.strip().str.lower()

    is_valid = (
        df.notna().all(axis=1)
        & df["behavior"].isin(["pv", "cart", "fav", "buy"])
        & df["ts"].between(START_TS, END_TS - 1)
    )
    rejected = df[~is_valid]
    cleaned = df[is_valid].drop_duplicates().copy()

    cleaned["event_time"] = (pd.to_datetime(cleaned["ts"], unit="s", utc=True)
                             .dt.tz_convert("Asia/Shanghai")
                             .dt.tz_localize(None))
    cleaned["dt"] = cleaned["event_time"].dt.date
    return cleaned, rejected


def load(cleaned, summary):
    url = URL.create("mysql+pymysql", username="root", password=os.environ["MYSQL_ROOT_PASSWORD"],
                     host="127.0.0.1", port=3306, database="ecom")
    engine = create_engine(url)
    days = {"first": cleaned["dt"].min(), "last": cleaned["dt"].max()}

    with engine.begin() as conn:   # one transaction: all or nothing
        conn.execute(text("DELETE FROM user_behavior WHERE dt BETWEEN :first AND :last"), days)
        conn.execute(text("DELETE FROM behavior_daily_summary WHERE dt BETWEEN :first AND :last"), days)
        cleaned.to_sql("user_behavior", conn, if_exists="append", index=False,
                       chunksize=10000, method="multi")
        summary.to_sql("behavior_daily_summary", conn, if_exists="append", index=False)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True)
    args = parser.parse_args()

    raw = extract(args.input)
    cleaned, rejected = clean(raw)
    summary = cleaned.groupby(["dt", "behavior"]).size().reset_index(name="events")

    duplicates = len(raw) - len(rejected) - len(cleaned)
    print(f"read={len(raw)} rejected={len(rejected)} duplicates={duplicates} clean={len(cleaned)}")

    os.makedirs("data/behavior", exist_ok=True)
    cleaned.to_csv("data/behavior/clean.csv", index=False)
    rejected.to_csv("data/behavior/rejected.csv", index=False)
    summary.to_csv("data/behavior/daily_summary.csv", index=False)

    load(cleaned, summary)
    print("loaded into MySQL")


if __name__ == "__main__":
    main()