import 'dart:math';

import 'package:expenso_474/data/models/expense_model.dart';
import 'package:expenso_474/data/models/filter_expense_model.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_bloc.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../add_expense/bloc/expense_event.dart';

class ChartNavPage extends StatefulWidget {
  const ChartNavPage({super.key});

  @override
  State<ChartNavPage> createState() => _ChartNavPageState();
}

class _ChartNavPageState extends State<ChartNavPage> {

  List<Map<String, dynamic>> calculatePercentageByCatExpense(List<FilterExpenseModel> mExp){
    List<Map<String, dynamic>> catPercentage  = [];
    double totalExp = 0.0;

    for(FilterExpenseModel eachCatFilter in mExp){
      totalExp += eachCatFilter.balance.abs();
    }
    print("total exp: ${totalExp.abs()}");

    for(FilterExpenseModel eachCatFilter in mExp){
      catPercentage.add({
        "percentage" : eachCatFilter.balance.abs()/totalExp,
        "title" : eachCatFilter.title
      });
      print("percentage: ${eachCatFilter.balance.abs()/totalExp.abs()}");
    }

    return catPercentage;
  }

  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchAllExpensesEvent(filterType: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            if(state is ExpenseLoadingState){
              return Center(child: CircularProgressIndicator());
            }

            if(state is ExpenseErrorState){
              return Center(child: Text(state.errorMsg));
            }

            if(state is ExpenseLoadedState){

              List<Map<String, dynamic>> catPercentage = calculatePercentageByCatExpense(state.expenses);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300,
                  ),
                  Container(
                    width: double.infinity,
                    height: 250,
                    color: Colors.pink.shade200,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text('Spending Details', style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900
                  ),),
                  Text('Your expenses are divided into 6 categories'),
                  SizedBox(
                    height: 11,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: catPercentage.map((element){
                        return Expanded(
                            flex: (element['percentage']*100).toInt(),
                            child: Column(
                              crossAxisAlignment : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20,
                                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                  child: Center(
                                    child: Text('${(element['percentage']*100).toInt()}%', style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.white
                                    ),),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('${element['title']}', style: TextStyle(
                                    fontSize: 11
                                ),)
                              ],
                            ));
                      }).toList(),
                    ),
                  )
                ],
              );
            }

            return Container();
          }
        ),
      )
    );
  }
}