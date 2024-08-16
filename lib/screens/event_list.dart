import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:organizer_app/Utils/const_color.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    final col = ConstColor();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Events List',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: col.teritary,
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: col.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: col.primary,
                  tabs: const [
                    Tab(
                      text: 'Active',
                    ),
                    Tab(
                      text: 'Rejected',
                    ),
                    Tab(
                      text: 'Completed',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Text(
                'Active Page',
                style: TextStyle(
                  fontSize: 18,
                  color: col.teritary,
                ),
              ),
            ),
            Center(
              child: Text(
                'Rejected Page',
                style: TextStyle(
                  fontSize: 18,
                  color: col.teritary,
                ),
              ),
            ),
            Center(
              child: Text(
                'Completed Page',
                style: TextStyle(
                  fontSize: 18,
                  color: col.teritary,
                ),
              ),
            ),
          ],
        ),
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
      ),
    );
  }
}