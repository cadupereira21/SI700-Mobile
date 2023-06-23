import 'Client.dart';

class User {
  String? email;
  String? password;
  Client? client;

  User({
    this.email,
    this.password,
    this.client,
  });

  @override
  String toString() {
    return "User: {email: $email, password: $password, client: ${client.toString()}}";
  }

  String? get getEmail => email;
  set setEmail(String? email) => this.email = email;
  String? get getPassword => password;
  set setPassword(String? password) => this.password = password;
  Client? get getClient => client;
  set setClient(Client? client) => this.client = client;
}
