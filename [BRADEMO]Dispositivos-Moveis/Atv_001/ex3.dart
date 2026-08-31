class Laptop {
  int id;
  String nome;
  int ram; 
  double clockCpu;

  Laptop(this.id, this.nome, this.ram, this.clockCpu);

  void imprimirDetalhes() {
    print('Id: $id | Nome: ${nome.padRight(15)} | RAM: ${ram}GB | CPU: ${clockCpu}GHz');
  }
}

void main() {

  print('--- Construtor Padrão ---');
  Laptop laptop1 = Laptop(1, 'Dell Inspiron', 8, 2.4);
  Laptop laptop2 = Laptop(2, 'Acer Aspire', 12, 2.8);
  Laptop laptop3 = Laptop(3, 'Asus VivoBook', 16, 3.2);

  laptop1.imprimirDetalhes();
  laptop2.imprimirDetalhes();
  laptop3.imprimirDetalhes();
}