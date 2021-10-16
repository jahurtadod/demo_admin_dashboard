import 'package:flutter/material.dart';

class ModifyFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String nombre = '';
  String apellidos = '';

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      // print('From valid ... Login');
      // print('$email === $password');

      return true;
    } else {
      // print('From not valid');
      return false;
    }
  }
}
