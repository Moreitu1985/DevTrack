import 'package:flutter/material.dart';

class CreateProject extends StatelessWidget {
  final title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Project")),
      body: Column(
        children: [
          TextField(controller: title, decoration: InputDecoration(labelText: "Project Title")),
          ElevatedButton(
            onPressed: () {},
            child: Text("Create"),
          )
        ],
      ),
    );
  }
}