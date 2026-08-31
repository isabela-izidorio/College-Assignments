import 'dart:io';

void main(){
  cadastrarFunc(nome: "Henrique", cargo: "Diretor de projetos");
  cadastrarFunc(nome: "Rogerio");
}

void cadastrarFunc({required String nome, String? cargo}){
  
  print("-- Cadastro de funcionario --");
  print("Bem vindo, $nome!");

  if(cargo != null)
    print("Cargo: $cargo.");

  print("Cadastro Realizado!");
}