import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/home_screen.dart';
import 'package:shopping_app/signup_screen.dart';

// stateful widget to sign up
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    context.setLocale(const Locale('en', 'US'));
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 204, 218, 225),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 33, 229, 243),
        title: Center(
          // translate to arabic
          child: Text('Login', style: const TextStyle(color: Colors.blueGrey)),
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
                          _signIn(
                              emailController.text, passwordController.text);
                          // firebase sign in function
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Haven't An Account ?"),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ));
                      },
                      child: RichText(
                        text: const TextSpan(
                            text: "Sign UP",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

  // func to sign in by firebase "authentcation"
  void _signIn(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      if (credential.user != null) {
        _showDialog();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login Failed")));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("No user found for that email.")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong password provided for that user.')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message ?? "Unkown ")));
      }
    }
  }

// function to show dialog alert
  Future<void> _showDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Hi"),
              content: const Text("account created successfully"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(_createRoute());
                    },
                    child: const Text("Exit")),
              ],
            ));
  }
}

// function to animate button click to show home screen
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.bounceInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
