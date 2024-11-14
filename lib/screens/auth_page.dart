// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo/widgets/auth_form.dart';

import '../constants/colors.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(color: tdBGColor),
        ),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Minhas Tarefas',
                  style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.w700, color: tdBlack),
                ),
              ),
              AuthForm(),
            ],
          ),
        )
      ]),
    );
  }
}
