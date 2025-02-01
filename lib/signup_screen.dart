import 'package:flutter/material.dart';
import 'package:shopping_app/home_screen.dart';
import 'package:shopping_app/save_data_screen.dart';
import 'package:shopping_app/service/firebase_service.dart';

// stateful widget to sign up
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
// controllers to every text form field
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  // key to the form
  final _formKey = GlobalKey<FormState>();
  //two booleans to obsequre password
  bool _obsequre = true;
  bool _obsequreConf = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 218, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 229, 243),
        title: const Center(
          child: Text("Sign Up", style: TextStyle(color: Colors.blueGrey)),
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
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: "Enter Your Email ",
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email"),
                  validator: (value) {
                    if (!value!.contains("@")) {
                      // validate Email contains @
                      return "Your Email should be contain @";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obsequre,
                  decoration: InputDecoration(
                      hintText: "Enter Your Password  ",
                      prefixIcon: const Icon(Icons.password),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _obsequre = !_obsequre;
                            setState(() {});
                          },
                          icon: Icon(_obsequre
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      labelText: "Password"),
                  validator: (value) {
                    if (value!.length < 6) {
                      // validates Password  is more than 6 characters
                      return "Your Password should be more than 6 characters";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmPassController,
                  obscureText: _obsequreConf,
                  decoration: InputDecoration(
                      hintText: "Enter Your Password Again ",
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _obsequreConf = !_obsequreConf;
                            setState(() {});
                          },
                          icon: Icon(_obsequreConf
                              ? Icons.visibility_off
                              : Icons.visibility)),
                      labelText: "Confirm Password"),
                  validator: (value) {
                    if (passwordController.text != value) {
                      // validates this password match Your Password
                      return "This Password doesn't match Your Password";
                    }
                    return null;
                  },
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
                        }
                      },
                      child: const Text(
                        "Sign Up",
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
      FirebaseService().signUp(email: emailController.text, password: passwordController.text);
   
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Hi"),
              content: const Text("account created successfully"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SaveDataScreen()));
                    },
                    child: const Text("Exit"))
              ],
            ));
    }
    catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}