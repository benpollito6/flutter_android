import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_android/Models/UsuarioResponse.dart';
import 'package:flutter_android/Pages/Paciente.dart';
import 'package:flutter_android/Utils/Ambiente.dart';
import 'package:http/http.dart' as http;
import '../Models/PacienteResponse.dart';

class Pacientes extends StatefulWidget {
  const Pacientes({super.key});

  @override
  State<Pacientes> createState() => _PacientesState();
}

class _PacientesState extends State<Pacientes> {
  
  List<PacienteResponse> pacientes = [];
  List<UsuarioResponse> usuarios = [];
  
  Widget _listViewPacientes(){
    return ListView.builder(
        itemCount: pacientes.length & usuarios.length,
        itemBuilder: (context, index){
          var paciente = pacientes[index];
          var usuario = usuarios[index];
          return ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Paciente(idPaciente: paciente.id, idUser: usuario.id))
              );
            },
            title: Text(paciente.id.toString()),
            subtitle: Text(paciente.nombre),
          );
        });
  }
  void fnObtenerPacientes ()async{
    var response = await http.get(Uri.parse('${Ambiente.urlServer}/api/pacientes'),
    headers: <String, String> {
      'Content-Type' : 'application/json; charset=UTF-8',
      'Accept' : 'application/json'
    }
    );

    Iterable mapPacientes = jsonDecode(response.body);
    pacientes = List<PacienteResponse>
                .from(
      mapPacientes.map((model) => PacienteResponse.fromJson(model))
    );
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fnObtenerPacientes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pacientes'),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: (value){
                fnObtenerPacientes();
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
        ],
      ),
      body: _listViewPacientes(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Paciente(idPaciente: 0, idUser: 0)
            )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
