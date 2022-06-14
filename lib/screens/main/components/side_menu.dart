import 'package:admin/screens/dashboard/components/changepassword.dart';
import 'package:admin/screens/dashboard/components/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../login.dart';

class SideMenu extends StatelessWidget {
  const SideMenu(this.username, this.email, this.contact);
  final username;
  final email;
  final contact;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/1.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProfile(username, email, contact)));
            },
          ),
          DrawerListTile(
            title: "Setting",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ChangePassword()));
            },
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: DrawerListTile(
              title: "Logout",
              svgSrc: "assets/icons/logout-svgrepo-com.svg",
              press: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()),
                    ModalRoute.withName('/login'));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
