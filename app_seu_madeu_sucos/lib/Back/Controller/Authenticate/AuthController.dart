class AuthController {
  
  bool _authenticated = false;
  get isAuthenticated => _authenticated;

  static final AuthController instance = AuthController._createInstance();

  AuthController._createInstance();

  void login() {
    _authenticated = true;
  }

  void logout() {
    _authenticated = false;
  }
}