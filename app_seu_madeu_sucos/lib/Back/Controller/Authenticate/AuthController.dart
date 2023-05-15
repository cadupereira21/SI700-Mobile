import '../../Model/User.dart';
import '../../Service/AuthService.dart';

class AuthController {
  final AuthService _authService = AuthService.instance;

  bool _authenticated = false;
  get isAuthenticated => _authenticated;

  static final AuthController instance = AuthController._createInstance();

  AuthController._createInstance();

  bool login(User user) {
    if (_authService.findUserCredentials(user)) {
      _authenticated = true;
      print("Autenticado");
      return true;
    }
    print("Erro de autenticação");
    return false;
  }

  void logout() {
    _authenticated = false;
  }
}
