import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SubEventScreen extends StatefulWidget {
  const SubEventScreen({super.key});

  @override
  State<SubEventScreen> createState() => _SubEventScreenState();
}

class _SubEventScreenState extends State<SubEventScreen> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  bool _allowMultipleTickets = false;
  bool _allowSingleTicket = false;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        controller.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        controller.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<XFile>? _mainImages;
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    Future<void> _pickImages() async {
      final ImagePicker picker = ImagePicker();
      final List<XFile> pickedFiles = await picker.pickMultiImage();
      setState(() {
        _mainImages = pickedFiles;
      });
    }

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors,
        title: const Text(
          "Sub Event",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(
                "Event Name",
                "Enter Event Name",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Description",
                "Enter Description",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Event Video URL",
                "Enter URL",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildDateField(
                "Start Date",
                "Enter Date (yyyy-mm-dd)",
                _startDateController,
                context,
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTimeField(
                "Start Time",
                "Enter Start Time",
                _startTimeController,
                context,
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildTimeField(
                "End Time",
                "Enter End Time",
                _endTimeController,
                context,
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Event Host Name",
                "Enter Host Name",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Event Host Email",
                "Enter Email",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Enter Host Mobile",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth * 0.04,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 1.0),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Location",
                "Enter Location",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Ticket type",
                "Enter Ticket type",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Ticket price",
                "Enter Ticket price",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Ticket quantity",
                "Enter Ticket quantity",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                child: Text(
                  "Upload  Images",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.image),
                label: const Text("Upload  Images"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF46BCC3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Add Sub Event",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF138F4D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF21A1A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ))
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String placeholder, double screenWidth,
      double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: screenHeight * 0.01),
        TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            labelText: placeholder,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: screenWidth * 0.04,
              fontFamily: "verdana_regular",
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(
      String label,
      String placeholder,
      TextEditingController controller,
      BuildContext context,
      double screenWidth,
      double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: screenHeight * 0.01),
        GestureDetector(
          onTap: () => _selectDate(context, controller),
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: placeholder,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.04,
                  fontFamily: "verdana_regular",
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField(
      String label,
      String placeholder,
      TextEditingController controller,
      BuildContext context,
      double screenWidth,
      double screenHeight) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: screenHeight * 0.01),
        GestureDetector(
          onTap: () => _selectTime(context, controller),
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: placeholder,
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.04,
                  fontFamily: "verdana_regular",
                  fontWeight: FontWeight.w400,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
