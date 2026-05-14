import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  String message = "";

  Future<void> loginUser() async {

    final url = Uri.parse(
      "http://192.168.110.241:8000/api/token/",
    );

    try {

      final response = await http.post(

        url,

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({

          "username":
              usernameController.text.trim(),

          "password":
              passwordController.text.trim(),
        }),
      );

      debugPrint(response.statusCode);
      debugPrint(response.body);

      if (response.statusCode == 200) {

        setState(() {
          message =
              "Login Successful ✅";
        });

        Navigator.push(

          context,

          MaterialPageRoute(
            builder: (context) =>
                const HomePage(),
          ),
        );
      }

      else {

        setState(() {
          message =
              "Invalid Username or Password ❌";
        });
      }
    }

    catch (e) {

      print(e);

      setState(() {
        message =
            "Server Connection Failed ❌";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.blueGrey[900],

      body: Center(

        child: SingleChildScrollView(

          child: Container(

            width: 350,

            padding: const EdgeInsets.all(20),

            margin: const EdgeInsets.all(20),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(15),
            ),

            child: Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                const Text(

                  "NoteFlow Login",

                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                TextField(

                  controller:
                      usernameController,

                  decoration:
                      const InputDecoration(
                    labelText: "Username",
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(

                  controller:
                      passwordController,

                  obscureText: true,

                  decoration:
                      const InputDecoration(
                    labelText: "Password",
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(

                  width: double.infinity,

                  child: ElevatedButton(

                    onPressed: loginUser,

                    child:
                        const Text("Login"),
                  ),
                ),

                const SizedBox(height: 15),

                Text(

                  message,

                  textAlign:
                      TextAlign.center,

                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("NoteFlow"),
      ),

      body: const Center(

        child: Text(

          "JWT Authentication Successful 🎉",

          style: TextStyle(
            fontSize: 22,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
    );
  }
}