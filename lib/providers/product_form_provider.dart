import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey();

  Product product;

  ProductFormProvider(this.product);

  updateAvailability(bool value) {
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(product.name);
    print(product.id);
    print(product.available);

    return formKey.currentState?.validate() ?? false;
  }
}
