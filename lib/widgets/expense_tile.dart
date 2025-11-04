import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';
import '../db/hive_box.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;
  const ExpenseTile({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(expense.title),
      subtitle: Text(
          '${expense.category} • ${DateFormat.yMMMd().format(expense.date)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('\$${expense.amount.toStringAsFixed(2)}'),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () async {
              await HiveBox.removeExpense(expense.id);
            },
          )
        ],
      ),
    );
  }
}
