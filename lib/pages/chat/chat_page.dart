import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/chat_model.dart';
import 'package:firebase_app/shared/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final String nickName;
  const ChatPage({super.key, required this.nickName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final db = FirebaseFirestore.instance;
  final mensagemController = TextEditingController(text: "");
  String userId = "";

  @override
  initState() {
    super.initState();
    carregarUsuario();
  }

  carregarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('user_id')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: db.collection("chats").snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? CircularProgressIndicator()
                        : ListView(
                            children: snapshot.data!.docs.map((e) {
                              var chatModel = ChatModel.fromJson(
                                  (e.data() as Map<String, dynamic>));
                              return ChatWidget(
                                  chatModel: chatModel,
                                  myMessage: chatModel.userId == userId);
                            }).toList(),
                          );
                  })),
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 12,
              left: 16,
              right: 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: mensagemController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[400],
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () async {
                    var chatModel = ChatModel(
                      nickname: widget.nickName,
                      text: mensagemController.text,
                      userId: userId,
                    );
                    await db.collection("chats").add(chatModel.toJson());
                    mensagemController.text = "";
                  },
                  icon: Icon(Icons.send, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
