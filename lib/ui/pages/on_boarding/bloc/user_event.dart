import 'package:expenso_474/data/models/user_model.dart';

abstract class UserEvent {}

class UserLoginEvent extends UserEvent {
  String email, pass;
  UserLoginEvent({required this.email, required this.pass});
}

class UserSignUpEvent extends UserEvent {
  UserModel newUser;
  UserSignUpEvent({required this.newUser});
}

class GetUserDetailsEvent extends UserEvent{}
