import 'ActivePlan.dart';
import 'Address.dart';

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

  //create getters and setters
  String? get getName => name;
  set setName(String? name) => this.name = name;
  Address? get getAddress => address;
  set setAddress(Address? address) => this.address = address;
  String? get getPhone => phone;
  set setPhone(String? phone) => this.phone = phone;
  ActivePlan? get getActivePlan => activePlan;
  set setActivePlan(ActivePlan? activePlan) => this.activePlan = activePlan;

  //Create to string
  @override
  String toString() {
    return "Client: {name: $name, address: ${address.toString()}, phone: $phone, activePlan: ${activePlan.toString()}}";
  }
}