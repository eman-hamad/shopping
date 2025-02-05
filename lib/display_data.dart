import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shopping_app/profile_screen.dart';
import 'package:shopping_app/service/firebase_service.dart';

class DisplayData extends StatefulWidget {
  const DisplayData({super.key});

  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  Map<String, dynamic> userData = {};
// get user data from firestore
  Future<void> getUserData() async {
    Map<String, dynamic>? fetchedData = await FirebaseService().getUserData();
    if (fetchedData != null) {
      setState(() {
        userData = fetchedData;
      });
      debugPrint("User: $userData");
    } else {
      debugPrint("No user found");
    }
  }

  final LocalAuthentication auth = LocalAuthentication();
  // Function to authenticate by biometrics , then go to profile screen
  Future<void> authenticateAndOpenProfile() async {
    bool isAuthenticated = false;

    try {
      isAuthenticated = await auth.authenticate(
        localizedReason: 'Authenticate to access your profile',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      debugPrint("authentication Error : $e");
    }

    if (isAuthenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 218, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 229, 243),
        title: const Center(
          // translate to arabic
          child:
              Text("Show Your Data", style: TextStyle(color: Colors.blueGrey)),
        ),
        actions: [
          IconButton(
            // icon to profile page
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: authenticateAndOpenProfile,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userData.isNotEmpty
                  ? userData['name'] ?? 'No Name'
                  : "Loading name",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan),
            ),
            const SizedBox(height: 15),
            Text(
              userData.isNotEmpty ? userData['age'] : "Loading age",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan),
            ),
            const SizedBox(height: 15),
            Text(
              userData.isNotEmpty ? userData['hobby'] : "Loading hobby",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
