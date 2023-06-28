abstract class ProductRequesterEvent {}

class CompleteProductRequest extends ProductRequesterEvent {
  CompleteProductRequest();
}

class GetAllProductsRequest extends ProductRequesterEvent {}