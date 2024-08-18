import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer_app/Utils/const_color.dart';
import 'package:organizer_app/Widget/video_thumnail.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventData = {
      "main_event": {
        "main_event_id": 56,
        "name": "sympo",
        "location": "Pudukottai",
        "org_id": "ORG012",
        "description": "nothing",
        "reg_start": "2022-12-12T18:30:00.000Z",
        "reg_end": "2022-12-28T18:30:00.000Z",
        "category": "sympo",
        "tags": ["react js", "node js"],
        "audience_type": "student",
        "multi_tickets": 1,
        "currency": "INR",
        "main_img": [
          "https://tse3.mm.bing.net/th?id=OIP.uoPbBSz8YFLw52nzSzUwcgHaE7&pid=Api&P=0&h=180",
          "https://i.pinimg.com/originals/8e/07/80/8e078013204d0cc9876e9edbb1fd3f85.jpg"
        ],
        "cover_img": [
          "https://tse3.mm.bing.net/th?id=OIP.uoPbBSz8YFLw52nzSzUwcgHaE7&pid=Api&P=0&h=180",
          "https://i.pinimg.com/originals/8e/07/80/8e078013204d0cc9876e9edbb1fd3f85.jpg"
        ]
      },
      "sub_events": [
        {
          "sub_event_id": 109,
          "main_event_id": 56,
          "name": "music",
          "description": "nothing",
          "images": [
            "https://tse3.mm.bing.net/th?id=OIP.iRaLGvQGVuVVrX0kAmc9bgHaE8&pid=Api&P=0&h=180"
          ],
          "video_url":
              "https://youtube.com/shorts/qTMiHf51mdc?si=msckDze9zszurhE9,https://youtube.com/shorts/qTMiHf51mdc?si=msckDze9zszurhE9,https://youtube.com/shorts/qTMiHf51mdc?si=msckDze9zszurhE9"
                  .split(",")
                  .toList(),
          "start_date": "2003-09-08T18:30:00.000Z",
          "start_time": "09:34:43",
          "end_time": "23:43:54",
          "host_name": "suriya",
          "country_code": "91",
          "host_mobile": "836388283",
          "host_email": "suriys@gmail.com",
          "ticket_type": "normal",
          "ticket_price": 500,
          "ticket_qty": 1000,
          "status": "pending"
        },
        {
          "sub_event_id": 109,
          "main_event_id": 56,
          "name": "music",
          "description": "nothing",
          "images": [
            "https://tse3.mm.bing.net/th?id=OIP.iRaLGvQGVuVVrX0kAmc9bgHaE8&pid=Api&P=0&h=180"
          ],
          "video_url":
              "https://youtube.com/shorts/qTMiHf51mdc?si=msckDze9zszurhE9,https://youtube.com/shorts/qTMiHf51mdc?si=msckDze9zszurhE9,https://youtube.com/shorts/qTMiHf51mdc?si=msckDze9zszurhE9"
                  .split(",")
                  .toList(),
          "start_date": "2003-09-08T18:30:00.000Z",
          "start_time": "09:34:43",
          "end_time": "23:43:54",
          "host_name": "suriya",
          "country_code": "91",
          "host_mobile": "836388283",
          "host_email": "suriys@gmail.com",
          "ticket_type": "normal",
          "ticket_price": 500,
          "ticket_qty": 1000,
          "status": "pending"
        },
        {
          "sub_event_id": 109,
          "main_event_id": 56,
          "name": "music",
          "description": "nothing",
          "images": [
            "https://tse3.mm.bing.net/th?id=OIP.iRaLGvQGVuVVrX0kAmc9bgHaE8&pid=Api&P=0&h=180"
          ],
          "video_url":
              "https://youtube.com/shorts/qTMiHf51mdc?si=msckDze9zszurhE9,https://youtube.com/shorts/qTMiHf51mdc?si=msckDze9zszurhE9,https://youtube.com/shorts/qTMiHf51mdc?si=msckDze9zszurhE9"
                  .split(",")
                  .toList(),
          "start_date": "2003-09-08T18:30:00.000Z",
          "start_time": "09:34:43",
          "end_time": "23:43:54",
          "host_name": "suriya",
          "country_code": "91",
          "host_mobile": "836388283",
          "host_email": "suriys@gmail.com",
          "ticket_type": "normal",
          "ticket_price": 500,
          "ticket_qty": 1000,
          "status": "pending"
        },
        // More sub-events...
      ]
    };

    final mainEvent = eventData['main_event'] as Map<String, dynamic>;
    final subEvents = eventData['sub_events'] as List<dynamic>;

    // Format dates
    String formatDate(String dateStr) {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM d, yyyy').format(date);
    }

    // Format time
    String formatTime(String timeStr) {
      final time = DateTime.parse('1970-01-01T$timeStr');
      return DateFormat('h:mm a').format(time);
    }

    // Status indicator
    Color statusColor(String status) {
      switch (status.toLowerCase()) {
        case 'pending':
          return Colors.orange;
        case 'completed':
          return Colors.green;
        case 'canceled':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    void showImagePopup(BuildContext context, String imageUrl) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: double.infinity,
              height: 400,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          mainEvent['name'] ?? 'Event Details',
          style: const TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Event Images
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              height: 250,
              child: PageView.builder(
                itemCount: mainEvent['cover_img'].length,
                itemBuilder: (context, index) {
                  return Image.network(
                    mainEvent['cover_img'][index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainEvent['name'] ?? 'Event Name',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: ${mainEvent['location'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Text(
                    'Category: ${mainEvent['category'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Description: ${mainEvent['description'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Registration Period: ${formatDate(mainEvent['reg_start'])} to ${formatDate(mainEvent['reg_end'])}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tags: ${mainEvent['tags']?.join(', ') ?? 'N/A'}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Sub Events',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Sub Events List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: subEvents.length,
              itemBuilder: (context, index) {
                final subEvent = subEvents[index] as Map<String, dynamic>;

                return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sub-Event Images Carousel
                          if (subEvent['images'] != null &&
                              subEvent['images'].isNotEmpty)
                            GestureDetector(
                              onTap: () => showImagePopup(
                                  context, subEvent['images'][0]),
                              child: SizedBox(
                                height: 150,
                                child: PageView.builder(
                                  itemCount: subEvent['images'].length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      subEvent['images'][index],
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            ),
                          // Ensure video_url is a List<String>
                          if (subEvent['video_url'] != null &&
                              subEvent['video_url'] is List<String> &&
                              (subEvent['video_url'] as List<String>)
                                  .isNotEmpty)
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                children: [
                                  ...(subEvent['video_url'] as List<String>)
                                      .map((videoUrl) {
                                    return VideoThumbnailPlayer(
                                        videoUrl: videoUrl);
                                  }),

                                  // Sub-Event Details
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          subEvent['name'] ?? 'Sub-Event Name',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Host: ${subEvent['host_name'] ?? 'N/A'}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          'Date: ${formatDate(subEvent['start_date'])}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          'Time: ${formatTime(subEvent['start_time'])} - ${formatTime(subEvent['end_time'])}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          'Ticket Price: ${subEvent['ticket_price']} ${mainEvent['currency'] ?? 'N/A'}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        ),
                                        Text(
                                          'Ticket Quantity: ${subEvent['ticket_qty']}',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 8),
                                          decoration: BoxDecoration(
                                            color: statusColor(
                                                subEvent['status'] ?? 'N/A'),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            subEvent['status']?.toUpperCase() ??
                                                'N/A',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ]));
              },
            ),
          ],
        ),
      ),
    );
  }
}
