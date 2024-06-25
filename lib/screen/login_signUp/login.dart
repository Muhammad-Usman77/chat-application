import 'package:chatapp/chat/chat_page.dart';
import 'package:chatapp/screen/login_signUp/home.dart';
import 'package:chatapp/screen/login_signUp/services/authentication..dart';
import 'package:chatapp/screen/login_signUp/sign_up.dart';
import 'package:chatapp/screen/login_signUp/widget/botton.dart';
import 'package:chatapp/screen/login_signUp/widget/snack.dart';
import 'package:chatapp/screen/login_signUp/widget/textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();

  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  void loginUsers() async {
    String res = await AuthServices().loginUser(
        email: emailController.text, password: passwordController.text,);

    if (res == "success") {
      setState(() {
        isLoading = true;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ChatPage(name: nameController.text,)));
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
        title: Text('LoginScreen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: height / 2.7,
              child: Image.asset('images/forLogin.jpg'),
            ),
             TextFieldInpute(
             // isPass: true,
                textEditingController: nameController,
                hintText: 'Enter your name',
                icon: Icons.person),
            TextFieldInpute(
                textEditingController: emailController,
                hintText: 'Enter your email',
                icon: Icons.email),
            TextFieldInpute(
              isPass: true,
                textEditingController: passwordController,
                hintText: 'Enter your password',
                icon: Icons.email),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forget Password',
                    style: TextStyle(color: Colors.blue),
                  )),
            ),
            MyButton(
              onTab:loginUsers,
              text: 'Log In',
              color: Colors.blue,
            ),
            SizedBox(
              height: height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an acoount? ",
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    'Sign Up',
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
