import '../Model/Address.dart';
import '../Model/Client.dart';
import '../Model/UserModel.dart';

class UserData {
  String _id = "";
  UserModel _user = UserModel(
    email: "",
    password: "",
    client: Client(
      name: "",
      address: Address(
        street: "",
        streetNumber: 0,
        neighbour: "",
        district: "AC",
        city: "",
        cep: "",
      ),
      phone: "",
    ),
  );

  static UserData instance = UserData._createInstance();

  UserData._createInstance();

  void clearData() {
    setId("");
    setUser(UserModel(
      email: "",
      password: "",
      client: Client(
        name: "",
        address: Address(
          street: "",
          streetNumber: 0,
          neighbour: "",
          district: "",
          city: "",
          cep: "",
        ),
        phone: "",
      ),
    ));
  }

  void setId(String id) {
    _id = id;
  }

  void setUser(UserModel user) {
    _user = user;
  }

  String get id => _id;
  UserModel get user => _user;

  @override
  String toString() {
    return "User Data: {id: ${_id}, user: ${_user.toString()}}";
  }
}
