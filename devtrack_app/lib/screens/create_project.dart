import 'package:flutter/material.dart';
import '../services/api.dart';

class CreateProject extends StatefulWidget {
  @override
  State<CreateProject> createState() => _CreateProjectState();
}

class _CreateProjectState extends State<CreateProject> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  String selectedStage = "Idea";

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("Create Project"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.green,
      ),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              "New Project",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            SizedBox(height: 30),

            TextField(
              controller: titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Project Title",
                labelStyle: TextStyle(color: Colors.green),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),

            SizedBox(height: 15),

            TextField(
              controller: descController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.green),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),

            SizedBox(height: 15),

            // 🔥 STAGE DROPDOWN
            DropdownButtonFormField<String>(
              value: selectedStage,
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Stage",
                labelStyle: TextStyle(color: Colors.green),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
              items: ["Idea", "Development", "Testing", "Completed"]
                  .map((stage) => DropdownMenuItem(
                        value: stage,
                        child: Text(stage),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedStage = value!;
                });
              },
            ),

            SizedBox(height: 20),

            loading
                ? CircularProgressIndicator(color: Colors.green)
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {

                      if (titleController.text.isEmpty ||
                          descController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Fill all fields")),
                        );
                        return;
                      }

                      setState(() => loading = true);

                      try {
                        print("CREATE BUTTON CLICKED");

                        var res = await ApiService.createProject(
                          1, // 🔥 TEMP USER ID
                          titleController.text,
                          descController.text,
                          selectedStage,
                          "None",
                        );

                        print("RESPONSE: $res");

                        setState(() => loading = false);

                        if (res["success"] == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Project Created")),
                          );

                          Navigator.pop(context); // 🔥 GO BACK & REFRESH
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(res["message"] ?? "Failed")),
                          );
                        }
                      } catch (e) {
                        setState(() => loading = false);

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