# Expense Tracker (Offline)

A small Flutter app that records daily expenses locally using Hive and visualizes statistics using fl_chart.

Features

- Add, list, and remove expenses
- Statistics page with charts
- Uses Hive for local storage (no network required)

Quick start

1. Ensure you have Flutter installed: https://flutter.dev/docs/get-started/install
2. From project root run:

```bash
flutter pub get
flutter run
```

Notes

- This project uses Hive (no build_runner). We implement a manual TypeAdapter in `lib/models/expense.dart`.
- Charts use `fl_chart`. You can extend the stats page for more analytics.

Next steps

- Add export/import CSV
- Add monthly filters and recurring expenses
- Add tests and CI
# expense-tracker
