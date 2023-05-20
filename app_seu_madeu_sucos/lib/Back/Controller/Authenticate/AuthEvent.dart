import '../../Configuration/PasswordConfig.dart';
import '../../Model/Client.dart';
import '../../Model/User.dart';

abstract class AuthEvent {}

class LogIn extends AuthEvent {
  late User user;

  LogIn(username, password) {
    this.user = User(username, PasswordConfig.encode(password));
  }
}

class LogOut extends AuthEvent {}

class SignUp extends AuthEvent {
  SignUp();
}
