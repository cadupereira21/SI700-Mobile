class Product {
  String? id;
  String? name;
  String? description;
  int? planId;
  double? value;

  Product({this.id, this.name, this.description, this.planId, this.value});

  String? get getId => id;
  String? get getName => name;
  String? get getDescription => description;
  int? get getPlanId => planId;
  double? get getValue => value;

  set setId(String? id) => this.id = id;
  set setName(String? name) => this.name = name;
  set setDescription(String? description) => this.description = description;
  set setPlanId(int? planId) => this.planId = planId;
  set setValue(double? value) => this.value = value;

  @override
  String toString() {
    return "Produto{id=$id, name=$name, description=$description, planId=$planId, value=$value}";
  }
}
