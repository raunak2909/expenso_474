import 'package:expenso_474/data/helper/db_helper.dart';

class ExpenseModel {
  int? eId;
  int uId;
  String eTitle, eRemark;
  int eType, eCatId, eCreatedAt;
  num eAmt;

  ExpenseModel({
    this.eId,
    required this.uId,
    required this.eTitle,
    required this.eRemark,
    required this.eType,
    required this.eCatId,
    required this.eCreatedAt,
    required this.eAmt,
  });

  ///fromMap
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      eId: map[DBHelper.COLUMN_EXPENSE_ID],
      uId: map[DBHelper.COLUMN_USER_ID],
      eTitle: map[DBHelper.COLUMN_EXPENSE_TITLE],
      eRemark: map[DBHelper.COLUMN_EXPENSE_REMARK],
      eType: map[DBHelper.COLUMN_EXPENSE_TYPE],
      eCatId: map[DBHelper.COLUMN_EXPENSE_CATEGORY_ID],
      eCreatedAt: int.parse(map[DBHelper.COLUMN_EXPENSE_CREATED_AT]),
      eAmt: map[DBHelper.COLUMN_EXPENSE_AMOUNT],
    );
  }

  ///toMap
  Map<String, dynamic> toMap() {
    return {
      DBHelper.COLUMN_USER_ID: uId,
      DBHelper.COLUMN_EXPENSE_TITLE: eTitle,
      DBHelper.COLUMN_EXPENSE_REMARK: eRemark,
      DBHelper.COLUMN_EXPENSE_TYPE: eType,
      DBHelper.COLUMN_EXPENSE_CATEGORY_ID: eCatId,
      DBHelper.COLUMN_EXPENSE_CREATED_AT: eCreatedAt.toString(),
      DBHelper.COLUMN_EXPENSE_AMOUNT: eAmt,
    };
  }
}
