import 'dart:convert';

import 'package:admin/models/MyFiles.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/ngo_registration.dart';
import 'package:admin/screens/dashboard/components/page1.dart';
import 'package:admin/screens/dashboard/components/page2.dart';
import 'package:admin/screens/dashboard/components/page3.dart';
import 'package:admin/screens/dashboard/components/page4.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFiles> createState() => _MyFilesState();
}

String ngoNum = "";
String donationNum = "";
String DonorNum = "";
String pendingNum = "";

class _MyFilesState extends State<MyFiles> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDonationNum().then((value) {
      setState(() {
        donationNum = value.toString();
      });
    });
    fetchDonorNum().then((value) {
      setState(() {
        DonorNum = value.toString();
      });
    });
    fetchNGONum().then((value) {
      setState(() {
        ngoNum = value.toString();
      });
    });
    fetchpenDonNum().then((value) {
      setState(() {
        pendingNum = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Files",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NGO_Reg()));
              },
              icon: Icon(Icons.add),
              label: Text("Add New Ngo"),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

List routes = [PageOne(), PageOne2(), DonorList(), PageOne4()];
Future fetchNGONum() async {
  final response = await http
      .get(Uri.parse('https://edonations.000webhostapp.com/api-ngonum.php'));
  var msg = jsonDecode(response.body);
  return msg[0]['count(*)'];
}

Future fetchpenDonNum() async {
  final response = await http.get(Uri.parse(
      'https://edonations.000webhostapp.com/api-count-pendingDonations.php'));
  var msg = jsonDecode(response.body);
  return msg[0]['count'];
}

Future fetchDonorNum() async {
  final response = await http
      .get(Uri.parse('https://edonations.000webhostapp.com/api-donornum.php'));
  var msg = jsonDecode(response.body);
  return msg[0]['count(*)'];
}

Future fetchDonationNum() async {
  final response = await http.get(
      Uri.parse('https://edonations.000webhostapp.com/api-donationsnum.php'));
  var msg = jsonDecode(response.body);
  return msg[0]['count(*)'];
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    print(ngoNum);
    print(donationNum);
    print(DonorNum);
    print(pendingNum);
    while (ngoNum == "" ||
        donationNum == "" ||
        DonorNum == "" ||
        pendingNum == "") {
      return CircularProgressIndicator();
    }
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => InkWell(
        child: FileInfoCard(info: demoMyFiles[index]),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => routes[index]));
        },
      ),
    );
  }
}

List demoMyFiles = [
  CloudStorageInfo(
    title: "Donations List",
    numOfFiles: int.parse(donationNum),
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: "",
    color: primaryColor,
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "NGOs List",
    numOfFiles: int.parse(ngoNum),
    svgSrc: "assets/icons/list-svgrepo-com.svg",
    totalStorage: '',
    color: Color(0xFFFFA113),
    percentage: 35,
  ),
  CloudStorageInfo(
    title: "Donors List",
    numOfFiles: int.parse(DonorNum),
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: '',
    color: Color(0xFFA4CDFF),
    percentage: 10,
  ),
  CloudStorageInfo(
    title: "Pending Donations",
    numOfFiles: int.parse(pendingNum),
    svgSrc: "assets/icons/Documents.svg",
    totalStorage: '',
    color: Color(0xFF007EE5),
    percentage: 78,
  ),
];
