import 'package:app_seu_madeu_sucos/Controller/Monitor/Product/ProductMonitorBloc.dart';
import 'package:app_seu_madeu_sucos/Controller/Monitor/Product/ProductMonitorState.dart';
import 'package:app_seu_madeu_sucos/Controller/Requester/ProductRequester/ProductRequesterEvent.dart';
import 'package:app_seu_madeu_sucos/Controller/Screen/Bloc/CartController/CartBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Controller/Requester/ProductRequester/ProductRequesterBloc.dart';
import '../Controller/Requester/RequestState.dart';
import '../Controller/Screen/Bloc/CartController/CartEvent.dart';
import '../../Model/Product.dart';
import '../Data/ProductData.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  List<Product> allProducts = ProductData.instance.allProducts;

  @override
  Widget build(BuildContext context) {
    var _screenWidth = MediaQuery.of(context).size.width;
    var productMonitorBloc = BlocProvider.of<ProductMonitorBloc>(context);
    var productRequesterBloc = BlocProvider.of<ProductRequesterBloc>(context);
    if (allProducts.isEmpty) {
      productRequesterBloc.add(GetAllProductsRequest());
    }
    return BlocBuilder<ProductMonitorBloc, ProductMonitorState>(
        builder: (context, state) {
      return productRequesterBloc.state is ProcessingRequest
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: const Color.fromRGBO(67, 160, 71, 1),
              child: GridView.count(
                childAspectRatio: _screenWidth*0.0016,
                crossAxisCount: 2,
                children: List.generate(state.productColletion.length, (index) {
                  return productTile(state.productColletion[index], _screenWidth*0.025, _screenWidth*0.055);
                }),
              ),
            );
    });
  }

  Widget productTile(Product product, buttonPadding, buttonIconSize) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        //color: Colors.red,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productImage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: Text(
                product.name!.split("-")[0],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
              child: Text(
                product.name!.split("-")[1].replaceAll(" ", ""),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
              child: Text(
                product.description!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(0, 0, 0, .7),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        "R\$${product.value!.toString()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.green.shade800,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: addToCartButton(product, buttonPadding, buttonIconSize),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SnackBar addedToCartSnackbar(Product product) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Text("${product.name} adicionado ao carrinho!"),
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: () {
          BlocProvider.of<CartBloc>(context).add(
            RemoveFromCart(product: product),
          );
        },
      ),
    );
  }

  Widget productImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      child: Image.asset(
        'lib/Assets/suco_de_laranja.jpg',
        alignment: Alignment.center,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget addToCartButton(Product product, buttonPadding, buttonIconSize) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade800,
          padding: EdgeInsets.all(buttonPadding),
          shape: const CircleBorder(),
        ),
        onPressed: () {
          BlocProvider.of<CartBloc>(context).add(AddToCart(product: product));
          //CartInfo.addToCart(product);
          ScaffoldMessenger.of(context)
              .showSnackBar(addedToCartSnackbar(product));
        },
        child: Icon(
          Icons.add_shopping_cart_sharp,
          size: buttonIconSize,
        ));
  }
}
