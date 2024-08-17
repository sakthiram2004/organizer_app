import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:organizer_app/Utils/const_color.dart';

import '../../Utils/height_width.dart';
import '../../Widget/text_style.dart';

class TabView extends StatefulWidget {
  const TabView({super.key});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.sizeOf(context).height;
    double _width = MediaQuery.sizeOf(context).width;
  String _image = "";
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Column(
        children: [
          SizedBox(
              height: height(
                0.405,
                context,
              ),
              child: SingleChildScrollView(
                child: LayoutGrid(
                  columnSizes:
                  _width > 600 ? [1.fr, 1.fr, 1.fr] : [1.fr, 1.fr],
                  rowSizes: List.generate(
                      [1,2,3,4].length, (_) => auto),
                  columnGap: 12,
                  rowGap: 8,
                  children: List.generate([1,2,4,5].length,
                          (index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: (_image.isNotEmpty &&
                                        "".isNotEmpty &&
                                        Uri.parse(_image)
                                            .isAbsolute)
                                        ? NetworkImage(
                                        "")
                                        : const AssetImage("assets/event1.jpg")
                                    as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                       "Music",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.date_range,
                                          color: Colors.purple,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "date"
                                              .toString()
                                              .substring(0, 10) ??
                                              "",
                                          style: const TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Colors.black,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                         "location",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          height: 30,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 4, 40, 147),
                                              borderRadius:
                                              BorderRadius.circular(8)),
                                          child: InkWell(
                                            onTap: () {

                                            },
                                            child: const Center(
                                              child: Text(
                                                'View',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
          ),
          ])
    );
  }
}
