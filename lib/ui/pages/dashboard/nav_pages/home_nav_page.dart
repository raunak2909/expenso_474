

import 'dart:math';

import 'package:expenso_474/data/models/cat_model.dart';
import 'package:expenso_474/data/models/expense_model.dart';
import 'package:expenso_474/data/models/filter_expense_model.dart';
import 'package:expenso_474/domain/constants/app_constants.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_bloc.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_event.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNavPage extends StatefulWidget {
  const HomeNavPage({super.key});

  @override
  State<HomeNavPage> createState() => _HomeNavPageState();
}

class _HomeNavPageState extends State<HomeNavPage> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchAllExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExpenseBloc, ExpenseState>(
        builder: (_, state) {
          if (state is ExpenseLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is ExpenseLoadedState) {
            return state.expenses.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: ListView.builder(
                      itemCount: state.expenses.length,
                      itemBuilder: (_, index) {
                        FilterExpenseModel eachFilterExp =
                            state.expenses[index];
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(11),
                          margin: EdgeInsets.only(bottom: 11),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            border: BoxBorder.all(
                              color: Colors.grey.shade400,
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    eachFilterExp.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    eachFilterExp.balance.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 11),
                              Container(
                                width: double.infinity,
                                height: 0.5,
                                color: Colors.grey.shade400,
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: eachFilterExp.mExp.length,
                                itemBuilder: (_, childIndex) {
                                  ExpenseModel eachExp =
                                      eachFilterExp.mExp[childIndex];

                                  String eachExpCatImg = '';

                                  CatModel expCatModel = AppConstants.mCat.firstWhere((element){
                                    return element.id == eachExp.eCatId;
                                  });
                                  eachExpCatImg = expCatModel.imgPath;

                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    titleTextStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: 'poppins'
                                    ),
                                    subtitleTextStyle: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                        fontFamily: 'poppins'
                                    ),
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: Colors.primaries[Random().nextInt(Colors.primaries.length)].shade100
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(eachExpCatImg),
                                        ),
                                      ),
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(eachExp.eTitle),
                                        Text("₹${eachExp.eAmt}", style: TextStyle(
                                          color: eachExp.eType==0 ? Colors.pink.shade200 : Colors.green,
                                        ),),
                                      ],
                                    ),
                                    subtitle: Text(eachExp.eRemark),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Center(child: Text('No Expenses Yet!!'));
          }

          if (state is ExpenseErrorState) {
            return Center(child: Text(state.errorMsg));
          }

          return Container();
        },
      ),
    );
  }
}


