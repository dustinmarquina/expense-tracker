import 'package:flutter/material.dart';

import '../db/hive_box.dart';
import '../models/expense.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({Key? key}) : super(key: key);

  Map<String, double> _aggregateByCategory(List<Expense> list) {
    final Map<String, double> map = {};
    for (final e in list) {
      map[e.category] = (map[e.category] ?? 0) + e.amount;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final box = HiveBox.box();
    final expenses = box.values.toList().cast<Expense>();
    final byCat = _aggregateByCategory(expenses);
    final total = byCat.values.fold<double>(0, (a, b) => a + b);

    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (byCat.isEmpty)
              const Center(child: Text('No data'))
            else ...[
              Text('Total: \$${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              // Simple textual/linear visualization per category
              ...byCat.entries.map((e) {
                final pct = total == 0 ? 0.0 : e.value / total;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.key),
                          Text(
                              '\$${e.value.toStringAsFixed(2)} (${(pct * 100).toStringAsFixed(0)}%)'),
                        ],
                      ),
                      const SizedBox(height: 6),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: pct,
                          minHeight: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ]
          ],
        ),
      ),
    );
  }
}
