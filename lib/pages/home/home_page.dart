import 'package:firebase_app/pages/chat/chat_page.dart';
import 'package:firebase_app/shared/widgets/custom_drawer.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  Widget build(BuildContext context) {
    var nicknameController = TextEditingController();
    final remoteConfig = FirebaseRemoteConfig.instance;
    return Scaffold(
      backgroundColor: Color(int.parse("0xff${remoteConfig.getString("COR_FUNDO_TELA")}")),
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        color: Color(int.parse("0xff${remoteConfig.getString("COR_FUNDO_TELA")}")),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(remoteConfig.getString("TEXTO_CHAT")),
              TextField(
                controller: nicknameController,
              ),
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => ChatPage(nickName: nicknameController.text
                )));
              }, child: Text("Entrar no chat"))
            ],
          ),
        ),
      ),
    );
  }
}
