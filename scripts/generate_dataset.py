import argparse
import csv
import random
from datetime import datetime, timedelta
from pathlib import Path


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default="datasets/transactions.csv")
    parser.add_argument("--rows", type=int, default=85000)
    args = parser.parse_args()

    randomizer = random.Random(42)
    path = Path(args.output)
    path.parent.mkdir(parents=True, exist_ok=True)
    start = datetime(2026, 11, 1, 8, 0, 0)
    stores = ["CALI", "BOGOTA", "MEDELLIN", "BARRANQUILLA", "CARTAGENA"]
    statuses = ["APPROVED", "APPROVED", "APPROVED", "DECLINED", "PENDING"]

    with path.open("w", newline="", encoding="utf-8") as output:
        writer = csv.writer(output)
        writer.writerow(["transaction_id", "timestamp", "store", "amount_cop", "status"])
        for number in range(1, args.rows + 1):
            timestamp = start + timedelta(seconds=number)
            writer.writerow([
                f"TX{number:08d}",
                timestamp.isoformat(),
                randomizer.choice(stores),
                randomizer.randint(10000, 1500000),
                randomizer.choice(statuses),
            ])

    print(f"Generated {args.rows} transactions in {path} ({path.stat().st_size:,} bytes)")


if __name__ == "__main__":
    main()
