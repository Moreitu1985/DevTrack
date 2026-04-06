import 'package:flutter/material.dart';
import '../services/api.dart';
import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),

            SizedBox(height: 20),

            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        print("REGISTER CLICKED");

                        var res = await ApiService.register(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                        );

                        print("RESPONSE: $res");

                        setState(() {
                          isLoading = false;
                        });

                        if (res["success"] == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Registration successful")),
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Registration failed")),
                          );
                        }
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                        });

                        print("ERROR: $e");

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Cannot connect to server"),
                          ),
                        );
                      }
                    },
                    child: Text("Register"),
                  ),
          ],
        ),
      ),
    );
  }
}