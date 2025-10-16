import 'package:firebase_app/shared/widgets/custom_drawer.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  //final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  Widget build(BuildContext context) {
    final remoteConfig = FirebaseRemoteConfig.instance;
    return Scaffold(
      backgroundColor:
          Color(int.parse("0xff${remoteConfig.getString("COR_FUNDO_TELA")}")),
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        color:
            Color(int.parse("0xff${remoteConfig.getString("COR_FUNDO_TELA")}")),
        margin: EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}
