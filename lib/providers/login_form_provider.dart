import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  //global key conecta al provider con el widget cuyo key se especifica
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    //validate valida todo FormField del Form y retorna True si no hay errores
    return formKey.currentState?.validate() ?? false;
  }
}
