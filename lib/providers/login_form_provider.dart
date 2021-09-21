import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

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
