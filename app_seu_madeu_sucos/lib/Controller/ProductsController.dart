import '../Model/Product.dart';

class ProductsInfo {
  static final List<Product> allProducts = [
    Product(
        id: 1,
        name: "Suco de Laranja",
        description: "Suco natural de laranja sem açúcar e sem adição de água"),
    Product(
        id: 2,
        name: "Suco de Abacaxi",
        description:
            "Suco natural de abacaxi sem açúcar com adição de 200ml de água"),
    Product(
        id: 3,
        name: "Suco de Melancia",
        description:
            "Suco natural de melancia sem açúcar e sem adição de água"),
    Product(
        id: 4,
        name: "Suco Detox de Laranja",
        description:
            "Suco natural de laranja sem açucar e sem adição de água, batido com couve, gengibre e hortelã"),
    Product(
        id: 5,
        name: "Suco Detox de Abacaxi",
        description:
            "Suco natural de abacaxi sem açucar e sem adição de água, batido com couve, gengibre e hortelã"),
    Product(
        id: 6,
        name: "Suco de Laranja com Acerola",
        description:
            "Suco natural de laranja sem açucar e sem adição de água, batido com acerola"),
    Product(
        id: 7,
        name: "Suco de Laranja com Morango",
        description:
            "Suco natural de laranja sem açucar e sem adição de água, batido com morango"),
    Product(
        id: 8,
        name: "Suco de Laranja com Beterraba",
        description:
            "Suco natural de laranja sem açucar e sem adição de água, batido e coado com beterraba"),        
  ];
}
