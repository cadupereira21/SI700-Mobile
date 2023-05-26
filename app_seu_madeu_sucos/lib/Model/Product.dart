
class Product {
  final String? id;
  final String? name;
  final String? description;
  final int? planId;
  final double? value;

  Product({this.id, this.name, this.description, this.planId, this.value});

  @override
  String toString() {
    return "Produto{id=$id, name=$name, description=$description, planId=$planId, value=$value}";
  }
}
