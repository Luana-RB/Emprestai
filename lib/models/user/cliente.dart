class Cliente {
  String nome;
  int idade;
  String cidade;
  String telefone;
// Construtor
  Cliente(
      {required this.nome,
      required this.idade,
      required this.cidade,
      required this.telefone});
// Métodos adicionais (opcionais)
  String getInfo() {
    return 'Nome: $nome, Idade: $idade, Cidade: $cidade, Telefone: $telefone';
  }
}
