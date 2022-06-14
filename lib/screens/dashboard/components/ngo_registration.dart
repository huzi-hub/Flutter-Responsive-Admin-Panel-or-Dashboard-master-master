// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NGO_Reg extends StatefulWidget {
  @override
  State<NGO_Reg> createState() => _NGO_RegState();
}

class _NGO_RegState extends State<NGO_Reg> {
  // String? value;
  List cities = ['Karachi', 'Lahore', 'Islamabad', 'Quetta'];
  List fow = ['food', 'books', 'clothes'];
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController cell = TextEditingController();
  final TextEditingController storage = TextEditingController();
  String? city;
  String? FOW;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ngo Registration'),
        backgroundColor: Colors.blue[800],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
              height: 200,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'NGOs Registration',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      height: 124,
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
                height: 370,
                width: 300,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildTextFormField('NGOs Name', name),
                      SizedBox(height: 10),
                      buildTextFormField('Email', email),
                      SizedBox(height: 10),
                      buildTextFormField('password', password),
                      SizedBox(height: 10),
                      buildTextFormField('Address', address),
                      SizedBox(height: 10),
                      buildTextFormField('Cell', cell),
                      SizedBox(height: 10),
                      buildTextFormField('storage', storage),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: 160,
                        decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Container(child: citydropDown()),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(child: fowdropdown())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 40,
              width: 110,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blue[800],
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  register();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fowdropdown() {
    return DropdownButton<String>(
      hint: Text('Select'),
      items: fow.map((item) {
        return new DropdownMenuItem(
          child: new Text(
            item,
          ),
          value: item.toString(),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          FOW = val.toString();
        });
      },
      value: FOW,
    );
  }

  Widget citydropDown() {
    return DropdownButton<String>(
      hint: Text('Select Category'),
      items: cities.map((item) {
        return new DropdownMenuItem(
          child: new Text(
            item,
          ),
          value: item.toString(),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          city = val.toString();
        });
      },
      value: city,
    );
  }

  TextFormField buildTextFormField(
      hintname, TextEditingController textController) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
          fillColor: Colors.blue[800],
          filled: true,
          hintText: hintname,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          )),
    );
  }

  Future register() async {
    // locationFromAddress(address.text).then((value) async {

    // print(value[0].latitude.toString());
    // print(value[0].longitude.toString());
    // });
    var results = await Geocoder.local
        .findAddressesFromQuery('${address.text},$city')
        .then((value) async {
      print(value.first.coordinates.latitude);
      String url = 'https://edonations.000webhostapp.com/api-ngo-reg.php';
      var data = {
        'ngo_name': name.text,
        'email': email.text,
        'password': password.text,
        'address': address.text,
        'contact': cell.text,
        'storage': int.parse(storage.text),
        'city': city,
        'field_of_work': FOW,
        'lat': value.first.coordinates.latitude.toString(),
        'lng': value.first.coordinates.longitude.toString(),
      };
      var result = await http.post(Uri.parse(url), body: jsonEncode(data));
      var msg = jsonDecode(result.body);
      if (msg['status'] == false) {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => Login()));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Not Registered!')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registered successfully!')));
        Navigator.of(context).pop();
      }
    });
  }
}
