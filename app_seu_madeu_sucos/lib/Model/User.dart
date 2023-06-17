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

  //create to string
  @override
  String toString() {
    return "User: {email: $email, password: $password, client: ${client.toString()}}";
  }
}
