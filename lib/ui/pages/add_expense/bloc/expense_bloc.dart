import 'package:expenso_474/data/helper/db_helper.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_event.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState>{
  DBHelper dbHelper;
  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()){

    on<AddExpenseEvent>((event, emit) async {

      emit(ExpenseLoadingState());
      bool isAdded = await dbHelper.addExpense(newExpense: event.newExp);

      if(isAdded){
        emit(ExpenseLoadedState(expenses: await dbHelper.fetchAllExpenses()));
      } else {
        emit(ExpenseErrorState(errorMsg: "Something went wrong"));
      }

    });

    on<FetchAllExpensesEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      var allExp = await dbHelper.fetchAllExpenses();
      emit(ExpenseLoadedState(expenses: allExp));
    });

  }

}