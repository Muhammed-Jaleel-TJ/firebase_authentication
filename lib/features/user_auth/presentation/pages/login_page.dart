import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_authentication/features/user_auth/firebase_auth_implimentation/firebase_auth_services.dart';
import 'package:flutter_firebase_authentication/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter_firebase_authentication/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_firebase_authentication/features/user_auth/presentation/widgets/form_container_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //The purpose of this FirebaseAuthServices is likely to encapsulate Firebase authentication methods, making it easier to manage user authentication tasks (like sign-in, sign-up, etc.).
  //The _auth variable is initialized with a new instance of FirebaseAuthServices. This means that you can use _auth to call methods defined in that class, such as signing in or signing up users.
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  //TextEditingController is a class provided by Flutter that controls a text input field. It allows you to retrieve the current value, listen for changes, and modify the text programmatically.
  //_emailController&_passwordController: This controller is specifically used for managing the text input related to the user's email,passswords. It allows you to access the text the user enters into the email and password input fields.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  //dispose method is part of the widget lifecycle in Flutter and is called when the widget is removed from the widget tree.
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    // It's important to call super.dispose() to ensure that any cleanup defined in the base class is also performed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 151, 236),
        title: const Text(
          "Login",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              const SizedBox(height: 10),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(height: 30),

              //Login button
              GestureDetector(
                onTap: () {
                  _signIn();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                          (route) => false);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //_signIn retrieves the email and password from the controllers.
  //It calls signInWithEmailAndPassword from the _auth instance to attempt signing in.
  //If successful, it navigates to the HomePage; if not, it logs an error message.
  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    //his line calls the signInWithEmailAndPassword method from the _auth instance of FirebaseAuthServices.
    //User? user: The result of the sign-in attempt is assigned to the variable user. The User? type indicates that the value can either be a User object (if the sign-in is successful) or null (if there’s an error).
    User? user = await _auth.signInWithEmailAndPassword(
      email,
      password,
    );

    if (user != null) {
      print("User is successfully Signed In");
      //find out how to  route like this!!!!
      // Navigator.pushNamed(context, "/home");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      print('Some error happend');
    }
  }
}
