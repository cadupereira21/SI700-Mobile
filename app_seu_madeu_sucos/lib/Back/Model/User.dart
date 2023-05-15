class User{
  String username;
  String _password;

  String get password => _password;

  User(this.username, this._password);
}