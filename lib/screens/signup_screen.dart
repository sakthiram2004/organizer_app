import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_app/PageRouter/page_routes.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscureText = true; // To manage visibility of password
  List<XFile>? _idCardImages; // Store selected images
  XFile? _selectedFile; // Store selected file

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // Toggle visibility
    });
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    setState(() {
      _idCardImages = pickedFiles;
    });
    }

  Future<void> _pickFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.10),
              Text(
                "Sign Up!",
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Welcome Aboard! Sign Up and",
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "Stay Connected!",
                style: TextStyle(fontSize: screenWidth * 0.05),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Input Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
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
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
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
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'College Name',
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
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'College Code',
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
                    ),
                    SizedBox(height: screenHeight * 0.03),
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
                      initialCountryCode: 'IN', // Set initial country code
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Latitude',
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
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Longitude',
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
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    TextFormField(
                      cursorColor: Colors.black,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.04,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: _togglePasswordVisibility,
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
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    ElevatedButton.icon(
                      onPressed: _pickFile,
                      icon: const Icon(Icons.attach_file),
                      label: const Text("Upload Document"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF46BCC3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    ElevatedButton.icon(
                      onPressed: _pickImages,
                      icon: const Icon(Icons.image),
                      label: const Text("Upload ID Card Images"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF46BCC3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(PageRoutes.signupscreen);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF46BCC3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),  
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
