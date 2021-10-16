import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:admin_dashboard/models/user_twilio.dart';
import 'package:admin_dashboard/services/local_storage.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class ModifyProvider extends ChangeNotifier {
  UserTwilio? user;

  Future<String> modify(String nombre, String apellidos) async {
    print(LocalStorage.prefs.getString('token') ?? '');
    final response = await http.put(
      Uri.parse('https://twittordemo.herokuapp.com/modificarPerfil'),
      headers: <String, String>{
        'Authorization': 'Bearer ${LocalStorage.prefs.getString('token') ?? ''}',
      },
      body: jsonEncode(<String, String>{
        "nombre": nombre,
        "apellidos": apellidos,
        "banner": "",
        "ubicacion": "Loja, Loja, Ecuador",
        "biografia": "Desarrollador Backend",
        "sitioWeb":
            "https://www.linkedin.com/in/jonathan-andres-rosero-soto-804128113"
      }),
    );

    print(response.statusCode);
    if (response.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return '';
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update album.');
    }
  }
}
