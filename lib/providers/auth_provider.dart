import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  login(String email, String password) {
    // Petición HTTP

    _token = 'adasdasdasdas.adasdad.asdasda';
    print('almacenar JWT: $_token');

    // Navegar al dashboard

    notifyListeners();
  }
}
