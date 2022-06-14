import 'package:admin/constants.dart';
import 'package:admin/screens/dashboard/components/Controllers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  NotesController notesController = NotesController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Data'),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Text(
                'Donation List',
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
                  future: notesController.getNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            Map data = snapshot.data![index];
                            return Card(
                              margin: EdgeInsets.all(
                                8.0,
                              ),
                              elevation: 5.0,
                              shadowColor: Colors.blue,
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                      context: (context),
                                      builder: (context) => showDetails(
                                          data['ngo_name'],
                                          data['username'],
                                          data['quantity'],
                                          data['name']));
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
                                  "${data['name']}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                //
                                subtitle: Text(
                                  data['date'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                                //
                                trailing: Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          });
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
                          "Fetching your notes..",
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
      String ngoname, String donorname, String quantity, String donationName) {
    return AlertDialog(
      title: const Text('Doantion Details'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              'Donation:  $donationName',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                Text(
                  'To:  ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  ngoname,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'From:  ',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  donorname,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.01,
            // ),
            Text(
              'Quantity:  $quantity',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
