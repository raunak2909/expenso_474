import 'package:expenso_474/data/models/expense_model.dart';

class FilterExpenseModel {
  String title;
  num balance;
  List<ExpenseModel> mExp;

  FilterExpenseModel({
    required this.title,
    required this.balance,
    required this.mExp,
  });
}
