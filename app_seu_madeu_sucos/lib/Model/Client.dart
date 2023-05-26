import 'ActivePlan.dart';
import 'User.dart';

class Client {

  String? _id;
  String? name;
  String? address;
  String? phone;
  ActivePlan? activePlan;

  Client({
    this.name,
    this.address,
    this.phone,
    this.activePlan,
  });
}