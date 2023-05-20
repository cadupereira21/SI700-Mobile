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
  late Client client;

  SignUp({
    required name,
    required address,
    required phone,
    required activePlan,
    required user,
  }) {
    this.client = Client(
      name,
      address,
      phone,
      activePlan,
      user
    );
  }
}
