import '../../../../data/models/expense_model.dart';

abstract class ExpenseState{}

class ExpenseInitialState extends ExpenseState{}
class ExpenseLoadingState extends ExpenseState{}
class ExpenseLoadedState extends ExpenseState{
  List<ExpenseModel> expenses;
  ExpenseLoadedState({required this.expenses});
}
class ExpenseErrorState extends ExpenseState{
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});
}