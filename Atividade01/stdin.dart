import 'dart:io';

void main() {
  print('Qual é o seu nome?');
  String? nome = stdin.readLineSync();
  print("Qual sua idade?");
  String? n = stdin.readLineSync();
  if (nome != null && n != null) {
    int idade = int.parse(n);
    print('Seu nome é $nome');
    print("Você irá fazer ${idade + 1} anos.");
  }
}
