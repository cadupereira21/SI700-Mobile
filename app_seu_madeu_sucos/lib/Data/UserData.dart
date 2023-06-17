import '../Model/Address.dart';
import '../Model/Client.dart';
import '../Model/User.dart';

class UserData {
  String _id = "";
  User _user = User(
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
  );

  static UserData instance = UserData._createInstance();

  UserData._createInstance();

  void clearData() {
    setId("");
    setUser(User(
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

  void setUser(User user) {
    _user = user;
  }

  String get id => _id;
  User get user => _user;

  @override
  String toString() {
    //Create to string
    return "User Data: {id: ${_id}, user: ${_user.toString()}}";
  }
}
