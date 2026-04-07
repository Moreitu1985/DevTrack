import 'package:flutter/material.dart';
import '../services/api.dart';
import 'create_project.dart';
import 'celebration.dart';

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

  Future fetchProjects() async {
    setState(() => loading = true);

    try {
      var data = await ApiService.getProjects();
      setState(() {
        projects = data;
        loading = false;
      });
    } catch (e) {
      print("ERROR: $e");
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        title: Text("DevTrack Feed"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.green,
      ),

      body: loading
          ? Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : projects.isEmpty
              ? Center(
                  child: Text(
                    "No projects yet",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchProjects,
                  child: ListView.builder(
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      var project = projects[index];

                      return Card(
                        color: Colors.grey[900],
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(
                            project["title"] ?? "",
                            style: TextStyle(color: Colors.green),
                          ),
                          subtitle: Text(
                            "Stage: ${project["stage"]}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
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

              // 🔥 REFRESH AFTER RETURN
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