import 'package:flutter/material.dart';
import 'create_project.dart';
import 'celebration.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DevTrack Feed")),
      body: ListView(
        children: [
          ListTile(
            title: Text("AI Chat App"),
            subtitle: Text("Stage: Development"),
          ),
        ],
      ),
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CreateProject()));
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            child: Icon(Icons.emoji_events),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CelebrationScreen()));
            },
          ),
        ],
      ),
    );
  }
}