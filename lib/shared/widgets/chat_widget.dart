import 'package:firebase_app/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  final ChatModel chatModel;
  final bool myMessage;
  const ChatWidget(
      {super.key, required this.chatModel, required this.myMessage});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: myMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: (myMessage) ? Colors.grey[700] : Colors.grey[300],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(chatModel.nickname),
            SizedBox(
              height: 4,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    myMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                Text(
                  chatModel.text,
                  style:
                      TextStyle(color: (myMessage) ? Colors.white : Colors.black, fontSize: 16),
                ),
                SizedBox(
              width: 8,
            ),
            Text(
              (() {
                DateTime dataHora = chatModel.dataHora;
                return '${dataHora.hour.toString().padLeft(2, '0')}:${dataHora.minute.toString().padLeft(2, '0')}';
              })(),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
