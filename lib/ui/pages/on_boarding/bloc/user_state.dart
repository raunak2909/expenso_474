import 'package:expenso_474/data/models/user_model.dart';

abstract class UserState{}

class UserInitialState extends UserState{}
class UserLoadingState extends UserState{}
class UserSuccessState extends UserState{
  UserModel? currentUser;
  UserSuccessState({this.currentUser});
}
class UserFailureState extends UserState{
  String errorMsg;
  UserFailureState({required this.errorMsg});
}