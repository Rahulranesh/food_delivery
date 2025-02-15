import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/components/my_button.dart';
import 'package:food_delivery/components/my_textfield.dart';
import 'package:food_delivery/pages/home_page.dart';
import 'package:food_delivery/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  //log-in
  void login() async {
    final _authService = AuthService();

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Please enter both email and password'),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
      );
      return;
    }

    try {
      await _authService.signInWithEmailPassword(
          emailController.text, passwordController.text);

      // navigate to homepage after successful login
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo
          Icon(
            Icons.lock_open_rounded,
            size: 100,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          SizedBox(
            height: 25,
          ),

          //welcome msg
          Text(
            'Food Delivery App',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          SizedBox(
            height: 25,
          ),

          //email
          MyTextField(
              controller: emailController,
              hintText: 'Enter the email',
              obscureText: false),
          SizedBox(
            height: 10,
          ),

          //password
          MyTextField(
              controller: passwordController,
              hintText: 'Enter the password',
              obscureText: true),
          SizedBox(
            height: 15,
          ),

          //sign-in
          MyButton(onTap: () => login(), text: 'Sign-In'),

          SizedBox(
            height: 25,
          ),

          //register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Not a member ?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  'Register now ',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
