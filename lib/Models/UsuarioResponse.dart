class UsuarioResponse{
  final int id;
  final String name;
  final String email;
  final String password;

  UsuarioResponse(this.id, this.name, this.email, this.password);

  UsuarioResponse.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    name = json['name'],
    email = json['email'],
    password = json['password'];
}