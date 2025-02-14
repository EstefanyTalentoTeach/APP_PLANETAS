import 'package:flutter/material.dart';
import 'package:myapp/controles/controle_planeta.dart' show ControlePlaneta;
// ignore: unused_import
import 'controle_planeta.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> planetas = [];
  late TextEditingController nomeController;
  late TextEditingController distanciaController;
  late TextEditingController tamanhoController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController();
    distanciaController = TextEditingController();
    tamanhoController = TextEditingController();
    _carregarPlanetas();
  }

  // Carregar planetas do banco de dados
  _carregarPlanetas() async {
    var lista = await ControlePlaneta.listarPlanetas();
    setState(() {
      planetas = lista;
    });
  }

  // Excluir planeta
  _excluirPlaneta(int id) async {
    await ControlePlaneta.excluirPlaneta(id);
    _carregarPlanetas(); // Atualiza a lista
  }

  // Adicionar ou Editar Planeta
  _adicionarOuEditarPlaneta({int? id}) async {
    String nome = nomeController.text;
    double distanciaSol = double.parse(distanciaController.text);
    double tamanho = double.parse(tamanhoController.text);

    if (id != null) {
      // Editar
      await ControlePlaneta.atualizarPlaneta(id, nome, distanciaSol, tamanho);
    } else {
      // Adicionar
      await ControlePlaneta.adicionarPlaneta(nome, distanciaSol, tamanho);
    }

    nomeController.clear();
    distanciaController.clear();
    tamanhoController.clear();
    _carregarPlanetas(); // Atualiza a lista de planetas
  }

  // Exibir formulário para adicionar ou editar planeta
  _exibirFormulario({int? id, String? nome, double? distanciaSol, double? tamanho}) {
    nomeController.text = nome ?? '';
    distanciaController.text = distanciaSol?.toString() ?? '';
    tamanhoController.text = tamanho?.toString() ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(id != null ? 'Editar Planeta' : 'Adicionar Planeta'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: distanciaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Distância do Sol (UA)'),
              ),
              TextField(
                controller: tamanhoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Tamanho (km)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _adicionarOuEditarPlaneta(id: id);
                Navigator.pop(context);
              },
              child: Text(id != null ? 'Salvar' : 'Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Planetas')),
      body: ListView.builder(
        itemCount: planetas.length,
        itemBuilder: (context, index) {
          var planeta = planetas[index];
          return ListTile(
            title: Text(planeta['nome']),
            subtitle: Text('Distância: ${planeta['distancia_sol']} UA'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _exibirFormulario(
                      id: planeta['id'],
                      nome: planeta['nome'],
                      distanciaSol: planeta['distancia_sol'],
                      tamanho: planeta['tamanho'],
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _excluirPlaneta(planeta['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibirFormulario();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


