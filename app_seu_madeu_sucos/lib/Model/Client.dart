import 'ActivePlan.dart';
import 'Address.dart';
import 'User.dart';

class Client {

  String? name;
  Address? address;
  String? phone;
  ActivePlan? activePlan;

  Client({
    this.name,
    this.address,
    this.phone,
    this.activePlan,
  });

  //Create to string
  @override
  String toString() {
    return "Client: {name: $name, address: ${address.toString()}, phone: $phone, activePlan: ${activePlan.toString()}}";
  }
}