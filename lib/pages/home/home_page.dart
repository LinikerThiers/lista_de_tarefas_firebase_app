import 'package:firebase_app/pages/chat/chat_page.dart';
import 'package:firebase_app/shared/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var nicknameController = TextEditingController();
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Informe seu apelido:"),
              TextField(
                controller: nicknameController,
              ),
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => ChatPage(nickname: nicknameController.text
                )));
              }, child: Text("Entrar no chat"))
            ],
          ),
        ),
      ),
    );
  }
}
