class Laptop {
  int id;
  String nome;
  int ram;
  double clockCpu; 

  Laptop(this.id, this.nome, this.ram, this.clockCpu);

  Laptop.navegacao(this.id, this.nome)
      : ram = 4,
        clockCpu = 1.8;

  Laptop.escritorio(this.id, this.nome)
      : ram = 8,
        clockCpu = 2.5;

  Laptop.programacao(this.id, this.nome)
      : ram = 16,
        clockCpu = 3.5;

  void imprimirDetalhes() {
    print('ID: $id | Nome: ${nome.padRight(15)} | RAM: ${ram}GB | CPU: ${clockCpu}GHz');
  }
}

void main() {
  print('--- Laptops (Named Constructors) ---');

  Laptop laptopWeb = Laptop.navegacao(4, 'Chromebook');
  Laptop laptopOffice = Laptop.escritorio(5, 'HP ProBook');
  Laptop laptopDev = Laptop.programacao(6, 'MacBook Pro');

  laptopWeb.imprimirDetalhes();
  laptopOffice.imprimirDetalhes();
  laptopDev.imprimirDetalhes();
}