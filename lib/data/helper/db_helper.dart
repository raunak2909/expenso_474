import 'dart:io';

import 'package:expenso_474/data/models/user_model.dart';
import 'package:expenso_474/domain/constants/app_constants.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();

  static DBHelper getInstance() => DBHelper._();

  Database? mDB;

  static String DB_NAME = "expensoDB.db";
  static String TABLE_USER = "users";
  static String COLUMN_USER_ID = "u_id";
  static String COLUMN_USER_NAME = "u_name";
  static String COLUMN_USER_EMAIL = "u_email";
  static String COLUMN_USER_MOB_NO = "u_mob_no";
  static String COLUMN_USER_PASS = "u_pass";
  static String COLUMN_USER_BUDGET = "u_budget";
  static String COLUMN_USER_BALANCE = "u_balance";
  static String COLUMN_USER_CREATED_AT = "u_created_at";

  static String TABLE_EXPENSE = "expenses";
  static String COLUMN_EXPENSE_ID = "e_id";
  static String COLUMN_EXPENSE_TITLE = "e_title";
  static String COLUMN_EXPENSE_REMARK = "e_remark";
  static String COLUMN_EXPENSE_AMOUNT = "e_amount";
  static String COLUMN_EXPENSE_CREATED_AT = "e_date";
  static String COLUMN_EXPENSE_CATEGORY_ID = "e_cat_id";
  static String COLUMN_EXPENSE_TYPE = "e_type";

  Future<Database> initDB() async {
    mDB ??= await openDB();
    return mDB!;
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, DB_NAME);

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''create table $TABLE_USER ( 
        $COLUMN_USER_ID integer primary key autoincrement, 
        $COLUMN_USER_NAME text, 
        $COLUMN_USER_EMAIL text, 
        $COLUMN_USER_MOB_NO text, 
        $COLUMN_USER_PASS text, 
        $COLUMN_USER_BUDGET real, 
        $COLUMN_USER_BALANCE real, 
        $COLUMN_USER_CREATED_AT text 
        )''');

        db.execute('''create table $TABLE_EXPENSE ( 
        $COLUMN_EXPENSE_ID integer primary key autoincrement, 
        $COLUMN_USER_ID integer,
        $COLUMN_EXPENSE_TITLE text, 
        $COLUMN_EXPENSE_REMARK text, 
        $COLUMN_EXPENSE_AMOUNT real, 
        $COLUMN_EXPENSE_CREATED_AT text, 
        $COLUMN_EXPENSE_CATEGORY_ID integer,
        $COLUMN_EXPENSE_TYPE integer,
         )''');
      },
    );
  }

  /// create user
  /// 1 -> something went wrong
  /// 2 -> email already exists
  /// 3 -> success
  Future<int> createUser({required UserModel newUser}) async {
    Database db = await initDB();
    bool check = await isEmailAlreadyExists(email: newUser.email);
    if (check) {
      return 2;
    } else {
      int rowsEffected = await db.insert(TABLE_USER, newUser.toMap());
      if (rowsEffected > 0) {
        return 3;
      } else {
        return 1;
      }
    }
  }

  Future<bool> isEmailAlreadyExists({required String email}) async {
    Database db = await initDB();
    List<Map<String, dynamic>> mUsers = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_EMAIL = ?",
      whereArgs: [email],
    );

    return mUsers.isNotEmpty;
  }

  ///auth user
  ///1->invalid email
  ///2->incorrect pass
  ///3->authenticate
  Future<int> authUser({required String email, required String pass}) async {
    Database db = await initDB();
    List<Map<String, dynamic>> mUser = await db.query(
      TABLE_USER,
      where: "$COLUMN_USER_EMAIL = ? and $COLUMN_USER_PASS = ?",
      whereArgs: [email, pass],
    );

    if(mUser.isEmpty){

      List<Map<String, dynamic>> emailUser = await db.query(
        TABLE_USER,
        where: "$COLUMN_USER_EMAIL = ?",
        whereArgs: [email],
      );

      if(emailUser.isNotEmpty){
        return 2;
      } else {
        return 1;
      }

    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(AppConstants.PREF_USER_KEY, mUser[0][COLUMN_USER_ID]);
      return 3;
    }



  }
}
