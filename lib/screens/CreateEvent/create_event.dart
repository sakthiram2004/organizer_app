import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer_app/Provider/event_provider.dart';
import 'package:organizer_app/Provider/image_picker_provider.dart';
import 'package:organizer_app/Screens/CreateEvent/HelperWidget/curved_text_field.dart';
import 'package:organizer_app/Screens/CreateEvent/HelperWidget/dropdown_menu.dart';
import 'package:organizer_app/Utils/const_color.dart';
import 'package:organizer_app/Utils/loader.dart';
import 'package:organizer_app/Utils/scaffold_messenger.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  final PageController pageController;

  const CreateEvent({super.key, required this.pageController});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      backgroundColor: tertiaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Center(
            child: Text(
          "Create Event",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
      body: Consumer<ImagePickerProvider>(
        builder: (context, imagePickerProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMainEventDetails(imagePickerProvider),
                    const SizedBox(height: 16),
                    _buildSubEvents(imagePickerProvider),
                    const SizedBox(height: 16),
                    _buildSubmitButton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainEventDetails(ImagePickerProvider imagePickerProvider) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Main Event Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            CurvedTextField(controller: nameController, hint: 'Event Name'),
            CustomDropDownMenu(
                controller: locationController,
                onChanged: (value) {
                  locationController.text = value!;
                },
                hint: "Distric",
                items: const [
                  'Chennai',
                  'Coimbatore',
                  'Cuddalore',
                  'Dharmapuri',
                  'Dindigul',
                  'Erode',
                  'Kanchipuram',
                  'Kanyakumari',
                  'Karur',
                  'Krishnagiri',
                  'Madurai',
                  'Nagapattinam',
                  'Namakkal',
                  'Nilgiris',
                  'Perambalur',
                  'Pudukkottai',
                  'Ramanathapuram',
                  'Salem',
                  'Sivagangai',
                  'Thanjavur',
                  'Theni',
                  'Thiruvallur',
                  'Thiruvarur',
                  'Tiruchirappalli',
                  'Tirunelveli',
                  'Tiruppur',
                  'Vellore',
                  'Villupuram',
                  'Virudhunagar',
                ]),
            CurvedTextField(
                controller: descriptionController,
                hint: 'Description',
                maxLines: 3),
            CustomDropDownMenu(
                controller: categoryController,
                onChanged: (value) {
                  setState(() {
                    categoryController.text = value ?? '';
                  });
                },
                hint: 'Category',
                items: const [
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
            CustomDropDownMenu(
                controller: audienceTypeController,
                onChanged: (value) {
                  audienceTypeController.text = value!;
                },
                hint: 'Audience Type',
                items: const [
                  'General Public',
                  'Students',
                  'Professionals',
                  'Academics',
                  'Families',
                  'Corporates',
                  'Teens',
                  'Seniors',
                  'Artists',
                  'Entrepreneurs',
                  'Tech Enthusiasts',
                  'Health and Wellness',
                  'Music Lovers',
                  'Sports Fans',
                  'Book Readers',
                  'Travelers',
                  'Foodies',
                  'Gamers',
                  'Community Leaders',
                  'Non-profit Organizations',
                ]),
            CheckboxListTile(
              title: const Text('Allow Multi Tickets'),
              value: multiTickets,
              onChanged: (value) => setState(() => multiTickets = value!),
            ),
            CustomDropDownMenu(
                controller: currencyController,
                onChanged: (value) {
                  setState(() {
                    currencyController.text = value ?? '';
                  });
                },
                hint: 'Currency',
                items: const ['INR', 'USD', 'EUR', 'JPY', 'MXN']),
            CurvedTextField(
              controller: TextEditingController(text: tags.join(', ')),
              hint: 'Tags (comma separated)',
              onChanged: (value) =>
                  tags = value.split(',').map((tag) => tag.trim()).toList(),
            ),
            const SizedBox(height: 16),
            _buildRegistrationPeriod(),
            const SizedBox(height: 16),
            _buildEventLocation(),
            const SizedBox(height: 16),
            _buildImagePicker(imagePickerProvider),
          ],
        ),
      ),
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
        CurvedTextField(
          controller: regStartDateController,
          hint: 'Start Date',
          readOnly: true,
          onTap: () => _selectDate(context, 0, isStartDate: true),
        ),
        CurvedTextField(
          controller: regEndDateController,
          hint: 'End Date',
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
        CurvedTextField(
            controller: latitudeController,
            hint: 'Latitude',
            keyboardType: TextInputType.number),
        CurvedTextField(
            controller: longitudeController,
            hint: 'Longitude',
            keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildImagePicker(ImagePickerProvider provider) {
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
          Stack(children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blueGrey, width: 1),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: FileImage(provider.mainEventImage!),
                  )),
            ),
            Positioned(
                right: 0,
                child: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => provider.removeMainImage())),
          ])
        else
          GestureDetector(
            onTap: () => provider.pickMainEventImage(),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blueGrey, width: 1),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.black38, size: 50),
                    Text(
                      'Pick Main Image',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: 16),
        //<----------- Display cover images if picked-------->
        const Text('Cover Images'),
        const SizedBox(height: 8),
        Wrap(spacing: 10.0, runSpacing: 10.0, children: [
          ...provider.mainEventCoverImages.map((image) {
            return Stack(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blueGrey, width: 1),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(image),
                      )),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () => provider.removeCoverImage(
                      0,
                      provider.mainEventCoverImages.indexOf(image),
                    ),
                  ),
                ),
              ],
            );
          }),
          GestureDetector(
            onTap: () => provider.pickCoverImage(0),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blueGrey, width: 1),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.black38, size: 25),
                    Text(
                      'Pick Image',
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ])
      ],
    );
  }

  Widget _buildSubEvents(ImagePickerProvider provider) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Sub-events',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      ...List.generate(subEventControllers.length, (index) {
        if (index >= 0 && index < subEventControllers.length) {
          return Stack(children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 4,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CurvedTextField(
                        controller: subEventControllers[index]['name']!,
                        hint: 'Sub-event Name'),
                    CurvedTextField(
                        controller: subEventControllers[index]['description']!,
                        hint: 'Sub-event Description',
                        maxLines: 3),
                    CurvedTextField(
                        controller: subEventControllers[index]['video_url']!,
                        hint: 'Video URL'),
                    CurvedTextField(
                      controller: subEventControllers[index]['start_date']!,
                      hint: 'Start Date',
                      readOnly: true,
                      onTap: () => _selectDate(context, index),
                    ),
                    CurvedTextField(
                      controller: subEventControllers[index]['start_time']!,
                      hint: 'Start Time',
                      readOnly: true,
                      onTap: () => _selectTime(context, index, 'start_time'),
                    ),
                    CurvedTextField(
                      controller: subEventControllers[index]['end_time']!,
                      hint: 'End Time',
                      readOnly: true,
                      onTap: () => _selectTime(context, index, 'end_time'),
                    ),
                    CurvedTextField(
                        controller: subEventControllers[index]['host_name']!,
                        hint: 'Host Name'),
                    CurvedTextField(
                        controller: subEventControllers[index]['country_code']!,
                        keyboardType: TextInputType.number,
                        hint: 'Country Code'),
                    CurvedTextField(
                        controller: subEventControllers[index]['host_mobile']!,
                        keyboardType: TextInputType.number,
                        hint: 'Host Mobile'),
                    TextFormField(
                      controller: subEventControllers[index]['host_email']!,
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Host Email',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // CurvedTextField(
                    //     controller: subEventControllers[index]['host_email']!,
                    //     hint: 'Host Email'),
                    CustomDropDownMenu(
                        controller: subEventControllers[index]['ticket_type']!,
                        onChanged: (value) {
                          subEventControllers[index]['ticket_type']!.text =
                              value!;
                        },
                        hint: 'Ticket Type',
                        items: const [
                          'General Admission',
                          'VIP',
                          'Early Bird',
                          'Student',
                          'Senior Citizen',
                          'Group Discount',
                          'Standard',
                          'Premium',
                          'Reserved Seating',
                          'Press Pass',
                        ]),
                    // CurvedTextField(
                    //     controller: subEventControllers[index]['ticket_type']!,
                    //     hint: 'Ticket Type'),
                    CurvedTextField(
                        controller: subEventControllers[index]['ticket_price']!,
                        hint: 'Ticket Price',
                        keyboardType: TextInputType.number),

                    CurvedTextField(
                        controller: subEventControllers[index]['ticket_qty']!,
                        keyboardType: TextInputType.number,
                        hint: 'Ticket Quantity'),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display cover images if picked
                          const Text('Cover Images'),
                          const SizedBox(height: 8),
                          (provider.subEventCoverImages.isNotEmpty &&
                                  provider
                                      .subEventCoverImages[index].isNotEmpty)
                              ? Wrap(
                                  spacing: 10.0,
                                  runSpacing: 10.0,
                                  children: [
                                      ...provider.subEventCoverImages[index]
                                          .map((image) {
                                        return Stack(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.blueGrey,
                                                      width: 1),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(image),
                                                  )),
                                            ),
                                            Positioned(
                                              right: 0,
                                              child: IconButton(
                                                  icon: const Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.red),
                                                  onPressed: () =>
                                                      provider.removeCoverImage(
                                                        index,
                                                        provider
                                                            .subEventCoverImages[
                                                                index]
                                                            .indexOf(image),
                                                        deleteMainEventCoverImage:
                                                            false,
                                                      )),
                                            ),
                                          ],
                                        );
                                      }),
                                      GestureDetector(
                                        onTap: () => provider.pickCoverImage(
                                            index,
                                            isMainEventCoverImages: false),
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1),
                                          ),
                                          child: const Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.add,
                                                    color: Colors.black38,
                                                    size: 25),
                                                Text(
                                                  'Pick Image',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ])
                              : GestureDetector(
                                  onTap: () => provider.pickCoverImage(index,
                                      isMainEventCoverImages: false),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.blueGrey, width: 1),
                                    ),
                                    child: const Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add,
                                              color: Colors.black38, size: 25),
                                          Text(
                                            'Pick Image',
                                            style: TextStyle(
                                              color: Colors.black54,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                        ]),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 6,
              top: 6,
              child: SizedBox(
                height: 40,
                width: 40,
                child: IconButton(
                    icon: const Icon(Icons.close_rounded,
                        size: 25, color: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("sub event removed")),
                      );
                      setState(() {
                        if (subEventControllers.isNotEmpty) {
                          subEventControllers.removeAt(index);
                        }
                      });
                    }),
              ),
            ),
          ]);
        }
        return const SizedBox();
      }),
      ElevatedButton(
        onPressed: () {
          provider.setSubEventImageList();
          _addSubEvent();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF46BCC3),
          minimumSize: Size(screenWidth * 0.4, screenHeight * 0.07),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          'Add Sub-event ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ]);
  }

  Widget _buildSubmitButton() {
    return Center(
        child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF46BCC3),
        minimumSize: Size(MediaQuery.of(context).size.width * 1,
            MediaQuery.of(context).size.height * 0.07),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
//<------- showing alert dialogue when bacground is  process  --------------->
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const Loader();
              });
//<------- bacground process --------------->
          final mainEventData = {
            'name': nameController.text,
            'location': locationController.text,
            'description': descriptionController.text,
            'category': categoryController.text,
            'audienceType': audienceTypeController.text,
            'multiTickets': multiTickets,
            'currency': currencyController.text,
            'tags': tags,
            'regStartDate': regStartDateController.text,
            'regEndDate': regEndDateController.text,
            'latitude': latitudeController.text,
            'longitude': longitudeController.text,
          };

          final subEventsData = subEventControllers.map((subEvent) {
            return {
              'name': subEvent['name']!.text,
              'description': subEvent['description']!.text,
              'video_url': subEvent['video_url']!.text,
              'start_date': subEvent['start_date']!.text,
              'start_time': subEvent['start_time']!.text,
              'end_time': subEvent['end_time']!.text,
              'host_name': subEvent['host_name']!.text,
              'country_code': subEvent['country_code']!.text,
              'host_mobile': subEvent['host_mobile']!.text,
              'host_email': subEvent['host_email']!.text,
              'ticket_type': subEvent['ticket_type']!.text,
              'ticket_price': subEvent['ticket_price']!.text,
              'ticket_qty': subEvent['ticket_qty']!.text,
            };
          }).toList();
          try {
            final imagePickerProvider = context.read<ImagePickerProvider>();
            final eventProvider = context.read<EventProvider>();

            if (imagePickerProvider.mainEventImage != null) {
              final message = await eventProvider.submitEvent(
                imagePickerProvider.mainEventImage!,
                imagePickerProvider.mainEventCoverImages,
                imagePickerProvider.subEventCoverImages,
                mainEventData,
                subEventsData,
              );

              List<String> errorMessages = [
                "Upload required files",
                "Enter all fields",
                "Enter all fields",
                "Internal server error",
              ];

              if (message == "Events and sub events uploaded") {
                if (context.mounted) {
                  showCustomSnackBar(context, message);
                  imagePickerProvider.clearImages();
                }
              } else if (errorMessages.contains(message)) {
                if (context.mounted) {
                  showCustomSnackBar(context, message);
                  widget.pageController.jumpToPage(3);
                }
              }
            } else {
              if (context.mounted) {
                showCustomSnackBar(context, "Please select an image.");
              }
            }
          } catch (e) {
            if (context.mounted) {
              showCustomSnackBar(
                  context, "An error occurred. Please try again.");
            }
          }
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
