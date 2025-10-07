import 'package:firebase_app/pages/tarefa_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        ListTile(
          leading: Icon(Icons.task),
          title: Text("Tarefas"),
          onTap: () {Navigator.push(context, MaterialPageRoute(builder: (_) => TarefaPage()));},
        )
      ],),
    );
  }
}