import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/tarefa_model.dart';
import 'package:flutter/material.dart';

class TarefaPage extends StatelessWidget {
  final descricaoController = TextEditingController();
  TarefaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas"),),
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
                    TextButton(onPressed: () async {
                      var db = FirebaseFirestore.instance;
                      var tarefa = TarefaModel(descricao: "tarefa 1", concluido: false);
                      var doc = await db.collection("tarefas").add(tarefa.toJson());
                      Navigator.pop(context);
                    }, child: Text("Salvar"))
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
                      value: true,
                      onChanged: (bool value) {},
                      activeColor: Colors.purple,
                      activeTrackColor: Colors.purple[400],
                      inactiveThumbColor: Colors.purple[200],
                      inactiveTrackColor: Colors.purple[100],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext bc, int index) {
                        return Dismissible(
                          onDismissed: (DismissDirection dismissDirection) {},
                            key: UniqueKey(),
                            background: Container(
                              color: Colors.purple,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            child: ListTile(
                              title: Text("Tarefa"),
                              trailing:
                                  Switch(value: true, onChanged: (bool value) {}),
                            ));
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
