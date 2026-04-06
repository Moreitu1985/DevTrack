import 'package:flutter/material.dart';
import '../services/api.dart';

class CreateProject extends StatefulWidget {
  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Project")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Project Title"),
            ),

            TextField(
              controller: descController,
              decoration: InputDecoration(labelText: "Description"),
            ),

            SizedBox(height: 20),

            loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });

                      try {
                        print("CREATE BUTTON CLICKED");

                        var res = await ApiService.createProject(
                          1, // user_id (temporary)
                          titleController.text,
                          descController.text,
                          "Development",
                          "None",
                        );

                        print("RESPONSE: $res");

                        setState(() {
                          loading = false;
                        });

                        if (res["success"] == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Project Created")),
                          );

                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Failed to create project")),
                          );
                        }
                      } catch (e) {
                        setState(() {
                          loading = false;
                        });

                        print("ERROR: $e");

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Server error")),
                        );
                      }
                    },
                    child: Text("Create"),
                  ),
          ],
        ),
      ),
    );
  }
}