import 'package:hive/hive.dart';

// Manual Hive TypeAdapter for Expense. We avoid code generation for simplicity.

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}

class ExpenseAdapter extends TypeAdapter<Expense> {
  @override
  final int typeId = 0;

  @override
  Expense read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final amount = reader.readDouble();
    final dateMillis = reader.readInt();
    final category = reader.readString();
    return Expense(
      id: id,
      title: title,
      amount: amount,
      date: DateTime.fromMillisecondsSinceEpoch(dateMillis),
      category: category,
    );
  }

  @override
  void write(BinaryWriter writer, Expense obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeDouble(obj.amount);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeString(obj.category);
  }
}
