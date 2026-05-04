import 'package:expenso_474/data/helper/db_helper.dart';
import 'package:expenso_474/data/models/expense_model.dart';
import 'package:expenso_474/data/models/filter_expense_model.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_event.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DBHelper dbHelper;
  DateFormat df = DateFormat.yMMMMEEEEd();

  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      bool isAdded = await dbHelper.addExpense(newExpense: event.newExp);

      if (isAdded) {
        var allExp = await dbHelper.fetchAllExpenses();
        emit(ExpenseLoadedState(
            expenses: filterExpensesByType(allExpenses: allExp)));
      } else {
        emit(ExpenseErrorState(errorMsg: "Something went wrong"));
      }
    });

    on<FetchAllExpensesEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      var allExp = await dbHelper.fetchAllExpenses();
      emit(ExpenseLoadedState(
          expenses: filterExpensesByType(allExpenses: allExp)));
    });
  }

  List<FilterExpenseModel> filterExpensesByType(
      {required List<ExpenseModel> allExpenses}) {
    List<FilterExpenseModel> listFilterExpModel = [];

    ///filter
    ///date-wise
    ///month-wise
    ///year-wise
    ///category-wise
    List<String> uniqueDates = [];
    Set<String> uniqueDateSet = {};

    for (ExpenseModel eachExp in allExpenses) {
      String eachExpDate = df.format(
          DateTime
              .fromMillisecondsSinceEpoch(eachExp.eCreatedAt));

      uniqueDateSet.add(eachExpDate);

      /*if(!uniqueDates.contains(eachExpDate)){
        uniqueDates.add(eachExpDate);
      }*/
    }

    uniqueDates = uniqueDateSet.toList();
    print(uniqueDates);

    ///filter data according unique dates
    for (String eachDate in uniqueDates) {
      num eachTypeExpBal = 0.0;
      List<ExpenseModel> eachTypeExp = [];

      for (ExpenseModel eachExp in allExpenses) {
        String eachExpDate = df.format(
            DateTime
                .fromMillisecondsSinceEpoch(eachExp.eCreatedAt));


        if (eachDate == eachExpDate) {
          eachTypeExp.add(eachExp);

          if (eachExp.eType == 0) {
            eachTypeExpBal -= eachExp.eAmt;
          } else {
            eachTypeExpBal += eachExp.eAmt;
          }
        }
      }

      listFilterExpModel.add(
          FilterExpenseModel(
              title: eachDate,
              balance: eachTypeExpBal,
              mExp: eachTypeExp));
    }


    return listFilterExpModel;
  }

}