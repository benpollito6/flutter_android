import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_android/Models/PacienteResponse.dart';
import 'package:flutter_android/Models/UsuarioResponse.dart';
import 'package:flutter_android/Utils/Ambiente.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class Paciente extends StatefulWidget {
  final int idPaciente;
  final int idUser;
  const Paciente({super.key, required this.idPaciente, required this.idUser});

  @override
  State<Paciente> createState() => _PacienteState();
}

class _PacienteState extends State<Paciente> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEdad = TextEditingController();
  TextEditingController txtTelefono = TextEditingController();
  TextEditingController txtPeso = TextEditingController();
  TextEditingController txtAltura = TextEditingController();
  TextEditingController txtDireccion = TextEditingController();
  TextEditingController txtCorreo = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtTipoSangre = TextEditingController();

  void fnPaciente() async {
    final responsePaciente = await http.post(
      Uri.parse('${Ambiente.urlServer}/api/paciente'),
      body: jsonEncode(
            <String, dynamic> {
              'id': widget.idPaciente,
    }),
      headers: <String, String> {
        'Content-Type' : 'application/json; charset=UTF-8'
      }
  );
    final responseUsuario = await http.post(
        Uri.parse('${Ambiente.urlServer}/api/usuario'),
        body: jsonEncode(
            <String, dynamic> {
              'id': widget.idUser,
            }),
        headers: <String, String> {
          'Content-Type' : 'application/json; charset=UTF-8'
        }
    );

  Map<String, dynamic> responseJsonPaciente = jsonDecode(responsePaciente.body);
  final pacienteResponse = PacienteResponse.fromJson(responseJsonPaciente);

  txtNombre.text = pacienteResponse.nombre;
  txtEdad.text = pacienteResponse.edad.toString();
  txtTelefono.text = pacienteResponse.telefono.toString();
  txtPeso.text = pacienteResponse.peso;
  txtAltura.text = pacienteResponse.altura;
  txtDireccion.text = pacienteResponse.direccion;
  txtCorreo.text = pacienteResponse.correo;
  txtTipoSangre.text = pacienteResponse.tipo_sangre;

  Map<String, dynamic> responseJsonUsuario = jsonDecode(responseUsuario.body);
  final usuarioResponse = UsuarioResponse.fromJson(responseJsonUsuario);

  txtName.text = usuarioResponse.name;
  txtEmail.text = usuarioResponse.email;
  txtPassword.text = usuarioResponse.password;

}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.idPaciente != 0 && widget.idUser != 0 )
      {
        fnPaciente();
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paciente'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              TextFormField(
                controller: txtNombre,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar nombre';
                  } return null;
                },
              ),
              TextFormField(
                controller: txtName,
                decoration: InputDecoration(labelText: 'Nombre Usuario'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar nombre de usuario';
                  } return null;
                },
              ),TextFormField(
                controller: txtEdad,
                decoration: InputDecoration(labelText: 'Edad'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar edad';
                  } return null;
                },
              ),TextFormField(
                controller: txtTelefono,
                decoration: InputDecoration(labelText: 'Numero de Telefono'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar tu numero de telefono';
                  } return null;
                },
              ),TextFormField(
                controller: txtPeso,
                decoration: InputDecoration(labelText: 'Peso'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar tu peso';
                  } return null;
                },
              ),TextFormField(
                controller: txtAltura,
                decoration: InputDecoration(labelText: 'Altura'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar tu altura';
                  } return null;
                },
              ),TextFormField(
                controller: txtDireccion,
                decoration: InputDecoration(labelText: 'Direccion'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar tu direccion';
                  } return null;
                },
              ),TextFormField(
                controller: txtCorreo,
                decoration: InputDecoration(labelText: 'Correo'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar tu correo';
                  } return null;
                },
              ),TextFormField(
                controller: txtEmail,
                decoration: InputDecoration(labelText: 'Email usuario'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar email';
                  } return null;
                },
              ),TextFormField(
                controller: txtPassword,
                decoration: InputDecoration(labelText: 'Contraseña'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar una contraseña';
                  } return null;
                },
              ),
              TextFormField(
                controller: txtTipoSangre,
                decoration: InputDecoration(labelText: 'Tipo de sangre'),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Favor de ingresar tu tipo de sangre';
                  } return null;
                },
              ),
              TextButton(onPressed: () async{
                if (_formKey.currentState!.validate()) {
                  final responsePaciente = await http.post(
                    Uri.parse('${Ambiente.urlServer}/api/paciente/guardar'),
                    body: jsonEncode(
                      <String, dynamic>{
                        'id': widget.idPaciente,
                        'nombre': txtNombre.text,
                        'edad': txtEdad.text,
                        'telefono': txtTelefono.text,
                        'peso': txtPeso.text,
                        'altura': txtAltura.text,
                        'direccion': txtDireccion.text,
                        'correo': txtCorreo.text,
                        'tipo_sangre': txtTipoSangre.text
                      }),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Accept': 'application/json'
                    }
                  );
                  print(responsePaciente.body);
                  if(responsePaciente.body == "Ok")
                    {
                      Navigator.pop(context);
                    } else
                    {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Ay wey!',
                        text: 'Algo valio madre!',
                      );
                    }
                  final responseUsuario = await http.post(
                      Uri.parse('${Ambiente.urlServer}/api/usuario/guardar'),
                      body: jsonEncode(
                          <String, dynamic>{
                            'id': widget.idUser,
                            'name': txtName.text,
                            'email': txtEmail.text,
                            'password': txtPassword.text
                          }),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Accept': 'application/json'
                      }
                  );
                  print(responseUsuario.body);
                  if(responseUsuario.body == "Ok")
                  {
                    Navigator.pop(context);
                  } else
                  {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Ay wey!',
                      text: 'Algo valio madre!',
                    );
                  }
                }
              }, child: Text('Guardar')),
                TextButton(onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    final responsePaciente = await http.post(
                      Uri.parse('${Ambiente.urlServer}/api/paciente/eliminar'),
                      body: jsonEncode(
                        <String, dynamic>{
                          'id': widget.idPaciente,
                          'nombre': txtNombre.text,
                          'edad': txtEdad.text,
                          'telefono': txtTelefono.text,
                          'peso': txtPeso.text,
                          'altura': txtAltura.text,
                          'direccion': txtDireccion.text,
                          'correo': txtCorreo.text,
                          'tipo_sangre': txtTipoSangre.text
                        }),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Accept': 'application/json'
                      }
                    );

                    print(responsePaciente.body);
                    if(responsePaciente.body == "Ok")
                    {
                      Navigator.pop(context);
                    }else
                    {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Ay wey!',
                        text: 'Algo valio madre!',
                      );
                    }
                    final responseUsuario = await http.post(
                        Uri.parse('${Ambiente.urlServer}/api/usuario/eliminar'),
                        body: jsonEncode(
                            <String, dynamic>{
                              'id': widget.idUser,
                              'name': txtName.text,
                              'email': txtEmail.text,
                              'password': txtPassword.text
                            }),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          'Accept': 'application/json'
                        }
                    );

                    print(responseUsuario.body);
                    if(responseUsuario.body == "Ok")
                    {
                      Navigator.pop(context);
                    }else
                    {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Ay wey!',
                        text: 'Algo valio madre!',
                      );
                    }
                  }
                }, child: Text('Eliminar'))
            ],
          ),
        ),
      ),
    );return const Placeholder();
  }
}
