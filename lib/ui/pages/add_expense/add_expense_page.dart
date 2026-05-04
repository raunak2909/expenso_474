import 'package:expenso_474/data/models/expense_model.dart';
import 'package:expenso_474/domain/constants/app_constants.dart';
import 'package:expenso_474/domain/utils/ui_helper.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_bloc.dart';
import 'package:expenso_474/ui/pages/add_expense/bloc/expense_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/expense_state.dart';

class AddExpensePage extends StatelessWidget {
  var titleController = TextEditingController();
  var remarkController = TextEditingController();
  var amtController = TextEditingController();

  List<String> mTypes = ["Debit", "Credit"];
  int selectedTypeIndex = 0;
  int selectedCatIndex = -1;
  DateTime? selectedDate;
  DateFormat df = DateFormat.yMMMEd();
  bool isLoading  = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: mInputFieldDecoration(
                hintText: "Enter your title here..",
                labelText: "Title",
              ),
            ),
            SizedBox(height: 11),
            TextField(
              controller: remarkController,
              decoration: mInputFieldDecoration(
                hintText: "Enter your remark here..",
                labelText: "Remark",
              ),
            ),
            SizedBox(height: 11),
            TextField(
              controller: amtController,
              decoration: mInputFieldDecoration(
                hintText: "Enter your amount here..",
                labelText: "Amount",
              ),
            ),

            /*mTypes.map((e){
              return DropdownMenuItem(child: Text(e), value: e,);
            }).toList(),*/
            /*StatefulBuilder(
              builder: (context, sS) {
                return DropdownButton(
                  items: List.generate(mTypes.length, (index){
                    return DropdownMenuItem(child: Text(mTypes[index]), value: index,);
                  }),
                  value: selectedTypeIndex,
                  onChanged: (value) {
                    selectedTypeIndex = value!;
                    sS(() {});
                  },
                );
              },
            ),*/
            SizedBox(height: 11),

            DropdownMenuFormField(
              width: double.infinity,
              label: Text("Type"),
              inputDecorationTheme: InputDecorationThemeData(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.pink.shade200),
                  borderRadius: BorderRadius.circular(11),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              initialSelection: selectedTypeIndex,
              onSelected: (value) {
                selectedTypeIndex = value!;
              },
              dropdownMenuEntries: List.generate(mTypes.length, (index) {
                return DropdownMenuEntry(value: index, label: mTypes[index]);
              }),
            ),

            SizedBox(height: 11),

            StatefulBuilder(
              builder: (context, ss) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return Container(
                          padding: EdgeInsets.only(top: 19),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(51),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Choose a Category",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 19),
                              Expanded(
                                child: GridView.builder(
                                  itemCount: AppConstants.mCat.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                      ),
                                  itemBuilder: (_, index) {
                                    return InkWell(
                                      onTap: () {
                                        selectedCatIndex = index;
                                        Navigator.pop(context);
                                        ss(() {});
                                      },
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            AppConstants.mCat[index].imgPath,
                                            width: 60,
                                            height: 60,
                                          ),
                                          Text(AppConstants.mCat[index].title),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(),
                    ),
                    child: Center(
                      child: selectedCatIndex >= 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppConstants.mCat[selectedCatIndex].imgPath,
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(width: 11),
                                Text(
                                  " - ${AppConstants.mCat[selectedCatIndex].title}",
                                ),
                              ],
                            )
                          : Text('Choose Category'),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 11),
            StatefulBuilder(
              builder: (context, sS) {
                return InkWell(
                  onTap: () async {
                    DateTime? userSelection = await showDatePicker(
                      currentDate: selectedDate ?? DateTime.now(),
                      context: context,
                      firstDate: DateTime.now().subtract(Duration(days: 732)),
                      lastDate: DateTime.now(),
                    );
                    if(userSelection!=null){
                      selectedDate = userSelection;
                    } else {
                      selectedDate ??= DateTime.now();
                    }
                    sS(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(),
                    ),
                    child: Center(
                      child: Text(df.format(selectedDate ?? DateTime.now())),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 11),
            BlocConsumer<ExpenseBloc, ExpenseState>(
              listener: (_, state){

                if(state is ExpenseLoadingState){
                  isLoading = true;
                }

                if(state is ExpenseLoadedState){
                  isLoading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Expense added successfully"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                }

                if(state is ExpenseErrorState){
                  isLoading = false;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMsg),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

              },
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      /*maximumSize: Size(double.infinity, 55),
                      minimumSize: Size(double.infinity, 55),*/
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.pink.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                    onPressed: () async {
                      if (selectedCatIndex >= 0) {

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        int uid = prefs.getInt(AppConstants.PREF_USER_KEY) ?? 0;

                        context.read<ExpenseBloc>().add(
                          AddExpenseEvent(
                            newExp: ExpenseModel(
                              uId: uid,
                              eTitle: titleController.text,
                              eRemark: remarkController.text,
                              eType: selectedTypeIndex,
                              eCatId: AppConstants.mCat[selectedCatIndex].id,
                              eCreatedAt: (selectedDate ?? DateTime.now()).millisecondsSinceEpoch,
                              eAmt: double.parse(amtController.text),
                            ),
                          ),
                        );
                      }
                    },
                    child: isLoading ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircularProgressIndicator(color: Colors.white,),
                        ),
                        SizedBox(width: 11),
                        Text('Adding Expense...'),
                      ],
                    ) : Text('Add Expense'),
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
