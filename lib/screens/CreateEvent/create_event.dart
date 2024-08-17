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
      backgroundColor: tertiaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Create Event"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              padding: const EdgeInsets.all(6.0),
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
