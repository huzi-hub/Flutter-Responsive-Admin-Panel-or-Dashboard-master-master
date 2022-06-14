import 'dart:convert';

import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/components/Controllers.dart';
import 'package:admin/screens/dashboard/components/page2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonorList extends StatefulWidget {
  const DonorList({Key? key}) : super(key: key);

  @override
  _DonorListState createState() => _DonorListState();
}

class _DonorListState extends State<DonorList> {
  NotesController notesController = NotesController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donors List'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(
                'Donors Data',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 15),
                width: 1200,
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: FutureBuilder<List>(
                  future: notesController.getDonors(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          Map data = snapshot.data![index];
                          // DateTime date = DateTime.parse(data['date']);
                          return Card(
                            margin: EdgeInsets.all(
                              8.0,
                            ),
                            elevation: 5.0,
                            shadowColor: Colors.grey,
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => showDetails(
                                        data['username'],
                                        data['contact'],
                                        data['address'],
                                        data['image']));
                              },

                              onLongPress: () {
                                // update
                                // Navigator.of(context)
                                //     .push(
                                //   MaterialPageRoute(
                                //     builder: (context) => NoteEditor(
                                //       edit: true,
                                //       id: data['id'],
                                //       note: data['note'],
                                //     ),
                                //   ),
                                // )
                                //     .whenComplete(() {
                                //   setState(() {});
                                // });
                              },

                              contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15.0,
                              ),
                              title: Text(
                                "${data['username']}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              //
                              // subtitle: Text(

                              //   DateFormat("\nyyyy-MM-dd kk:mm a",)
                              //       .format(date)
                              //       .toString(),
                              //   style: TextStyle(
                              //     color: Colors.white ,
                              //     fontSize: 16.0,
                              //   ),
                              // ),
                              //
                              trailing: Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "${snapshot.error}",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "Fetching your Data..",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showDetails(
      String username, String cell, String address, String image) {
    return AlertDialog(
      title: const Text('Doantion Details'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: MemoryImage(base64Decode(image)),
                      fit: BoxFit.fitWidth)
                  // fit: BoxFit.fill,
                  ),
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.height * 0.15,
            ),

            Text(
              'Name:  $username',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Text(
                  'Cell:  ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  cell,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),

            Flexible(
              flex: 2,
              child: Text(
                'Address:  $address',
                style: TextStyle(fontSize: 18),
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.01,
            // ),
          ],
        ),
      ),
    );
  }
}
