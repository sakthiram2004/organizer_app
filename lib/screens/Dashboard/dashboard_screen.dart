import 'package:flutter/material.dart';
import 'package:organizer_app/Utils/const_color.dart';
import 'package:organizer_app/Widget/text_style.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: textStyle(22, Colors.white, FontWeight.w600),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            const Text(
              'Hello, Organizer!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),

            // Summary Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard("Pending Events", "12", Colors.orange),
                _buildSummaryCard("Completed Events", "8", Colors.green),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSummaryCard("Booked Count", "120", Colors.purple),
                _buildSummaryCard("Active Events", "5", Colors.blueAccent),
              ],
            ),
            const SizedBox(height: 20),

            // Events Overview
            const Text(
              'Events Overview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildEventOverview(
              eventName: "Music Concert",
              date: "2024-09-15",
              status: "Pending",
              location: "New York",
            ),
            _buildEventOverview(
              eventName: "Art Exhibition",
              date: "2024-10-10",
              status: "Active",
              location: "Los Angeles",
            ),
            _buildEventOverview(
              eventName: "Tech Conference",
              date: "2024-11-20",
              status: "Completed",
              location: "San Francisco",
            ),
            _buildEventOverview(
              eventName: "Music Concert",
              date: "2024-09-15",
              status: "Pending",
              location: "New York",
            ),
            _buildEventOverview(
              eventName: "Art Exhibition",
              date: "2024-10-10",
              status: "Active",
              location: "Los Angeles",
            ),
            _buildEventOverview(
              eventName: "Tech Conference",
              date: "2024-11-20",
              status: "Completed",
              location: "San Francisco",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String count, Color color) {
    return Expanded(
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventOverview({
    required String eventName,
    required String date,
    required String status,
    required String location,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(
          eventName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Date: $date"),
            Text("Location: $location"),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(status),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            status,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Active":
        return Colors.blueAccent;
      case "Completed":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
