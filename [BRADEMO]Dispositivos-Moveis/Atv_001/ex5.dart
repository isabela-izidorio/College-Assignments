import 'dart:io';

class House {
  int id;
  String name;
  double price;

  House(this.id, this.name, this.price);
}

void main() {
  List<House> houses = [];

  print('=== Sistema de Cadastro de Residências ===\n');

  for (int i = 0; i < 3; i++) {
    print('--- Dados da Casa ${i + 1} ---');
    
    stdout.write('Digite o ID: ');
    int id = int.parse(stdin.readLineSync()!); 

    stdout.write('Digite o Nome (ex: Casa de Praia): ');
    String name = stdin.readLineSync()!;

    stdout.write('Digite o Preço: ');
    double price = double.parse(stdin.readLineSync()!);

    House newHouse = House(id, name, price);
    houses.add(newHouse);
    
    print(''); 
  }

  for (var house in houses) {
    house..name = '${house.name} (Cadastrada)';
  }

  print('=== Lista de Residências Cadastradas ===');
  for (var house in houses) {
    print('ID: ${house.id} | Nome: ${house.name} | Preço: R\$ ${house.price.toStringAsFixed(2)}');
  }
}