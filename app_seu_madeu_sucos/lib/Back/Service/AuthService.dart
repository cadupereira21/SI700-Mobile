import 'dart:convert';

import '../Model/User.dart';

class AuthService {

  static final AuthService instance = AuthService._createInstance();

  AuthService._createInstance();

  bool findUserCredentials(User user) {
    for (var i = 0; i < MockedUsers.users.length; i++) {
      if (MockedUsers.users[i].username == user.username &&
          MockedUsers.users[i].password == user.password) {
        return true;
      }
    }
    return false;
  }
}

class MockedUsers {
  static List<User> users = [
    User("user", "MTIz"), // Password: 123
  ];
}
