import 'dart:convert';
import 'package:flutter_android/Models/EspecialidadResponse.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../Utils/Ambiente.dart';
class Especialidad extends StatefulWidget {
  final int idEspecialidad;
  const Especialidad({super.key, required this.idEspecialidad});

  @override
  State<Especialidad> createState() => _EspecialidadState();
}

class _EspecialidadState extends State<Especialidad> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtNombre = TextEditingController();

  void fnEspecialidad() async {
    final response = await http.post(
        Uri.parse('${Ambiente.urlServer}/api/especialidad'),
        body: jsonEncode(
            <String, dynamic> {
              'id': widget.idEspecialidad,
        }),
        headers: <String, String> {
          'Content-Type' : 'application/json; charset=UTF-8'
        }
    );

    Map<String, dynamic> responseJson = jsonDecode(response.body);
    final especialidadResponse = EspecialidadResponse.fromJson(responseJson);

    txtNombre.text = especialidadResponse.nombre;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.idEspecialidad != 0)
    {
      fnEspecialidad();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Especialidad'),
      ),
      body: Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            TextFormField(
              controller: txtNombre,
              decoration:  InputDecoration(labelText: 'Nombre'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return 'Favor de ingresar nombre';
                } return null;
              },
            ),
            TextButton(onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final response = await http.post(
                Uri.parse('${Ambiente.urlServer}/api/especialidad/guardar'),
                body: jsonEncode(
                <String, dynamic>{
                  'id': widget.idEspecialidad,
                  'nombre': txtNombre.text
                }),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Accept': 'application/json'
              }
              );

            print(response.body);

            if (response.body == "Ok")
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
            TextButton(onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final response = await http.post(
                    Uri.parse('${Ambiente.urlServer}/api/especialidad/eliminar'),
                    body: jsonEncode(
                        <String, dynamic>{
                          'id': widget.idEspecialidad,
                          'nombre': txtNombre.text
                        }),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Accept': 'application/json'
                    }
                );

                print(response.body);

                if (response.body == "Ok")
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
            }, child: Text('Eliminar'))
  ],
  ),
  ),
  )
  );
}
}
