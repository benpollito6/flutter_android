import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_android/Models/LoginResponse.dart';
import 'package:flutter_android/Pages/Especialidades.dart';
import 'package:flutter_android/Pages/Pacientes.dart';
import 'package:flutter_android/Utils/Ambiente.dart';
import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtUser = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body:
        SingleChildScrollView(
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/login128.png'),
              //Image.network('https://cdn-icons-png.flaticon.com/512/295/295128.png'),
              Padding(padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: TextFormField(
                controller: txtUser,
                decoration: const InputDecoration(
                    labelText: 'Usuario'
                ),
              ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: TextFormField(
                controller: txtPassword,
                decoration: const InputDecoration(
                    labelText: 'Contraseña'
                ),
                obscureText: true,
              ),
              ),
              TextButton(onPressed: () async{
                final response = await http.post(
                    Uri.parse('${Ambiente.urlServer}/api/login'),
                    body: jsonEncode(<String, dynamic> {
                  'email' : txtUser.text,
                  'password' : txtPassword.text
                }),
                  headers: <String, String> {
                      'Content-Type' : 'application/json; charset=UTF-8'
                  }
                );

                print(response.body);

                Map<String, dynamic> responseJson = jsonDecode(response.body);
                final loginResponse = LoginResponse.fromJson(responseJson);
                if(loginResponse.acceso == "Ok") {
                  Navigator.push (
                    context,
                    MaterialPageRoute(
                      builder:(context) => const Pacientes()
                  )

                  );
                }
                else
                {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Oops...',
                    text: loginResponse.error,
                  );
                }
              }, child: Text('Ingresar'))
            ],
          ),
        )
    );
  }
}