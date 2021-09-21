import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthProvider authProvider;

  String email = '';
  String password = '';

  LoginFormProvider(this.authProvider);

  validateForm() {
    if (formKey.currentState!.validate()) {
      print('From valid ... Login');
      print('$email === $password');

      authProvider.login(email, password);
    } else {
      print('From not valid');
    }
  }
}
