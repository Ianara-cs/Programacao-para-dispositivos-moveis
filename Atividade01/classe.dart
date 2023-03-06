class Veiculo {
  double velocidade;
  String cor;
  double peso;

  Veiculo(this.velocidade, this.cor, this.peso) {}
}

class Carro extends Veiculo {
  Carro(double velocidade, String cor, double peso)
      : super(velocidade, cor, peso);

  void infor_carro() {
    print('Informações do carro');
    print('velocidade = ' + this.velocidade.toString());
    print('cor = ' + this.cor);
    print('peso = ' + this.peso.toString());
  }
}

class Aviao extends Veiculo {
  int num_helices;

  Aviao(double velocidade, String cor, this.num_helices, double peso)
      : super(velocidade, cor, peso);

  void infor_aviao() {
    print('Informações do Aviao');
    print('velocidade = ' + this.velocidade.toString());
    print('cor = ' + this.cor);
    print('peso = ' + this.peso.toString());
    print('Número de hélices = ' + this.num_helices.toString());
  }
}

void main() {
  Carro carro1 = new Carro(80, 'vermenlho', 1100);
  Aviao aviao1 = new Aviao(850, 'azul', 2, 56000);

  carro1.infor_carro();
  aviao1.infor_aviao();
}
