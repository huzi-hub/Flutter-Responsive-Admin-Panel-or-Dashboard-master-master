// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



class ChangePassword extends StatefulWidget {
  final currentPassword;
  final email;
  final donorId;
  ChangePassword({this.donorId, this.currentPassword, this.email});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

TextEditingController currentpassword = TextEditingController();
TextEditingController newPass = TextEditingController();

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
          backgroundColor: Colors.cyan,
        ),
        body: Center(
          child: Container(
            width: 500,
            margin: EdgeInsets.only(top: 30),
           
            child: ListView(
              children: [
                 Center(
                   child: Text(
                    'Create new password',
                    style: TextStyle(color: Colors.white , fontSize: 30), 
                    
                ),
                 ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  
                  height: 70,
                  child: TextFormField(
                    
                    controller: currentpassword,
                    decoration: InputDecoration(
                      hintText: "Current Password",
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 70,
                  child: TextFormField(
                    controller: newPass,
                    decoration: InputDecoration(hintText: "New Password"),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 70,
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: " Re enter New Password"),
                  ),
                ),
                Container(
                  width: 80,
                  margin: EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    child: Text("Update"),
                    onPressed: () {
                      changePass();
                    },
                  ),
                ),
                // Text(widget.email),
              ],
            ),
          ),
        ));
  }

  Future changePass() async {
    String url =
        'https://edonations.000webhostapp.com/api-admin-changePass.php';
    var data = {'email': widget.email, 'password': newPass.text};
    //var msg = jsonDecode(result.body);
    if (widget.currentPassword == currentpassword.text) {
      var result = await http.post(Uri.parse(url), body: jsonEncode(data));
      if (result.statusCode == 200) {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => Login()));
      } else {
        SnackBar(content: Text('Please Enter Correct Current Password'));
      }
    }
  }
}


// import 'package:flutter/material.dart';

// class CreateNewPasswordView extends StatelessWidget {
//   const CreateNewPasswordView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Back',
//           style: TextStyle(color: Colors.black),
//         ),
//         leadingWidth: 30,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {},
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Container(
//             width: 500,
//             child: ListView(
//               children: [
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Text(
//                   'Create new password',
//                   style: Theme.of(context).textTheme.headline4,
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 // Text(
//                 //   'Your new password must be different from previous used passwords.',
//                 //   style: Theme.of(context).textTheme.subtitle1,
//                 // ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Text(
//                   'Current Password',
//                   style: Theme.of(context).textTheme.subtitle1,
//                 ),
//                 Container(
//                   height: 70,
//                   child: TextFormField(
//                     style: TextStyle(color: Colors.black),
//                     obscureText: true,
//                     decoration: InputDecoration(
                    
//                       helperStyle: TextStyle(fontSize: 14),
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.visibility_off),
//                         onPressed: () {
//                           //change icon
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Text(
//                   'New Password',
//                   style: Theme.of(context).textTheme.subtitle1,
//                 ),
//                 Container(
//                   height: 70,
//                   child: TextFormField(
//                     style: TextStyle(color: Colors.black),
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       helperText: 'Must be at least 8 characters.',
//                       helperStyle: TextStyle(fontSize: 14),
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.visibility_off),
//                         onPressed: () {
//                           //change icon
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Text(
//                   'Confirm Password',
//                   style: Theme.of(context).textTheme.subtitle1,
//                 ),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 Container(
//                   height: 70,
//                   child: TextFormField(
//                     style: TextStyle(color: Colors.black),
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       helperText: 'Both passwords must match.',
//                       helperStyle: TextStyle(fontSize: 14),
//                       suffixIcon: IconButton(
//                         icon: Icon(Icons.visibility_off),
//                         onPressed: () {
//                           //change icon
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text(
//                     'Reset Password',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }