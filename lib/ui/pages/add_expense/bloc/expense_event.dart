import '../../../../data/models/expense_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExp;
  AddExpenseEvent({required this.newExp});
}

class FetchAllExpensesEvent extends ExpenseEvent{
  int filterType;
  FetchAllExpensesEvent({this.filterType=0});
}