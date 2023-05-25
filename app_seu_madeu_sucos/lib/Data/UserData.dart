class UserData {
  String? _username;
  String? _password;

  static UserData instance = UserData._createInstance();

  UserData._createInstance();

  void setUsername(String username) {
    _username = username;
  }

  void setPassword(String password) {
    _password = password;
  }

  String? get username => _username;
  String? get password => _password;
}
