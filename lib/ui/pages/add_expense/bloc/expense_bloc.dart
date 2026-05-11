import 'package:expenso_474/data/helper/db_helper.dart';
import 'package:expenso_474/data/models/cat_model.dart';
import 'package:expenso_474/data/models/expense_model.dart';
import 'package:expenso_474/data/models/filter_expense_model.dart';
import 'package:expenso_474/domain/constants/app_constants.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_event.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DBHelper dbHelper;


  ExpenseBloc({required this.dbHelper}) : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      emit(ExpenseLoadingState());
      bool isAdded = await dbHelper.addExpense(newExpense: event.newExp);


      if (isAdded) {
        bool isBalanceUpdated = await dbHelper.updateBalance(newExpense: event.newExp);

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
          expenses: filterExpensesByType(allExpenses: allExp, filterType: event.filterType)));
    });
  }

  ///0->date-wise, 1->month-wise, 2->year-wise, 3->category-wise
  List<FilterExpenseModel> filterExpensesByType(
      {required List<ExpenseModel> allExpenses, int filterType = 0}) {
    List<FilterExpenseModel> listFilterExpModel = [];


    ///filter
    if(filterType<3){
      ///date-wise
      ///month-wise
      ///year-wise

      List<String> uniqueDates = [];
      Set<String> uniqueDateSet = {};

      ///date format
      DateFormat df = DateFormat.yMMMMEEEEd();

      if(filterType==1){
        ///month format
        df = DateFormat.yMMMM();
      } else if(filterType==2){
        ///year format
        df = DateFormat.y();
      }


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
    } else {
      /// category-wise

      ///filter data according cat id
      for (CatModel eachCat in AppConstants.mCat) {
        num eachTypeExpBal = 0.0;
        List<ExpenseModel> eachTypeExp = [];

        for (ExpenseModel eachExp in allExpenses) {


          if (eachCat.id == eachExp.eCatId) {
            eachTypeExp.add(eachExp);

            if (eachExp.eType == 0) {
              eachTypeExpBal -= eachExp.eAmt;
            } else {
              eachTypeExpBal += eachExp.eAmt;
            }
          }
        }

        if(eachTypeExp.isNotEmpty){
          listFilterExpModel.add(
              FilterExpenseModel(
                  title: eachCat.title,
                  balance: eachTypeExpBal,
                  mExp: eachTypeExp));
        }
      }
    }


    return listFilterExpModel;
  }

}