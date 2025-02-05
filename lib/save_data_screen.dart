import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shopping_app/display_data.dart';
import 'package:shopping_app/home_screen.dart';
import 'package:shopping_app/profile_screen.dart';
import 'package:shopping_app/service/firebase_service.dart';

// stateful widget to sign up
class SaveDataScreen extends StatefulWidget {
  const SaveDataScreen({super.key});

  @override
  State<SaveDataScreen> createState() => _SaveDataScreenState();
}

class _SaveDataScreenState extends State<SaveDataScreen> {
// controllers to every text form field
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController hobbyController = TextEditingController();

  // key to the form
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    context.setLocale(const Locale('en', 'US'));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 218, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 229, 243),
        title: const Center(
          // translate to arabic
          child: Text("Lets' save your Data",
              style: TextStyle(color: Colors.blueGrey)),
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //form of 4 text fields
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Enter Your Full Name ",
                      prefixIcon: Icon(Icons.abc),
                      labelText: "Full name"),
                  validator: (value) {
                    // validate The first letter to be capitalized
                    var upper = value![0];
                    if (upper.toUpperCase() != value[0]) {
                      return "The first letter should be capitalized";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number, // Numeric Keyboard
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                      hintText: "Enter Your Age ",
                      prefixIcon: Icon(Icons.abc),
                      labelText: "Age"),
                ),
                TextFormField(
                  controller: hobbyController,
                  decoration: const InputDecoration(
                      hintText: "Enter Your Favourite Hobby ",
                      prefixIcon: Icon(Icons.abc),
                      labelText: "Hobby"),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showDialog();
                          // animation function
                        }
                      },
                      child: const Text(
                        "Save Data",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            )),
      ),
    );
  }

// function to show dialog alert
  Future<void> _showDialog() async {
    try {
      FirebaseService().saveUserData({
        'name': nameController.text,
        'age': ageController.text.toString(),
        'hobby': hobbyController.text
      });

      return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text("Hi"),
                content: const Text("Data saved successfully"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(_createRoute());
                      },
                      child: const Text("Exit")),
                ],
              ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

// function to animate button click to show home screen
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const DisplayData(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.bounceInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
