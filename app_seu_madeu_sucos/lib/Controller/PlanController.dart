import '../Model/Plan.dart';

class PlanInfo {
  //Create singleton
  static final PlanInfo _instance = PlanInfo._internal();
  factory PlanInfo() => _instance;
  PlanInfo._internal();

  //Create list of plans
  static List<Plan> allPlans = [
    Plan(
      id: 0,
      name: "Plano Padrão",
      description: "Plano com 2 sucos normais por semana!",
      value: 110.00,
      lastModified: DateTime.now(),
    ),
    Plan(
      id: 1,
      name: "Plano Especial",
      description: "Plano com 2 sucos com mistura por semana!",
      value: 130.00,
      lastModified: DateTime.now(),
    ),
    Plan(
      id: 2,
      name: "Plano Premium",
      description: "Plano com 2 sucos com mistura especial por semana!",
      value: 160.00,
      lastModified: DateTime.now()
    ),
  ];
}
