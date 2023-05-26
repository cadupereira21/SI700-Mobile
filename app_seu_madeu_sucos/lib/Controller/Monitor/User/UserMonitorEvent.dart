import '../../../Model/Client.dart';
import '../../../Model/User.dart';

abstract class UserMonitorEvent {}

class UpdateUserDataEvent extends UserMonitorEvent{
  User user;
  UpdateUserDataEvent({required this.user, client}) {
    user.client = client;
  }
}
