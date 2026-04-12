import 'package:flutter/material.dart';
import '../services/api.dart';

class CelebrationScreen extends StatefulWidget {
  @override
  State<CelebrationScreen> createState() => _CelebrationScreenState();
}

class _CelebrationScreenState extends State<CelebrationScreen> {
  List allProjects = [];
  List completedProjects = [];
  bool loading = true;

  int? selectedProjectId;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var projects = await ApiService.getProjects();
      var completed = await ApiService.getCompletedProjects();

      // only projects not yet completed
      List availableProjects =
          projects.where((p) => p["stage"] != "Completed").toList();

      // reset invalid selected value
      if (selectedProjectId != null &&
          !availableProjects.any((p) => p["id"] == selectedProjectId)) {
        selectedProjectId = null;
      }

      setState(() {
        allProjects = availableProjects;
        completedProjects = completed;
        loading = false;
      });
    } catch (e) {
      print("ERROR: $e");
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> markAsCompleted() async {
    if (selectedProjectId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a project")),
      );
      return;
    }

    var res = await ApiService.updateProjectStage(
      selectedProjectId!,
      "Completed",
    );

    if (res["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Project marked as completed 🎉")),
      );
      setState(() {
        selectedProjectId = null;
      });
      fetchData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update project")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Celebration Wall 🎉"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.green,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Celebrate a Project",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15),

                  DropdownButtonFormField<int>(
                    value: selectedProjectId,
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Choose Project",
                      labelStyle: TextStyle(color: Colors.green),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                    ),
                    items: allProjects
                        .map<DropdownMenuItem<int>>(
                          (project) => DropdownMenuItem<int>(
                            value: project["id"] as int,
                            child: Text(project["title"] ?? ""),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedProjectId = value;
                      });
                    },
                  ),

                  SizedBox(height: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: markAsCompleted,
                    child: Text("Celebrate & Mark Completed"),
                  ),

                  SizedBox(height: 30),

                  Text(
                    "Completed Projects",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 15),

                  Expanded(
                    child: completedProjects.isEmpty
                        ? Center(
                            child: Text(
                              "No completed projects yet",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : ListView.builder(
                            itemCount: completedProjects.length,
                            itemBuilder: (context, index) {
                              final project = completedProjects[index];

                              return Card(
                                color: Colors.grey[900],
                                margin: EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.emoji_events,
                                    color: Colors.green,
                                  ),
                                  title: Text(
                                    project["title"] ?? "",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    project["description"] ?? "Well done!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}