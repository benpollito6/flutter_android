import 'dart:ffi';

class LoginResponse {
  final String acceso;
  final String token;
  final String error;
  final int id_usuario;
  final String usuario;

  LoginResponse(this.acceso,this.error,this.id_usuario,this.token,this.usuario);

  LoginResponse.fromJson(Map<String, dynamic> json)
    : acceso = json['acceso'],
      token = json['token'],
      id_usuario = json['id_usuario'],
      error = json['error'],
      usuario = json['usuario'];
}