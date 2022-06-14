import 'dart:convert';

import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'controllers/MenuController.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Expanded(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                  height: 300,
                  width: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          color: Colors.blue[800],
                          fontSize: 25,
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          height: 180,
                          width: 230,
                          child: Image(
                            image: AssetImage(
                              'assets/1.png',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    height: 250,
                    width: 300,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              fillColor: Colors.blue[800],
                              filled: true,
                              hintText: ('Email'),
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              )),
                        ),
                        SizedBox(height: 40),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              fillColor: Colors.blue[800],
                              filled: true,
                              hintText: ('Password'),
                              hintStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: 300,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.blue[800],
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      LoginUser();
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Dont Have Acccount?'),
                    TextButton(
                        onPressed: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text('SignUp')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future LoginUser() async {
    String url = 'https://edonations.000webhostapp.com/admin-login.php';
    var data = {
      'email': emailController.text,
      'password': passwordController.text,
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (msg[0] != null) {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => HomePage(msg[0]['username'], msg[0]['email'],
        //         msg[0]['adminid'], msg[0]['currentpass'])));

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => MenuController(),
                    ),
                  ],
                  child: MainScreen(
                      msg[0]['username'],
                      msg[0]['email'],
                      msg[0]['adminid'],
                      msg[0]['currentpass'],
                      msg[0]['contact']),
                )));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Username or Password!')));
    }
  }
}
