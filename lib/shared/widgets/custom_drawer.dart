import 'package:firebase_app/pages/chat/chat_page.dart';
import 'package:firebase_app/pages/tarefa_page.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var nicknameController = TextEditingController();
    final remoteConfig = FirebaseRemoteConfig.instance;
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.task),
            title: Text("Tarefas"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => TarefaPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text("Chat"),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      content: Wrap(
                        children: [
                          Text(remoteConfig.getString("TEXTO_CHAT")),
                          TextField(),
                          TextButton(
                              onPressed: () {
                                nicknameController.text = "";
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ChatPage(
                                            nickName:
                                                nicknameController.text)));
                              },
                              child: Text("Entrar no chat"))
                        ],
                      ),
                    );
                  });
            },
          ),
          ListTile(
            leading: Icon(Icons.bug_report),
            title: Text("Firebase Crashlytics"),
            onTap: () => throw Exception(),
          ),
        ],
      ),
    );
  }
}
