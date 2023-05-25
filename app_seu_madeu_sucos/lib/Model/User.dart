import 'Client.dart';

class User {
  String username;
  String _password;
  Client client;

  String get password => _password;

  User(this.username, this._password, this.client);
}
