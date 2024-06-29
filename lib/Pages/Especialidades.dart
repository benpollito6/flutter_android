import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_android/Models/EspecialidadResponse.dart';
import 'package:flutter_android/Pages/Especialidad.dart';
import 'package:flutter_android/Utils/Ambiente.dart';
import 'package:http/http.dart' as http;

class Especialidades extends StatefulWidget {
  const Especialidades({super.key});

  @override
  State<Especialidades> createState() => _EspecialidadesState();
}

class _EspecialidadesState extends State<Especialidades> {

  List <EspecialidadResponse> especialidades = [];

  Widget _listViewEspecialidades(){
    return ListView.builder(
      itemCount: especialidades.length,
      itemBuilder: (context, index){
        var especialidad = especialidades[index];
        return ListTile(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Especialidad(idEspecialidad: especialidad.id))
            );
          },
          title: Text(especialidad.id.toString()),
          subtitle: Text(especialidad.nombre),
        );
      }
    );
  }
  void fnObtenerEspecialidades() async{
    var response = await http.get(Uri.parse('${Ambiente.urlServer}/api/especialidades'),
    headers: <String, String> {
      'Content-Type' : 'application/json; charset=UTF-8',
      'Accept' : 'application/json'
    }
    );

    Iterable mapEspecialidades = jsonDecode(response.body);
    especialidades = List<EspecialidadResponse>
                      .from(
      mapEspecialidades.map((model) => EspecialidadResponse.fromJson(model))
    );
    setState(() {

    });
  }

  @override
  void initState(){
    super.initState();
    fnObtenerEspecialidades();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Especialidades'),
        actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value){
                fnObtenerEspecialidades();
              },
                itemBuilder: (BuildContext context){
                  return {'Actualizar Lista'}.map((String item){
                    return PopupMenuItem<String>(
                        value: item,
                        child: Text(item)
                    );
                  }).toList();
                }
            ),
        ]
      ),
      body: _listViewEspecialidades(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push (
              context,
              MaterialPageRoute(
              builder:(context) => const Especialidad(idEspecialidad: 0,)
          )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
