// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:organizer_app/Provider/image_picker_provider.dart';
// import 'package:provider/provider.dart';

// class CreateEvent extends StatefulWidget {
//   const CreateEvent({super.key});

//   @override
//   State<CreateEvent> createState() => _CreateEventState();
// }

// class _CreateEventState extends State<CreateEvent> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for main event details
//   TextEditingController nameController = TextEditingController();
//   TextEditingController locationController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController regStartDateController = TextEditingController();
//   TextEditingController regEndDateController = TextEditingController();
//   TextEditingController latitudeController = TextEditingController();
//   TextEditingController longitudeController = TextEditingController();
//   TextEditingController categoryController = TextEditingController();
//   TextEditingController audienceTypeController = TextEditingController();
//   TextEditingController currencyController = TextEditingController();

//   bool multiTickets = false;
//   List<String> tags = [];

//   // List of sub-event controllers
//   List<Map<String, TextEditingController>> subEventControllers = [];

//   @override
//   void initState() {
//     super.initState();
//     _addSubEvent();
//   }

//   void _addSubEvent() {
//     setState(() {
//       subEventControllers.add({
//         'name': TextEditingController(),
//         'description': TextEditingController(),
//         'video_url': TextEditingController(),
//         'start_date': TextEditingController(),
//         'start_time': TextEditingController(),
//         'end_time': TextEditingController(),
//         'host_name': TextEditingController(),
//         'country_code': TextEditingController(),
//         'host_mobile': TextEditingController(),
//         'host_email': TextEditingController(),
//         'ticket_type': TextEditingController(),
//         'ticket_price': TextEditingController(),
//         'ticket_qty': TextEditingController(),
//       });
//     });
//   }

//   Future<void> _selectDate(BuildContext context, int? index,
//       {bool isStartDate = false, bool isEndDate = false}) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStartDate) {
//           regStartDateController.text = DateFormat('yyyy-MM-dd').format(picked);
//         } else if (isEndDate) {
//           regEndDateController.text = DateFormat('yyyy-MM-dd').format(picked);
//         } else {
//           subEventControllers[index!]['start_date']!.text =
//               DateFormat('yyyy-MM-dd').format(picked);
//         }
//       });
//     }
//   }

//   Future<void> _selectTime(
//       BuildContext context, int index, String timeType) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         final formattedTime = picked.format(context);
//         if (timeType == 'start_time') {
//           subEventControllers[index]['start_time']!.text = formattedTime;
//         } else if (timeType == 'end_time') {
//           subEventControllers[index]['end_time']!.text = formattedTime;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final imagePickerProvider = Provider.of<ImagePickerProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Create Event"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildMainEventDetails(),
//                 const SizedBox(height: 16),
//                 _buildRegistrationPeriod(),
//                 const SizedBox(height: 16),
//                 _buildEventLocation(ImagePickerProvider()),
//                 const SizedBox(height: 16),
//                 _buildImagePicker(imagePickerProvider),
//                 const SizedBox(height: 16),
//                 _buildSubEvents(imagePickerProvider),
//                 const SizedBox(height: 16),
//                 _buildSubmitButton(imagePickerProvider),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMainEventDetails() {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Main Event Details',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: nameController,
//           cursorColor: Colors.black,
//           decoration: InputDecoration(
//             labelText: 'Event Name',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter event name' : null,
//         ),
//         TextFormField(
//           controller: locationController,
//           cursorColor: Colors.black,
//           decoration: InputDecoration(
//             labelText: 'Location',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           validator: (value) => value!.isEmpty ? 'Please enter location' : null,
//         ),
//         TextFormField(
//           maxLength: 10,
//           controller: descriptionController,
//           cursorColor: Colors.black,
//           decoration: InputDecoration(
//             labelText: 'Discription',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           maxLines: 3,
//         ),
//         DropdownButtonFormField(
//           value: 'Bootcamp',
//           decoration: InputDecoration(
//             labelText: 'Category',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           items: [
//             'Symposium',
//             'Workshop',
//             'Conference',
//             'Seminar',
//             'Webinar',
//             'Hackathon',
//             'Meetup',
//             'Networking Event',
//             'Panel Discussion',
//             'Exhibition',
//             'Trade Show',
//             'Lecture',
//             'Round Table',
//             'Training Session',
//             'Bootcamp',
//             'Product Launch',
//             'Fundraiser',
//             'Award Ceremony',
//             'Cultural Event',
//             'Sports Event'
//           ].map((String category) {
//             return DropdownMenuItem(value: category, child: Text(category));
//           }).toList(),
//           onChanged: (value) => categoryController.text = value.toString(),
//         ),
//         TextFormField(
//           controller: audienceTypeController,
//           cursorColor: Colors.black,
//           decoration: InputDecoration(
//             labelText: 'Audiance Type',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter audience type' : null,
//         ),
//         CheckboxListTile(
//           title: const Text('Allow Multi Tickets'),
//           value: multiTickets,
//           onChanged: (value) => setState(() => multiTickets = value!),
//         ),
//         DropdownButtonFormField(
//           value: 'INR',
//           decoration: InputDecoration(
//             labelText: 'Currency',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           items: ['INR', 'USD', 'EUR', 'JPY', 'MXN'].map((String currency) {
//             return DropdownMenuItem(value: currency, child: Text(currency));
//           }).toList(),
//           onChanged: (value) => currencyController.text = value.toString(),
//         ),
//         // Tags input (simple multi-line text input for tags)
//         TextFormField(
//           initialValue: tags.join(', '),
//           cursorColor: Colors.black,
//           decoration: InputDecoration(
//             labelText: 'Tags (comma separated)',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           onChanged: (value) =>
//               tags = value.split(',').map((tag) => tag.trim()).toList(),
//         ),
//       ],
//     );
//   }

//   Widget _buildRegistrationPeriod() {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Registration Period',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: regStartDateController,
//           cursorColor: Colors.black,
//           decoration: InputDecoration(
//             labelText: 'Start Date',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           readOnly: true,
//           onTap: () => _selectDate(context, 0, isStartDate: true),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter start date' : null,
//         ),
//         TextFormField(
//           controller: regEndDateController,
//           cursorColor: Colors.black,
//           decoration: InputDecoration(
//             labelText: 'End Date',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           readOnly: true,
//           onTap: () => _selectDate(context, 0, isEndDate: true),
//           validator: (value) => value!.isEmpty ? 'Please enter end date' : null,
//         ),
//       ],
//     );
//   }

//   Widget _buildEventLocation(ImagePickerProvider provider) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Event Location',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         TextFormField(
//           controller: latitudeController,
//           cursorColor: Colors.black,
//           decoration: InputDecoration(
//             labelText: 'Latitude',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           validator: (value) => value!.isEmpty ? 'Please enter latitude' : null,
//           keyboardType: TextInputType.number,
//         ),
//         TextFormField(
//           controller: longitudeController,
//           cursorColor: Colors.black,
//           decoration: InputDecoration(
//             labelText: 'Longitude',
//             labelStyle: TextStyle(
//               color: Colors.black,
//               fontSize: screenWidth * 0.04,
//               fontFamily: "verdana_regular",
//               fontWeight: FontWeight.w400,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: const BorderSide(color: Colors.black, width: 1.0),
//             ),
//           ),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter longitude' : null,
//           keyboardType: TextInputType.number,
//         ),
//       ],
//     );
//   }

//   Widget _buildImagePicker(ImagePickerProvider provider) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenWidth = mediaQuery.size.width;
//     final screenHeight = mediaQuery.size.height;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Images',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         // Main image picker
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('Main Image'),
//             if (provider.mainEventImage != null)
//               Image.file(
//                 provider.mainEventImage!,
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.cover,
//               ),
//             ElevatedButton(
//               onPressed: () => provider.pickMainEventImage(),
//               child: const Text('Pick Main Image'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         // Cover images picker
//         const Text('Cover Images'),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8.0,
//           runSpacing: 8.0,
//           children: provider.mainEventCoverImages.map((image) {
//             return Stack(
//               children: [
//                 Image.file(
//                   File(image.path),
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//                 Positioned(
//                   right: 0,
//                   child: IconButton(
//                     icon: const Icon(Icons.remove_circle, color: Colors.red),
//                     onPressed: () => provider.removeCoverImage(
//                         provider.mainEventCoverImages.indexOf(image)),
//                   ),
//                 ),
//               ],
//             );
//           }).toList(),
//         ),
//         ElevatedButton(
//           onPressed: () => provider.pickCoverImage(),
//           child: const Text('Pick Cover Images'),
//         ),
//       ],
//     );
//   }

//   Widget _buildSubEvents(ImagePickerProvider provider) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Sub Events',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: subEventControllers.length,
//           itemBuilder: (context, index) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Sub Event ${index + 1}',
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 8),
//                 _buildSubEventFields(index, provider),
//                 const SizedBox(height: 16),
//                 if (index == subEventControllers.length - 1)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton(
//                         onPressed: _addSubEvent,
//                         child: const Text('Add Sub Event'),
//                       ),
//                       if (subEventControllers.length > 1)
//                         ElevatedButton(
//                           onPressed: () => _removeSubEvent(index),
//                           child: const Text('Remove Sub Event'),
//                         ),
//                     ],
//                   ),
//               ],
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildSubEventFields(int index, ImagePickerProvider provider) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         TextFormField(
//           controller: subEventControllers[index]['name'],
//           decoration: const InputDecoration(labelText: 'Sub Event Name'),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter sub event name' : null,
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['description'],
//           decoration: const InputDecoration(labelText: 'Description'),
//           maxLines: 3,
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['video_url'],
//           decoration: const InputDecoration(labelText: 'Video URL'),
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['start_date'],
//           decoration: const InputDecoration(labelText: 'Start Date'),
//           readOnly: true,
//           onTap: () => _selectDate(context, index),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter start date' : null,
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['start_time'],
//           decoration: const InputDecoration(labelText: 'Start Time'),
//           readOnly: true,
//           onTap: () => _selectTime(context, index, 'start_time'),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter start time' : null,
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['end_time'],
//           decoration: const InputDecoration(labelText: 'End Time'),
//           readOnly: true,
//           onTap: () => _selectTime(context, index, 'end_time'),
//           validator: (value) => value!.isEmpty ? 'Please enter end time' : null,
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['host_name'],
//           decoration: const InputDecoration(labelText: 'Host Name'),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter host name' : null,
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['country_code'],
//           decoration: const InputDecoration(labelText: 'Country Code'),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter country code' : null,
//           keyboardType: TextInputType.phone,
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['host_mobile'],
//           decoration: const InputDecoration(labelText: 'Host Mobile'),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter host mobile' : null,
//           keyboardType: TextInputType.phone,
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['host_email'],
//           decoration: const InputDecoration(labelText: 'Host Email'),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter host email' : null,
//           keyboardType: TextInputType.emailAddress,
//         ),
//         DropdownButtonFormField(
//           value: 'normal',
//           decoration: const InputDecoration(labelText: 'Ticket Type'),
//           items: ['normal', 'vip', 'student'].map((String ticketType) {
//             return DropdownMenuItem(value: ticketType, child: Text(ticketType));
//           }).toList(),
//           onChanged: (value) => subEventControllers[index]['ticket_type']!
//               .text = value.toString(),
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['ticket_price'],
//           decoration: const InputDecoration(labelText: 'Ticket Price'),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter ticket price' : null,
//           keyboardType: TextInputType.number,
//         ),
//         TextFormField(
//           controller: subEventControllers[index]['ticket_qty'],
//           decoration: const InputDecoration(labelText: 'Ticket Quantity'),
//           validator: (value) =>
//               value!.isEmpty ? 'Please enter ticket quantity' : null,
//           keyboardType: TextInputType.number,
//         ),
//         const SizedBox(height: 16),
//         // Cover images picker
//         const Text('Cover Images'),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8.0,
//           runSpacing: 8.0,
//           children: provider.subEventCoverImages.map((image) {
//             return Stack(
//               children: [
//                 Image.file(
//                   File(image.path),
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//                 Positioned(
//                   right: 0,
//                   child: IconButton(
//                     icon: const Icon(Icons.remove_circle, color: Colors.red),
//                     onPressed: () => provider.removeCoverImage(
//                         provider.subEventCoverImages.indexOf(image),
//                         deleteMainEventCoverImage: false),
//                   ),
//                 ),
//               ],
//             );
//           }).toList(),
//         ),
//         ElevatedButton(
//           onPressed: () =>
//               provider.pickCoverImage(isMainEventCoverImages: false),
//           child: const Text('Pick Cover Images'),
//         ),
//       ],
//     );
//   }

//   void _removeSubEvent(int index) {
//     setState(() {
//       if (subEventControllers.length > 1) {
//         subEventControllers.removeAt(index);
//       }
//     });
//   }

//   Widget _buildSubmitButton(ImagePickerProvider provider) {
//     return Center(
//       child: ElevatedButton(
//         onPressed: () {
//           if (_formKey.currentState!.validate()) {
//             List<Map<String, dynamic>> subEvents = [];
//             for (var subEvent in subEventControllers) {
//               subEvents.add({
//                 "name": subEvent['name']!.text,
//                 "description": subEvent['description']!.text,
//                 "video_url": subEvent['video_url']!.text,
//                 "start_date": subEvent['start_date']!.text,
//                 "start_time": subEvent['start_time']!.text,
//                 "end_time": subEvent['end_time']!.text,
//                 "host_name": subEvent['host_name']!.text,
//                 "country_code": subEvent['country_code']!.text,
//                 "host_mobile": subEvent['host_mobile']!.text,
//                 "host_email": subEvent['host_email']!.text,
//                 "ticket_type": subEvent['ticket_type']!.text,
//                 "ticket_price": double.parse(subEvent['ticket_price']!.text),
//                 "ticket_qty": int.parse(subEvent['ticket_qty']!.text),
//                 "sub-event-img": provider.subEventCoverImages
//                     .map((image) => image.path)
//                     .toList()
//               });
//             }

//             Map<String, dynamic> eventData = {
//               "name": nameController.text,
//               "location": locationController.text,
//               "description": descriptionController.text,
//               "reg_start_date": regStartDateController.text,
//               "reg_end_date": regEndDateController.text,
//               "latitude": latitudeController.text,
//               "longitude": longitudeController.text,
//               "category": categoryController.text,
//               "tags": tags,
//               "audience_type": audienceTypeController.text,
//               "multi_tickets": multiTickets,
//               "currency": currencyController.text,
//               "main-img": provider.mainEventImage?.path ?? '',
//               "cover-img": provider.mainEventCoverImages
//                   .map((image) => image.path)
//                   .toList(),
//               "sub_events": subEvents,
//             };

//             print(eventData);
//           }
//         },
//         child: const Text('Submit'),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:image_picker/image_picker.dart';
// //
// // class CreateEvent extends StatefulWidget {
// //   const CreateEvent({super.key});
// //
// //   @override
// //   State<CreateEvent> createState() => _CreateEventState();
// // }
// //
// // class _CreateEventState extends State<CreateEvent> {
// //   final TextEditingController _startDateController = TextEditingController();
// //   final TextEditingController _endDateController = TextEditingController();
// //   bool _allowMultipleTickets = false;
// //   bool _allowSingleTicket = false;
// //
// //   Future<void> _selectDate(
// //       BuildContext context, TextEditingController controller) async {
// //     final DateTime? pickedDate = await showDatePicker(
// //       context: context,
// //       initialDate: DateTime.now(),
// //       firstDate: DateTime(2000),
// //       lastDate: DateTime(2101),
// //     );
// //
// //     if (pickedDate != null) {
// //       setState(() {
// //         controller.text =
// //             "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     List<XFile>? _mainImages;
// //     final mediaQuery = MediaQuery.of(context);
// //     final screenWidth = mediaQuery.size.width;
// //     final screenHeight = mediaQuery.size.height;
// //     Future<void> _pickImages() async {
// //       final ImagePicker picker = ImagePicker();
// //       final List<XFile> pickedFiles = await picker.pickMultiImage();
// //       setState(() {
// //         _mainImages = pickedFiles;
// //       });
// //     }
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           "Create Event",
// //           style: TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 30),
// //           child: Column(
// //             children: [
// //               _buildInputField(
// //                 "Event Name",
// //                 "Enter Event Name",
// //                 screenWidth,
// //                 screenHeight,
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               _buildInputField(
// //                 "Description",
// //                 "Enter Description",
// //                 screenWidth,
// //                 screenHeight,
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               _buildDateField(
// //                 "Registration Start Date",
// //                 "Enter Date (yyyy-mm-dd)",
// //                 _startDateController,
// //                 context,
// //                 screenWidth,
// //                 screenHeight,
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               _buildDateField(
// //                 "Registration End Date",
// //                 "Enter Date (yyyy-mm-dd)",
// //                 _endDateController,
// //                 context,
// //                 screenWidth,
// //                 screenHeight,
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               _buildInputField(
// //                 "Event Category",
// //                 "Enter Event Category",
// //                 screenWidth,
// //                 screenHeight,
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               _buildInputField(
// //                 "Event Tags",
// //                 "Enter tags separated by comma(,)",
// //                 screenWidth,
// //                 screenHeight,
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               _buildInputField(
// //                 "Location",
// //                 "Enter Location",
// //                 screenWidth,
// //                 screenHeight,
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: _buildInputField(
// //                       "Latitude",
// //                       "Enter Latitude",
// //                       screenWidth,
// //                       screenHeight,
// //                     ),
// //                   ),
// //                   SizedBox(width: screenWidth * 0.04),
// //                   Expanded(
// //                     child: _buildInputField(
// //                       "Longitude",
// //                       "Enter Longitude",
// //                       screenWidth,
// //                       screenHeight,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               _buildCheckbox(
// //                 "Allow Multiple Tickets",
// //                 _allowMultipleTickets,
// //                 (value) {
// //                   setState(() {
// //                     _allowMultipleTickets = value;
// //                   });
// //                 },
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               Container(
// //                 child: Text(
// //                   "Upload Main Image",
// //                   style: const TextStyle(
// //                       fontWeight: FontWeight.bold, fontSize: 16),
// //                 ),
// //               ),
// //               ElevatedButton.icon(
// //                 onPressed: _pickImages,
// //                 icon: const Icon(Icons.image),
// //                 label: const Text("Upload  Image"),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: const Color(0xFF46BCC3),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(15),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               Container(
// //                 child: Text(
// //                   "Upload Cover Image",
// //                   style: const TextStyle(
// //                       fontWeight: FontWeight.bold, fontSize: 16),
// //                 ),
// //               ),
// //               ElevatedButton.icon(
// //                 onPressed: _pickImages,
// //                 icon: const Icon(Icons.image),
// //                 label: const Text("Upload Cover Images"),
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: const Color(0xFF46BCC3),
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(15),
// //                   ),
// //                 ),
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //               Row(
// //                 children: [
// //                   ElevatedButton(
// //                       onPressed: () {},
// //                       child: Text("Add Sub Event"),
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: const Color(0xFF138F4D),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(15),
// //                         ),
// //                       )),
// //                   Spacer(),
// //                   ElevatedButton(
// //                       onPressed: () {},
// //                       child: Text("Submit"),
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Color(0xFFF21A1A),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(15),
// //                         ),
// //                       ))
// //                 ],
// //               ),
// //               SizedBox(height: screenHeight * 0.02),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildInputField(String label, String placeholder, double screenWidth,
// //       double screenHeight) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           label,
// //           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //         ),
// //         SizedBox(height: screenHeight * 0.01),
// //         TextFormField(
// //           cursorColor: Colors.black,
// //           decoration: InputDecoration(
// //             labelText: placeholder,
// //             labelStyle: TextStyle(
// //               color: Colors.black,
// //               fontSize: screenWidth * 0.04,
// //               fontFamily: "verdana_regular",
// //               fontWeight: FontWeight.w400,
// //             ),
// //             border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(15),
// //               borderSide: const BorderSide(color: Colors.black),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(15),
// //               borderSide: const BorderSide(color: Colors.black, width: 1.0),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildDateField(
// //       String label,
// //       String placeholder,
// //       TextEditingController controller,
// //       BuildContext context,
// //       double screenWidth,
// //       double screenHeight) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           label,
// //           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //         ),
// //         SizedBox(height: screenHeight * 0.01),
// //         GestureDetector(
// //           onTap: () => _selectDate(context, controller),
// //           child: AbsorbPointer(
// //             child: TextFormField(
// //               controller: controller,
// //               cursorColor: Colors.black,
// //               decoration: InputDecoration(
// //                 labelText: placeholder,
// //                 labelStyle: TextStyle(
// //                   color: Colors.black,
// //                   fontSize: screenWidth * 0.04,
// //                   fontFamily: "verdana_regular",
// //                   fontWeight: FontWeight.w400,
// //                 ),
// //                 border: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(15),
// //                   borderSide: const BorderSide(color: Colors.black),
// //                 ),
// //                 focusedBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(15),
// //                   borderSide: const BorderSide(color: Colors.black, width: 1.0),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget _buildCheckbox(String label, bool value, Function(bool) onChanged) {
// //     return Row(
// //       children: [
// //         Checkbox(
// //           value: value,
// //           onChanged: (bool? newValue) {
// //             onChanged(newValue ?? false);
// //           },
// //         ),
// //         Text(
// //           label,
// //           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //         ),
// //       ],
// //     );
// //   }
// // }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer_app/Provider/image_picker_provider.dart';
import 'package:organizer_app/Utils/const_color.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for main event details
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController regStartDateController = TextEditingController();
  TextEditingController regEndDateController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController audienceTypeController = TextEditingController();
  TextEditingController currencyController = TextEditingController();

  bool multiTickets = false;
  List<String> tags = [];

  // List of sub-event controllers
  List<Map<String, TextEditingController>> subEventControllers = [];

  @override
  void initState() {
    super.initState();
    _addSubEvent();
  }

  void _addSubEvent() {
    setState(() {
      subEventControllers.add({
        'name': TextEditingController(),
        'description': TextEditingController(),
        'video_url': TextEditingController(),
        'start_date': TextEditingController(),
        'start_time': TextEditingController(),
        'end_time': TextEditingController(),
        'host_name': TextEditingController(),
        'country_code': TextEditingController(),
        'host_mobile': TextEditingController(),
        'host_email': TextEditingController(),
        'ticket_type': TextEditingController(),
        'ticket_price': TextEditingController(),
        'ticket_qty': TextEditingController(),
      });
    });
  }

  Future<void> _selectDate(BuildContext context, int? index,
      {bool isStartDate = false, bool isEndDate = false}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          regStartDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else if (isEndDate) {
          regEndDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          subEventControllers[index!]['start_date']!.text =
              DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, int index, String timeType) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final formattedTime = picked.format(context);
        if (timeType == 'start_time') {
          subEventControllers[index]['start_time']!.text = formattedTime;
        } else if (timeType == 'end_time') {
          subEventControllers[index]['end_time']!.text = formattedTime;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePickerProvider = Provider.of<ImagePickerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMainEventDetails(),
                const SizedBox(height: 16),
                _buildRegistrationPeriod(),
                const SizedBox(height: 16),
                _buildEventLocation(),
                const SizedBox(height: 16),
                _buildImagePicker(imagePickerProvider),
                const SizedBox(height: 16),
                _buildSubEvents(imagePickerProvider),
                const SizedBox(height: 16),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainEventDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Main Event Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildCurvedTextField(nameController, 'Event Name'),
        _buildCurvedTextField(locationController, 'Location'),
        _buildCurvedTextField(descriptionController, 'Description',
            maxLines: 3),
        _buildCurvedDropdown(categoryController, 'Category', [
          'Symposium',
          'Workshop',
          'Conference',
          'Seminar',
          'Webinar',
          'Hackathon',
          'Meetup',
          'Networking Event',
          'Panel Discussion',
          'Exhibition',
          'Trade Show',
          'Lecture',
          'Round Table',
          'Training Session',
          'Bootcamp',
          'Product Launch',
          'Fundraiser',
          'Award Ceremony',
          'Cultural Event',
          'Sports Event'
        ]),
        _buildCurvedTextField(audienceTypeController, 'Audience Type'),
        CheckboxListTile(
          title: const Text('Allow Multi Tickets'),
          value: multiTickets,
          onChanged: (value) => setState(() => multiTickets = value!),
        ),
        _buildCurvedDropdown(currencyController, 'Currency',
            ['INR', 'USD', 'EUR', 'JPY', 'MXN']),
        _buildCurvedTextField(
          TextEditingController(text: tags.join(', ')),
          'Tags (comma separated)',
          onChanged: (value) =>
              tags = value.split(',').map((tag) => tag.trim()).toList(),
        ),
      ],
    );
  }

  Widget _buildRegistrationPeriod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Registration Period',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildCurvedTextField(
          regStartDateController,
          'Start Date',
          readOnly: true,
          onTap: () => _selectDate(context, 0, isStartDate: true),
        ),
        _buildCurvedTextField(
          regEndDateController,
          'End Date',
          readOnly: true,
          onTap: () => _selectDate(context, 0, isEndDate: true),
        ),
      ],
    );
  }

  Widget _buildEventLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Event Location',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildCurvedTextField(latitudeController, 'Latitude',
            keyboardType: TextInputType.number),
        _buildCurvedTextField(longitudeController, 'Longitude',
            keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildImagePicker(ImagePickerProvider provider) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Images',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        // Display main image if picked
        if (provider.mainEventImage != null)
          Image.file(
            provider.mainEventImage!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          )
        else
          ElevatedButton(
            onPressed: () => provider.pickMainEventImage(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF46BCC3),
              minimumSize: Size(screenWidth * 0.2, screenHeight * 0.06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'Pick Main Image',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        const SizedBox(height: 16),
        // Display cover images if picked
        const Text('Cover Images'),
        const SizedBox(height: 8),
        provider.mainEventCoverImages.isNotEmpty
            ? Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: provider.mainEventCoverImages.map((image) {
                  return Stack(
                    children: [
                      Image.file(
                        File(image.path),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.remove_circle,
                              color: Colors.red),
                          onPressed: () => provider.removeCoverImage(
                              provider.mainEventCoverImages.indexOf(image)),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              )
            : ElevatedButton(
                onPressed: () => provider.pickCoverImage(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF46BCC3),
                  minimumSize: Size(screenWidth * 0.2, screenHeight * 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Pick Cover Images',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildSubEvents(ImagePickerProvider provider) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sub-events',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...List.generate(subEventControllers.length, (index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCurvedTextField(
                      subEventControllers[index]['name']!, 'Sub-event Name'),
                  _buildCurvedTextField(
                      subEventControllers[index]['description']!,
                      'Sub-event Description',
                      maxLines: 3),
                  _buildCurvedTextField(
                      subEventControllers[index]['video_url']!, 'Video URL'),
                  _buildCurvedTextField(
                    subEventControllers[index]['start_date']!,
                    'Start Date',
                    readOnly: true,
                    onTap: () => _selectDate(context, index),
                  ),
                  _buildCurvedTextField(
                    subEventControllers[index]['start_time']!,
                    'Start Time',
                    readOnly: true,
                    onTap: () => _selectTime(context, index, 'start_time'),
                  ),
                  _buildCurvedTextField(
                    subEventControllers[index]['end_time']!,
                    'End Time',
                    readOnly: true,
                    onTap: () => _selectTime(context, index, 'end_time'),
                  ),
                  _buildCurvedTextField(
                      subEventControllers[index]['host_name']!, 'Host Name'),
                  _buildCurvedTextField(
                      subEventControllers[index]['country_code']!,
                      'Country Code'),
                  _buildCurvedTextField(
                      subEventControllers[index]['host_mobile']!,
                      'Host Mobile'),
                  _buildCurvedTextField(
                      subEventControllers[index]['host_email']!, 'Host Email'),
                  _buildCurvedTextField(
                      subEventControllers[index]['ticket_type']!,
                      'Ticket Type'),
                  _buildCurvedTextField(
                      subEventControllers[index]['ticket_price']!,
                      'Ticket Price'),
                  _buildCurvedTextField(
                      subEventControllers[index]['ticket_qty']!,
                      'Ticket Quantity'),
                ],
              ),
            ),
          );
        }),
        ElevatedButton(
          onPressed: _addSubEvent,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF46BCC3),
            minimumSize: Size(screenWidth * 0.2, screenHeight * 0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(
            'Add Sub-event',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurvedTextField(
    TextEditingController controller,
    String hint, {
    int? maxLines,
    bool readOnly = false,
    void Function()? onTap,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines ?? 1,
        readOnly: readOnly,
        onTap: onTap,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }

  Widget _buildCurvedDropdown(
    TextEditingController controller,
    String hint,
    List<String> items,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: controller.text.isEmpty ? null : controller.text,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.text = value ?? '';
          });
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Center(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF46BCC3),
        minimumSize: Size(screenWidth * 0.6, screenHeight * 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          // Handle form submission
        }
      },
      child: const Text(
        'Submit',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ));
  }
}
