import 'ActivePlan.dart';
import 'Address.dart';

class Client {

  String? _name;
  Address? _address;
  String? _phone;
  ActivePlan? _activePlan;

  Client({
    name = "",
    address,
    phone = "",
    activePlan,
  }){
    _name = name;
    _address = address;
    _phone = phone;
    _activePlan = activePlan;
  }

  //create getters and setters
  String get getName => _name ?? "";
  set setName(String name) => _name = name;
  Address get getAddress => _address ?? Address();
  set setAddress(Address address) => _address = address;
  String get getPhone => _phone ?? "";
  set setPhone(String phone) => _phone = phone;
  ActivePlan get getActivePlan => _activePlan ?? ActivePlan();
  set setActivePlan(ActivePlan activePlan) => _activePlan = activePlan;

  //Create to string
  @override
  String toString() {
    return "Client: {name: $_name, address: ${_address.toString()}, phone: $_phone, activePlan: ${_activePlan.toString()}}";
  }
}