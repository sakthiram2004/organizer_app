import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/page_index_provider.dart';
import '../Widget/bottom_nav_item.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageIndexProvider>(
      builder: (context, pageIndexController, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.all(Radius.circular(16)),
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomNavItem(
                      onTap: () {
                        pageIndexController.setSelectedIndex = 0;
                      },
                      color: Colors.orange,
                      icon: pageIndexController.selectedIndex == 0
                          ? Icons.dashboard
                          : Icons.dashboard_outlined),
                  BottomNavItem(
                      onTap: () {
                        pageIndexController.setSelectedIndex = 1;
                      },
                      color: Colors.blueGrey,
                      icon: Icons.search),
                  BottomNavItem(
                      onTap: () {
                        pageIndexController.setSelectedIndex = 2;
                      },
                      color: Colors.purple,
                      icon: pageIndexController.selectedIndex == 2
                          ? Icons.add_circle_outlined
                          : Icons.add),
                  BottomNavItem(
                      onTap: () {
                        pageIndexController.setSelectedIndex = 3;
                      },
                      color: Colors.teal,
                      icon: pageIndexController.selectedIndex == 3
                          ? Icons.event_busy
                          : Icons.event_available),
                  BottomNavItem(
                      onTap: () {
                        pageIndexController.setSelectedIndex = 4;
                      },
                      color: Colors.lightGreenAccent,
                      icon: pageIndexController.selectedIndex == 4
                          ? Icons.person
                          : Icons.person_outlined),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
