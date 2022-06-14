import 'dart:convert';
import 'dart:io';

import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/storage_details.dart';

DateTime pre_backpress = DateTime.now();

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            //show snackbar
            final snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            exit(0);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        MyFiles(),
                        SizedBox(height: defaultPadding),
                        RecentFiles(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        // if (Responsive.isMobile(context))
                        //StarageDetails()
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  // if (!Responsive.isMobile(context))
                  // Expanded(
                  //   flex: 2,
                  // child: StarageDetails(),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future fetchNGONum() async {
    final response = await http
        .get(Uri.parse('https://edonations.000webhostapp.com/api-ngonum.php'));
    var msg = jsonDecode(response.body);
    return msg[0]['count(*)'];
  }

  Future fetchDonorNum() async {
    final response = await http.get(
        Uri.parse('https://edonations.000webhostapp.com/api-donornum.php'));
    var msg = jsonDecode(response.body);
    return msg[0]['count(*)'];
  }

  Future fetchDonationNum() async {
    final response = await http.get(
        Uri.parse('https://edonations.000webhostapp.com/api-donationsnum.php'));
    var msg = jsonDecode(response.body);
    return msg[0]['count(*)'];
  }
}
