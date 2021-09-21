import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  validateForm() {
    if (formKey.currentState!.validate()) {
      print('From valid ... Login');
      print('$email === $password');
    } else {
      print('From not valid');
    }
  }
}
