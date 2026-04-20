import 'package:expenso_474/data/helper/db_helper.dart';

class UserModel {
  int? uid;
  int createAt;
  String name, email, mobNo, pass;
  num budget, balance;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    required this.mobNo,
    required this.budget,
    required this.balance,
    required this.pass,
    required this.createAt,
  });

  ///fromMap
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map[DBHelper.COLUMN_USER_ID],
      name: map[DBHelper.COLUMN_USER_NAME],
      email: map[DBHelper.COLUMN_USER_EMAIL],
      mobNo: map[DBHelper.COLUMN_USER_MOB_NO],
      budget: map[DBHelper.COLUMN_USER_BUDGET],
      balance: map[DBHelper.COLUMN_USER_BALANCE],
      pass: map[DBHelper.COLUMN_USER_PASS],
      createAt: map[DBHelper.COLUMN_USER_CREATED_AT],
    );
  }

  ///toMap
  Map<String, dynamic> toMap() {
    return {
      DBHelper.COLUMN_USER_NAME: name,
      DBHelper.COLUMN_USER_EMAIL: email,
      DBHelper.COLUMN_USER_MOB_NO: mobNo,
      DBHelper.COLUMN_USER_BUDGET: budget,
      DBHelper.COLUMN_USER_BALANCE: balance,
      DBHelper.COLUMN_USER_PASS: pass,
      DBHelper.COLUMN_USER_CREATED_AT: createAt,
    };
  }
}
