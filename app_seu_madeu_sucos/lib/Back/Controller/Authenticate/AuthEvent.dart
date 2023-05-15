import '../../Configuration/PasswordConfig.dart';

abstract class AuthEvent{

}

class LogIn extends AuthEvent{
  final String username;
  late final String password;

  LogIn(this.username, password){
    this.password = PasswordConfig.encode(password);
  }
}

class LogOut extends AuthEvent{}