
import 'package:path/path.dart';

class ControlePlaneta {
  static Database? _db;

  // Função para iniciar o banco de dados
  static Future<Database> _iniciarBanco() async {
    if (_db != null) {
      return _db!;
    }

    String caminhoBanco = join(await getDatabasesPath(), 'planetas.db');
    _db = await openDatabase(
      caminhoBanco,
      version: 1,
      onCreate: (db, version) async {
        // Criação da tabela 'planetas'
        await db.execute('''
          CREATE TABLE planetas(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            distancia_sol REAL,
            tamanho REAL
          );
        ''');
      },
    );
    return _db!;
  }

  // Adicionar um planeta
  static Future<void> adicionarPlaneta(String nome, double distanciaSol, double tamanho) async {
    final db = await _iniciarBanco();
    await db.insert(
      'planetas',
      {
        'nome': nome,
        'distancia_sol': distanciaSol,
        'tamanho': tamanho,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Listar todos os planetas
  static Future<List<Map<String, dynamic>>> listarPlanetas() async {
    final db = await _iniciarBanco();
    return await db.query('planetas');
  }

  // Excluir um planeta
  static Future<void> excluirPlaneta(int id) async {
    final db = await _iniciarBanco();
    await db.delete(
      'planetas',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Atualizar um planeta
  static Future<void> atualizarPlaneta(int id, String nome, double distanciaSol, double tamanho) async {
    final db = await _iniciarBanco();
    await db.update(
      'planetas',
      {
        'nome': nome,
        'distancia_sol': distanciaSol,
        'tamanho': tamanho,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  static getDatabasesPath() {}
  
  static openDatabase(String caminhoBanco, {required int version, required Future<Null> Function(dynamic db, dynamic version) onCreate}) {}
}

class Database {
  delete(String s, {required String where, required List<int> whereArgs}) {}
  
  update(String s, Map<String, Object> map, {required String where, required List<int> whereArgs}) {}
  
  query(String s) {}
  
  insert(String s, Map<String, Object> map, {required conflictAlgorithm}) {}
}

class ConflictAlgorithm {
  static var replace;
}
