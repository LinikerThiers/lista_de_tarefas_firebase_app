import 'package:firebase_app/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarHome();
  }

  carregarHome() async {
    final prefs = await SharedPreferences.getInstance();
    var uuid = Uuid();
    var userId = prefs.getString('user_id');
    if (userId == null || userId.isEmpty) {
      userId = uuid.v4();
      await prefs.setString('user_id', userId);
    }
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
