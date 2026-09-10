void main() {

  var nomeEquipamento = "impressora 3D";
  String local = 'lab prototipos';
  dynamic patrimonio = 12345;
  
  patrimonio = '12345-A';
  
  print("--- Cadastro de Equipamentos ---");
  print('Equipamento:  $nomeEquipamento');
  print('Local:  $local');
  print('Patrimonio:  $patrimonio');
  
  print('equipamento é String ?: ${nomeEquipamento is String}');
  print('local é String ?: ${local is String}');
  print('patrimonio é String ?: ${patrimonio is String}');
  print('patrimonio é int ?: ${patrimonio is int}');
}