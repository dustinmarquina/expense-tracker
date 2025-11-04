import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../models/expense.dart';
import '../db/hive_box.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtl = TextEditingController();
  final _amountCtl = TextEditingController();
  DateTime _date = DateTime.now();
  String _category = 'Other';

  final _uuid = const Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleCtl,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Enter title' : null,
              ),
              TextFormField(
                controller: _amountCtl,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => (v == null || double.tryParse(v) == null)
                    ? 'Enter valid amount'
                    : null,
              ),
              Row(
                children: [
                  Text('Date: ${DateFormat.yMd().format(_date)}'),
                  const SizedBox(width: 8),
                  TextButton(
                      onPressed: () async {
                        final d = await showDatePicker(
                          context: context,
                          initialDate: _date,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (d != null) setState(() => _date = d);
                      },
                      child: const Text('Change'))
                ],
              ),
              DropdownButtonFormField<String>(
                value: _category,
                items: ['Food', 'Transport', 'Shopping', 'Bills', 'Other']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v ?? 'Other'),
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final e = Expense(
                      id: _uuid.v4(),
                      title: _titleCtl.text.trim(),
                      amount: double.parse(_amountCtl.text.trim()),
                      date: _date,
                      category: _category,
                    );
                    await HiveBox.addExpense(e);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
