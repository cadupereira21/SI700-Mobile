import 'ActivePlan.dart';
import 'User.dart';

class Client {

  late String _id;
  late String name;
  late String address;
  late String phone;
  late ActivePlan activePlan;
  late User user;

  Client(name, address, phone, activePlan, user) {
    this.name = name;
    this.address = address;
    this.phone = phone;
    this.activePlan = activePlan;
    this.user = user;
  }
}