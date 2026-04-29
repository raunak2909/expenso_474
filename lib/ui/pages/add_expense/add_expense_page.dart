import 'package:expenso_474/domain/constants/app_constants.dart';
import 'package:expenso_474/domain/utils/ui_helper.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  var titleController = TextEditingController();
  var remarkController = TextEditingController();
  var amtController = TextEditingController();

  List<String> mTypes = ["Debit", "Credit"];
  int selectedTypeIndex = 0;
  int selectedCatIndex = -1;

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
            InkWell(
              onTap: (){
                showDatePicker(
                    context: context,
                    firstDate: DateTime.now().subtract(Duration(days: 732)),
                    lastDate: DateTime.now());
              },
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(),
                ),
                child: Center(
                  child: Text('Choose a Date'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
