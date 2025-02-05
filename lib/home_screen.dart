import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'biometric_auth.dart'; // For fingerprint authentication
import 'location_tracker.dart'; // For location tracking
import 'notification_service.dart'; // For push notifications

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BiometricAuth biometricAuth = BiometricAuth();
  final LocationTracker locationTracker = LocationTracker();
  final NotificationService notificationService = NotificationService();

  String _locationMessage = "Press the button to get your location.";
  String _notificationMessage = "Notifications are not initialized.";

  @override
  void initState() {
    super.initState();
    notificationService.initialize(); // Initialize push notifications
    _notificationMessage = "Push Notifications Initialized!";
  }

  Future<void> _authenticate() async {
    bool isAuthenticated = await biometricAuth.authenticate();
    if (isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication successful!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication failed!")),
      );
    }
  }

  Future<void> _getLocation() async {
    try {
      Position position = await locationTracker.getCurrentLocation();
      setState(() {
        _locationMessage =
        "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
      });
    } catch (e) {
      setState(() {
        _locationMessage = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fingerprint Authentication Button
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text("Authenticate with Fingerprint"),
            ),
            const SizedBox(height: 20),

            // Location Tracking Button
            ElevatedButton(
              onPressed: _getLocation,
              child: const Text("Get Current Location"),
            ),
            const SizedBox(height: 20),
            Text(
              _locationMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Push Notifications Status
            Text(
              _notificationMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}