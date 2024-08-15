import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:organizer_app/Utils/const_color.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        // onTabChange: (index) {
        //   setState(() {
        //     _index = index;
        //   });
        // },
        curve: Curves.easeInOut,
        backgroundColor: Colors.black,
        color: Colors.white,
        activeColor: ConstColor().secondary,
        tabBackgroundColor: Colors.transparent,
        gap: 2,
        hoverColor: Colors.grey,
        iconSize: 20,
        tabs: [
          GButton(
            text: 'Dashboard',
            icon: Icons.dashboard,
            onPressed: () {},
          ),
          GButton(
            text: 'Create Event',
            icon: CupertinoIcons.creditcard,
            onPressed: () {},
          ),
          GButton(
            text: 'Event Status',
            icon: Icons.event_available_outlined,
            onPressed: () {},
          ),
          GButton(
            text: 'Profile',
            icon: CupertinoIcons.profile_circled,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
