import 'dart:ffi';

class Product {
  final double? id;
  final String? name;
  final String? description;
  final double? planId;

  Product({this.id, this.name, this.description, this.planId});

  @override
  String toString() {
    return "Produto{id=$id, name=$name, description=$description, planId=$planId}";
  }
}
