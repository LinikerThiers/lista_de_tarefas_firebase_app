import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExemploPage extends StatefulWidget {
  const ExemploPage({super.key, required this.title});

  final String title;

  @override
  State<ExemploPage> createState() => _ExemploPageState();
}

class _ExemploPageState extends State<ExemploPage> {
  int _counter = 0;

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    var db = FirebaseFirestore.instance;
    final user = <String, dynamic>{
      "first": "Ada",
      "last": "Lovelace",
      "born": 1815
    };

    var doc = await db.collection("users").add(user);
    debugPrint('DocumentSnapshot added with ID: ${doc.id}');

    var users = await db.collection("users").get();
    for (var doc in users.docs) {
      debugPrint("${doc.id} => ${doc.data()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );
  }
}