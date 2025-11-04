import 'package:hive/hive.dart';
import '../models/expense.dart';

class HiveBox {
  static const String expensesBox = 'expenses_box';

  static Future<Box<Expense>> open() async {
    return await Hive.openBox<Expense>(expensesBox);
  }

  static Box<Expense> box() {
    return Hive.box<Expense>(expensesBox);
  }

  static Future<void> addExpense(Expense e) async {
    final b = Hive.box<Expense>(expensesBox);
    await b.put(e.id, e);
  }

  static Future<void> removeExpense(String id) async {
    final b = Hive.box<Expense>(expensesBox);
    await b.delete(id);
  }
}
