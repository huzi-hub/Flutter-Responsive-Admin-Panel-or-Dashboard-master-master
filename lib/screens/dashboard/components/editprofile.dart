// ignore_for_file: deprecated_member_use, file_names, prefer_const_constructors

import 'dart:convert';
// import 'package:admin_site/AdminAppbar.dart';

// import 'AdminDashboard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'pickimage.dart';

class EditProfile extends StatefulWidget {
  final username;
  final email1;
  final contact;
  const EditProfile(this.username, this.email1, this.contact);

  @override
  _EditProfileState createState() => _EditProfileState();
}

// late final username;
// late final contact;

class _EditProfileState extends State<EditProfile> {
  String localmage = '';
  TextEditingController usernamee = TextEditingController();
  TextEditingController contactt = TextEditingController();
  TextEditingController addresss = TextEditingController();
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile Info'),
      backgroundColor: Colors.cyan,),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          width: 600,
          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Stack(
                    children: [
                      localmage.isNotEmpty
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  MemoryImage(base64Decode(localmage)),
                            )
                          : const CircleAvatar(
                              radius: 50,
                            ),
                      // Container(

                      //   child:
                      //    CircleAvatar(backgroundImage: NetworkImage(base64Encode(localmage)),),
                      //   // width: 130,
                      //   // height: 130,
                      //   // decoration: BoxDecoration(
                      //   //     border: Border.all(
                      //   //         width: 4,
                      //   //         color: Theme.of(context).scaffoldBackgroundColor),
                      //   //     boxShadow: [
                      //   //       BoxShadow(
                      //   //           spreadRadius: 2,
                      //   //           blurRadius: 10,
                      //   //           color: Colors.black.withOpacity(0.1),
                      //   //           offset: Offset(0, 10))
                      //   //     ],
                      //   //     shape: BoxShape.circle,
                      //   //     image: DecorationImage(

                      //   //         fit: BoxFit.cover,
                      //   //         image: NetworkImage(
                      //   //           "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                      //   //         ))),
                      // ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.blue[800],
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                buildTextField("Full Name", widget.username, false, usernamee),
                SizedBox(
                  height: 25,
                ),
                buildTextField("contact", widget.contact, false, contactt),
                SizedBox(
                  height: 25,
                ),
                // buildTextField("Contact", widget.contact, true, contactt),
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        updatedata();
                      },
                      color: Colors.blue[800],
                      
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    RaisedButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        // HomePage(widget.username, widget.email1)));
                      },
                      color:Colors.blue[800],
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                    // MaterialButton(
                    //   color: Colors.blue[800],
                    //   onPressed: () => chooseImage(),
                    //   child: const Text('Register'),
                    // ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController ctrl) {
    return TextField(
      obscureText: isPasswordTextField ? showPassword : false,
      decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.green,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )),
      controller: ctrl,
    );
  }

  Future updatedata() async {
    String url = 'https://edonations.000webhostapp.com/api-updatedonor.php';
    var data = {
      'username': usernamee.text,
      'address': addresss.text,
      'contact': contactt.text,
      'email': widget.email1,
    };
    var result = await http.post(Uri.parse(url), body: jsonEncode(data));
    //var msg = jsonDecode(result.body);
    if (result.statusCode == 200) {
      if (result.body != null) {
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => AdminDashboard(usernamee)));
      }
    } else {
      SnackBar(content: Text('Not Registered!'));
    }
  }

  void chooseImage() async {
    localmage = await pickImage();
    setState(() {});
    if (localmage != 'Error') {
      String status = await registration(
        image: localmage,
        // password: password.text,
        // fullname: fullName.text,
        // username: username.text,
      );
      print(status);
    }
  }
}
