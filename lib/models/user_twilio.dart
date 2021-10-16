import 'dart:convert';

class UserTwilio {
  UserTwilio({
    required this.apellidos,
    required this.biografia,
    required this.email,
    required this.exp,
    required this.fechaNacimiento,
    required this.nombre,
    required this.id,
    required this.sitioweb,
    required this.ubicacion,
  });

  String id;
  String apellidos;
  String biografia;
  String email;
  int exp;
  DateTime fechaNacimiento;
  String nombre;
  String sitioweb;
  String ubicacion;

  factory UserTwilio.fromJson(String str) =>
      UserTwilio.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserTwilio.fromMap(Map<String, dynamic> json) => UserTwilio(
        id: json["_id"],
        apellidos: json["apellidos"],
        biografia: json["biografia"],
        email: json["email"],
        exp: json["exp"],
        fechaNacimiento: DateTime.parse(json["fecha_Nacimiento"]),
        nombre: json["nombre"],
        sitioweb: json["sitioweb"],
        ubicacion: json["ubicacion"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "apellidos": apellidos,
        "biografia": biografia,
        "email": email,
        "exp": exp,
        "fecha_Nacimiento": fechaNacimiento.toIso8601String(),
        "nombre": nombre,
        "sitioweb": sitioweb,
        "ubicacion": ubicacion,
      };
}
