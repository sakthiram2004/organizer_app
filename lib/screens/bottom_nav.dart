import 'package:flutter/material.dart';
import 'package:organizer_app/Utils/const_color.dart';
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomNavItem(
                    onTap: () {
                      pageIndexController.setSelectedIndex = 0;
                    },
                    color: Colors.deepOrange,
                    icon: pageIndexController.selectedIndex == 0
                        ? Icons.dashboard
                        : Icons.dashboard_outlined),
                BottomNavItem(
                    onTap: () {
                      pageIndexController.setSelectedIndex = 1;
                    },
                    color: Colors.deepOrange,
                    icon: Icons.search),
                BottomNavItem(
                    onTap: () {
                      pageIndexController.setSelectedIndex = 2;
                    },
                    color: Colors.deepOrange,
                    icon: pageIndexController.selectedIndex == 2
                        ? Icons.add_circle_outlined
                        : Icons.add),
                BottomNavItem(
                    onTap: () {
                      pageIndexController.setSelectedIndex = 3;
                    },
                    color: Colors.deepOrange,
                    icon: pageIndexController.selectedIndex == 3
                        ? Icons.analytics
                        : Icons.analytics_outlined),
                BottomNavItem(
                    onTap: () {
                      pageIndexController.setSelectedIndex = 4;
                    },
                    color: Colors.deepOrange,
                    icon: pageIndexController.selectedIndex == 4
                        ? Icons.person
                        : Icons.person_outlined),
              ],
            ),
          ),
        );
      },
    );
  }
}
