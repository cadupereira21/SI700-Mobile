import 'Client.dart';

class UserModel {
  String? _id;
  String? _email;
  String? _password;
  Client? _client;

  UserModel({
    id,
    email,
    password,
    client,
  }){
    this._id = id;
    this._email = email;
    this._password = password;
    this._client = client;
  }

  @override
  String toString() {
    return "User: {id: $_id, email: $_email, password: $_password, client: ${_client.toString()}}";
  }

  String get getId => _id ?? "";
  set setId(String id) => _id = id;
  String get getEmail => _email ?? "";
  set setEmail(String email) => this._email = email;
  String get getPassword => _password ?? "";
  set setPassword(String password) => this._password = password;
  Client get getClient => _client ?? Client();
  set setClient(Client client) => this._client = client;

  toMap(){
    return {
      "email": getEmail,
      "client": {
        "name": getClient.getName,
        "address": {
          "street": getClient.getAddress.getStreet,
          "streetNumber": getClient.getAddress.getStreetNumber,
          "neighbour" : getClient.getAddress.getNeighbour,
          "district" : getClient.getAddress.getDistrict,
          "city" : getClient.getAddress.getCity,
          "zipcode" : getClient.getAddress.getCep,
        },
        "phone": getClient.getPhone,
      },
      "activePlan": null
    };
  }
}
