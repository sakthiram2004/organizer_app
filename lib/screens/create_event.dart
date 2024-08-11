import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
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
        title: const Text(
          "Create Event",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
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
              _buildDateField(
                "Registration Start Date",
                "Enter Date (yyyy-mm-dd)",
                _startDateController,
                context,
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildDateField(
                "Registration End Date",
                "Enter Date (yyyy-mm-dd)",
                _endDateController,
                context,
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Event Category",
                "Enter Event Category",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Event Tags",
                "Enter tags separated by comma(,)",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildInputField(
                "Location",
                "Enter Location",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      "Latitude",
                      "Enter Latitude",
                      screenWidth,
                      screenHeight,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: _buildInputField(
                      "Longitude",
                      "Enter Longitude",
                      screenWidth,
                      screenHeight,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              _buildCheckbox(
                "Allow Multiple Tickets",
                _allowMultipleTickets,
                (value) {
                  setState(() {
                    _allowMultipleTickets = value;
                  });
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                child: Text(
                  "Upload Main Image",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.image),
                label: const Text("Upload  Image"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF46BCC3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                child: Text(
                  "Upload Cover Image",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.image),
                label: const Text("Upload Cover Images"),
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
                      child: Text("Add Sub Event"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF138F4D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text("Submit"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF21A1A),
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
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (bool? newValue) {
            onChanged(newValue ?? false);
          },
        ),
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
