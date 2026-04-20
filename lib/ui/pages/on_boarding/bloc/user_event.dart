import 'package:expenso_474/data/models/user_model.dart';

abstract class UserEvent {}

class UserLoginEvent extends UserEvent {}

class UserSignUpEvent extends UserEvent {
  UserModel newUser;
  UserSignUpEvent({required this.newUser});
}
