import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({super.key});

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController startingPointController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedVehicle;

  final List<Map<String, String>> vehicles = [
    {'name': 'Isuzu', 'image': 'assets/images/isuzu.webp'},
    {'name': 'Pickup', 'image': 'assets/images/pickup.webp'},
    {'name': 'Minivan', 'image': 'assets/images/minivan.webp'},
    {'name': 'Crane', 'image': 'assets/images/crane.webp'},
  ];

  Future<void> submitDelivery() async {
    final url = Uri.parse("https://blackdiamondcar.com/api/delivery/request");

    var body = jsonEncode({
      'user_name': fullNameController.text,
      'user_email': emailController.text,
      'user_phone': phoneController.text,
      'starting_point': startingPointController.text,
      'destination': destinationController.text,
      'item_type': 'Car', // You can change or let user select
      'delivery_vehicle': selectedVehicle,
      'item_description': descriptionController.text,
      'pickup_lat': null,
      'pickup_lng': null,
      'dropoff_lat': null,
      'dropoff_lng': null,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      );

      final res = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Delivery request submitted successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        _formKey.currentState!.reset();
        setState(() {
          selectedVehicle = null;
        });
      } else {
        Fluttertoast.showToast(
          msg: res['message'] ?? "Failed to submit delivery request",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Delivery Service"),
        backgroundColor: const Color(0xFFE9D634),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Info
              const Text("Contact Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildTextField(fullNameController, "Full Name"),
              const SizedBox(height: 10),
              _buildTextField(emailController, "Email"),
              const SizedBox(height: 10),
              _buildTextField(phoneController, "Phone"),
              const SizedBox(height: 20),

              // Delivery Info
              const Text("Delivery Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _buildTextField(startingPointController, "Starting Point"),
              const SizedBox(height: 10),
              _buildTextField(destinationController, "Destination"),
              const SizedBox(height: 20),

              // Vehicle Selection
              const Text("Select Delivery Vehicle",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: vehicles.map((vehicle) {
                    bool isSelected = selectedVehicle == vehicle['name'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedVehicle = vehicle['name'];
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(8),
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFE9D634)
                                  : Colors.grey.shade300,
                              width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              vehicle['image']!,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              vehicle['name']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? const Color(0xFFE9D634)
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),

              // Description
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                    labelText: "Message (Optional)",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE9D634),
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        selectedVehicle != null) {
                      await submitDelivery();
                    } else if (selectedVehicle == null) {
                      Fluttertoast.showToast(
                        msg: "Please select a vehicle",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                  },
                  child: const Text(
                    "Submit Delivery Request",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration:
          InputDecoration(labelText: label, border: const OutlineInputBorder()),
      validator: (val) => val == null || val.isEmpty ? "Required" : null,
    );
  }
}
