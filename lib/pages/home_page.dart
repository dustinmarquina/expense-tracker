import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/expense.dart';
import '../db/hive_box.dart';
import 'add_expense_page.dart';
import 'stats_page.dart';
import '../widgets/expense_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box<Expense> box;

  @override
  void initState() {
    super.initState();
    box = HiveBox.box();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StatsPage()),
            ),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Expense> b, _) {
          final expenses = b.values.toList().cast<Expense>();
          if (expenses.isEmpty) {
            return const Center(child: Text('No expenses yet'));
          }
          expenses.sort((a, b) => b.date.compareTo(a.date));
          return ListView.separated(
            itemCount: expenses.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final e = expenses[index];
              return ExpenseTile(expense: e);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddExpensePage()));
        },
      ),
    );
  }
}
