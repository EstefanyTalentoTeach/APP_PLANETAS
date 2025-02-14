import 'package:flutter/material.dart';

class TerraPlaneta extends StatefulWidget {
  const TerraPlaneta({super.key});

  @override
  State<TerraPlaneta> createState() => _TerraPlanetaState();
}

class _TerraPlanetaState extends State<TerraPlaneta> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastrar Planta'),
        elevation: 3,
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: Text('Oi'), // Aqui você pode adicionar campos de formulário, se necessário.
        ),
      ),
    );
  }
}





