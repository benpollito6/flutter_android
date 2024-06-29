class EspecialidadResponse {
  final int id;
  final String nombre;


  EspecialidadResponse(this.id, this.nombre);

  EspecialidadResponse.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre= json['nombre'];

}