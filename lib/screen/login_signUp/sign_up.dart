import 'package:chatapp/screen/login_signUp/home.dart';
import 'package:chatapp/screen/login_signUp/login.dart';
import 'package:chatapp/screen/login_signUp/services/authentication..dart';
import 'package:chatapp/screen/login_signUp/widget/botton.dart';
import 'package:chatapp/screen/login_signUp/widget/snack.dart';
import 'package:chatapp/screen/login_signUp/widget/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUpUser() async {
    String res = await AuthServices().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    if (res == "success") {
      setState(() {
        isLoading = true;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: height / 2.7,
              child: Image.asset('images/forSignup.jpg'),
            ),
            TextFieldInpute(
                textEditingController: nameController,
                hintText: 'Enter your name',
                icon: Icons.person),
            TextFieldInpute(
                textEditingController: emailController,
                hintText: 'Enter your email',
                icon: Icons.email),
            TextFieldInpute(
                textEditingController: passwordController,
                hintText: 'Enter your password',
                icon: Icons.email),
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forget Password',
                    style: TextStyle(color: Colors.blue),
                  )),
            ),
            MyButton(
              onTab: signUpUser,
              text: 'Sign Up',
              color: Colors.blue,
            ),
            SizedBox(
              height: height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have a account?  ",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text(
                    'Log In',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
