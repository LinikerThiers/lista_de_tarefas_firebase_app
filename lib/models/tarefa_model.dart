class TarefaModel {
  String descricao = "";
  bool concluido = false;

  TarefaModel({required this.descricao, required this.concluido});

  TarefaModel.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    concluido = json['concluido'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['concluido'] = concluido;
    return data;
  }
}
