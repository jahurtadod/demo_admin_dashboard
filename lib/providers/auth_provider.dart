import 'dart:convert';

import 'package:admin_dashboard/api/twilio_api.dart';
import 'package:admin_dashboard/models/http/auth_twilio.dart';
import 'package:admin_dashboard/models/user_twilio.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/api/cafe_api.dart';
import 'package:admin_dashboard/models/http/auth_response.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/notificarions_service.dart';
import 'package:admin_dashboard/services/navigation_service.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  UserTwilio? user;

  AuthProvider() {
    isAuthenticated();
  }

  Future<String> login(String email, String password) async {
    // final data = {'correo': email, 'password': password};

    // CafeApi.post('/auth/login', data).then((json) {
    //   print(json);
    //   final authResponse = AuthResponse.fromMap(json);
    //   user = authResponse.usuario;

    //   authStatus = AuthStatus.authenticated;
    //   LocalStorage.prefs.setString('token', authResponse.token);
    //   NavigationService.replaceTo(Flurorouter.dashboardRoute);
    //   CafeApi.configureDio();
    //   notifyListeners();
    // }).catchError((e) {
    //   print('error en: $e');
    //   NotificationsService.showSnackbarError('Usuario / Password no válidos');
    // });
    final data = {'email': email, 'password': password};
    http.Response response = await http.post(
      Uri.parse('https://twittordemo.herokuapp.com/login'),
      body: jsonEncode(<String, dynamic>{'email': email, 'password': password}),
    );
    print(jsonEncode(<String, dynamic>{'email': email, 'password': password}));
    print('Test');
    print(response);
    print(response.statusCode);

    if (response.statusCode == 201) {
      //final authResponse = AuthTwilio.fromJson(response.body);
      authStatus = AuthStatus.authenticated;
      print(response.body);
      final authResponse = AuthTwilio.fromJson(response.body);
      Map<String, dynamic> decodedToken = JwtDecoder.decode(authResponse.token);
      user = UserTwilio.fromMap(decodedToken);
      LocalStorage.prefs.setString('token', authResponse.token);
      print('Usuario : ${user!.nombre}');
      NavigationService.replaceTo(Flurorouter.dashboardRoute);
      notifyListeners();
      return 'AuthTwilio.fromJson(response.body)';
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  // print(data);

  // TwilioApi.post('/login', data).then((json) {
  //   print('Post jsop : $json');
  //   final authResponse = AuthTwilio.fromMap(json);
  //   authStatus = AuthStatus.authenticated;
  //   LocalStorage.prefs.setString('token', authResponse.token);
  //   NavigationService.replaceTo(Flurorouter.dashboardRoute);
  //   TwilioApi.configureDio();
  //   notifyListeners();
  // }).catchError((e) {
  //   print('error en: $e');
  //   NotificationsService.showSnackbarError('Usuario / Password no válidos');
  // });

  Future<http.Response> register(
      String email, String password, String name) async {
    final data = {
      'nombre': name,
      'email': email,
      'password': password,
      'apellidos': 'hola'
    };

    return http.post(
      Uri.parse('https://twittordemo.herokuapp.com/registro'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': name,
        'email': email,
        'password': password,
        'apellidos': 'hola'
      }),
    );
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      // final resp = await CafeApi.httpGet('/auth');
      // final authResponse = AuthResponse.fromMap(resp);

      // LocalStorage.prefs.setString('token', authResponse.token);

      // user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;

      return true;
    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
