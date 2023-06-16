import 'ActivePlan.dart';
import 'Address.dart';
import 'User.dart';

class Client {

  String? _id;
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
}