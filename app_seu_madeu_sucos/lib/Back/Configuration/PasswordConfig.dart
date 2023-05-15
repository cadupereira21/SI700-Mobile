import 'dart:convert';

import 'package:flutter/material.dart';

//Uses simple ceaser cipher encryption
class PasswordConfig {
  static String encode(String password) {
    
    var encodedPassword = base64Encode(password.codeUnits);

    return encodedPassword;
  }
}
