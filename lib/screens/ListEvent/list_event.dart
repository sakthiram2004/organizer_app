import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organizer_app/Utils/const_color.dart';
import 'package:organizer_app/Utils/height_width.dart';
import 'package:organizer_app/screens/ListEvent/tab_view.dart';

import '../../Widget/text_style.dart';

class ListEvent extends StatefulWidget {
  const ListEvent({super.key});

  @override
  State<ListEvent> createState() => _ListEventState();
}

class _ListEventState extends State<ListEvent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    // controller: ,
                    isScrollable: true,
                    labelColor: backgroundColor,
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    dividerColor: Colors.transparent,
                    labelStyle: textStyle(24, Colors.black, FontWeight.bold),
                    tabs: const [
                      Tab(text: "Active Event"),
                      Tab(text: "Pending Event"),
                      Tab(text: "Failure Event"),
                    ]),
              ],
            ),

          ),
    Padding(
    padding: EdgeInsets.only(top: height(0.275 , context)),
    child: const TabBarView(
    // controller: ,
    children: [
    TabView(),
    TabView(),
    TabView()
    ]),),
    ],
      )
    );

  }
}
