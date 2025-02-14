
class Planet {
  int? id;
  String nome;
  double tamanho;
  double distancia;
  String? apelido;

 // Construtor da classe Planeta
  Planet({
    this.id,
    required this.nome,
    required this.tamanho,
    required this.distancia,
    this.apelido,
  });
}