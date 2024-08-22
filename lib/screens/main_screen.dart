import 'package:flutter/material.dart';
import 'package:organizer_app/Screens/CreateEvent/create_event.dart';
import 'package:organizer_app/Screens/Dashboard/dashboard_screen.dart';
import 'package:organizer_app/Screens/ListEvent/list_event.dart';
import 'package:organizer_app/Screens/Profile/profile_screen.dart';
import 'package:organizer_app/Screens/Search/search_screen.dart';
import 'package:organizer_app/Screens/bottom_nav.dart';
import 'package:provider/provider.dart';

import '../Provider/page_index_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

List<Widget> pageList = [
  const DashboardScreen(),
  const SearchScreen(),
  const CreateEvent(),
  const ListEvent(),
  const ProfileScreen()
];

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageIndexProvider>(
      builder: (context, pageIndexController, child) {
        return Scaffold(
          body: pageList[pageIndexController.selectedIndex],
          bottomNavigationBar: const BottomNav(),
        );
      },
    );
  }
}
