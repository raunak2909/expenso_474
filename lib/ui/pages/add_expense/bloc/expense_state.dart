import 'package:expenso_474/data/models/filter_expense_model.dart';

import '../../../../data/models/expense_model.dart';

abstract class ExpenseState{}

class ExpenseInitialState extends ExpenseState{}
class ExpenseLoadingState extends ExpenseState{}
class ExpenseLoadedState extends ExpenseState{
  List<FilterExpenseModel> expenses;
  ExpenseLoadedState({required this.expenses});
}
class ExpenseErrorState extends ExpenseState{
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});
}