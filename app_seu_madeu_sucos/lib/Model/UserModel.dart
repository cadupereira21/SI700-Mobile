import 'Client.dart';

class UserModel {
  String? _email;
  String? _password;
  Client? _client;

  UserModel({
    email,
    password,
    client,
  }){
    this._email = email;
    this._password = password;
    this._client = client;
  }

  @override
  String toString() {
    return "User: {email: $_email, password: $_password, client: ${_client.toString()}}";
  }

  String get getEmail => _email ?? "";
  set setEmail(String email) => this._email = email;
  String get getPassword => _password ?? "";
  set setPassword(String password) => this._password = password;
  Client get getClient => _client ?? Client();
  set setClient(Client client) => this._client = client;
}
