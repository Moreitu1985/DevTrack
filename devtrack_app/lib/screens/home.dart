import 'package:flutter/material.dart';
import '../services/api.dart';
import 'create_project.dart';
import 'celebration.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List projects = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchProjects();
  }

  Future<void> fetchProjects() async {
    try {
      var data = await ApiService.getProjects();
      setState(() {
        projects = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> showStageDialog(int projectId, String currentStage) async {
    String selectedStage = currentStage;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            "Update Stage",
            style: TextStyle(color: Colors.green),
          ),
          content: DropdownButtonFormField<String>(
            value: selectedStage,
            dropdownColor: Colors.black,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
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
              selectedStage = value!;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () async {
                await ApiService.updateProjectStage(projectId, selectedStage);
                Navigator.pop(context);
                fetchProjects();
              },
              child: Text("Save"),
            )
          ],
        );
      },
    );
  }

  void logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("DevTrack Feed"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: logout,
            icon: Icon(Icons.logout, color: Colors.green),
          )
        ],
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : projects.isEmpty
              ? Center(
                  child: Text(
                    "No public projects yet",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    var project = projects[index];

                    return Card(
                      color: Colors.grey[900],
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          project["title"] ?? "",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "Stage: ${project["stage"]}\n${project["description"] ?? ""}\nVisibility: ${project["visibility"] ?? ""}",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            showStageDialog(
                              project["id"],
                              project["stage"],
                            );
                          },
                          child: Text("Update"),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.add, color: Colors.black),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateProject()),
              );
              fetchProjects();
            },
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.green,
            child: Icon(Icons.emoji_events, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CelebrationScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}