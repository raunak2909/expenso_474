import 'package:expenso_474/data/models/expense_model.dart';
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
      body: BlocBuilder<ExpenseBloc, ExpenseState>(builder: (_, state){

        if(state is ExpenseLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }

        if(state is ExpenseLoadedState){

          return state.expenses.isNotEmpty ? ListView.builder(
            itemCount: state.expenses.length,
              itemBuilder: (_, index){
            ExpenseModel eachExp = state.expenses[index];
            return Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(eachExp.eTitle),
                    Text("₹${eachExp.eAmt}"),
                  ],
                ),
                subtitle: Text(eachExp.eRemark),
              ),
            );

          }) : Center(
            child: Text('No Expenses Yet!!'),
          );

        }

        if(state is ExpenseErrorState){
          return Center(
            child: Text(state.errorMsg),
          );
        }


        return Container();

      }),
    );
  }
}
