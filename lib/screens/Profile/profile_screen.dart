import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organizer_app/PageRouter/page_routes.dart';
import 'package:organizer_app/Screens/Auth/login_screen.dart';
import 'package:organizer_app/Widget/text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/const_color.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  bool _isNameEditable = false;
  bool _isEmailEditable = false;
  bool _isContactEditable = false;

  bool isUserVerified = true;

  final String _photoUrl =
      "https://tse3.mm.bing.net/th?id=OIP.9lp-AzhvWVzYdKMb9E8tLQHaHs&pid=Api&P=0&h=180";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Are you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "No",
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove("accessToken");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                            (Route<dynamic> route) => false);
                      },
                      child: const Text(
                        "Yes",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: const Row(
              children: [
                Text(
                  "logOut",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_photoUrl),
                  ),
                  isUserVerified
                      ? const Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 25,
                        )
                      : const SizedBox(),
                  Positioned(
                    bottom: 4,
                    right: 0,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white.withOpacity(0.7),
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: false,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'ID',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildEditableField('Name', _nameController, _isNameEditable),
            const SizedBox(height: 10),
            _buildEditableField('Email', _emailController, _isEmailEditable),
            const SizedBox(height: 10),
            _buildEditableField(
                'Contact', _contactController, _isContactEditable),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: _updateProfile,
                icon: const Icon(
                  Icons.update,
                  color: Colors.white,
                ),
                label: Text(
                  'Update Profile',
                  style: textStyle(15, Colors.white, FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(
      String label, TextEditingController controller, bool isEditable,
      {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: isEditable,
              maxLines: maxLines,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: label,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              isEditable ? Icons.check : Icons.edit,
              color: isEditable ? Colors.green : Colors.black54,
            ),
            onPressed: () async {
              await _showEditConfirmationDialog(label, context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showEditConfirmationDialog(String field, BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: Text('Do you want to make the $field editable?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  switch (field) {
                    case 'Name':
                      _isNameEditable = !_isNameEditable;
                      break;
                    case 'Email':
                      _isEmailEditable = !_isEmailEditable;
                      break;
                    case 'Contact':
                      _isContactEditable = !_isContactEditable;
                      break;
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _updateProfile() {
    setState(() {
      _isNameEditable = false;
      _isEmailEditable = false;
      _isContactEditable = false;
    });
  }
}
