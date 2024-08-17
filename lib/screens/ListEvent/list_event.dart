import 'package:flutter/material.dart';
import 'package:organizer_app/Utils/const_color.dart';
import 'package:organizer_app/Utils/height_width.dart';
import 'package:organizer_app/screens/ListEvent/tab_view.dart';
import '../../Widget/text_style.dart';

class ListEvent extends StatefulWidget {
  const ListEvent({super.key});

  @override
  State<ListEvent> createState() => _ListEventState();
}

class _ListEventState extends State<ListEvent> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height(1.0, context),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.045,bottom: 10),
            color: tertiaryColor,
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.transparent,
              isScrollable: false,
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey.withOpacity(0.4),
              dividerColor: Colors.transparent,
              labelStyle: textStyle(20, Colors.black, FontWeight.bold),
              tabs: const [
                Tab(text: "Active"),
                Tab(text: "Pending"),
                Tab(text: "Complete"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                TabView(),
                TabView(),
                TabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
