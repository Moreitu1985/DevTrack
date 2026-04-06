import 'package:flutter/material.dart';

class CelebrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Celebration Wall 🎉")),
      body: ListView(
        children: [
          ListTile(
            title: Text("Completed Project"),
            subtitle: Text("Well done!"),
          )
        ],
      ),
    );
  }
}