import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/tarefa_model.dart';
import 'package:flutter/material.dart';

class TarefaPage extends StatefulWidget {
  TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  final db = FirebaseFirestore.instance;

  final descricaoController = TextEditingController();

  var apenasNaoConcluidos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas"),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          descricaoController.text = "";
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                return AlertDialog(
                  title: Text("Adicionar Tarefa"),
                  content: TextField(
                    controller: descricaoController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancelar")),
                    TextButton(
                        onPressed: () async {
                          var tarefa = TarefaModel(
                              descricao: descricaoController.text,
                              concluido: false);
                          await db.collection("tarefas").add(tarefa.toJson());
                          Navigator.pop(context);
                        },
                        child: Text("Salvar"))
                  ],
                );
              });
        },
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Apenas não concluidos"),
                    Switch(
                      value: apenasNaoConcluidos,
                      onChanged: (bool value) {
                        apenasNaoConcluidos = value;
                        setState(() {});
                      },
                      activeColor: Colors.purple,
                      activeTrackColor: Colors.purple[400],
                      inactiveThumbColor: Colors.purple[200],
                      inactiveTrackColor: Colors.purple[100],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: apenasNaoConcluidos
                          ? db
                              .collection("tarefas")
                              .where('concluido', isEqualTo: false)
                              .snapshots()
                          : db
                              .collection("tarefas")
                              .snapshots(), //é a ligação dele com o db
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? CircularProgressIndicator()
                            : ListView(
                                children: snapshot.data!.docs.map((e) {
                                  var tarefa = TarefaModel.fromJson(
                                      (e.data() as Map<String, dynamic>));
                                  return Dismissible(
                                      onDismissed: (DismissDirection
                                          dismissDirection) async {
                                        await db
                                            .collection("tarefas")
                                            .doc(e.id)
                                            .delete();
                                      },
                                      key: Key(e.id),
                                      background: Container(
                                        color: Colors.purple,
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Icon(Icons.delete,
                                            color: Colors.white),
                                      ),
                                      child: ListTile(
                                        title: Text(tarefa.descricao),
                                        trailing: Switch(
                                            value: tarefa.concluido,
                                            onChanged: (bool value) async {
                                              tarefa.concluido = value;
                                              await db
                                                  .collection("tarefas")
                                                  .doc(e.id)
                                                  .update(tarefa
                                                      .toJson()); //ou pode fazer so com o que quer atualizar
                                              //.update({"concluido": value});
                                            }),
                                      ));
                                }).toList(),
                              );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
