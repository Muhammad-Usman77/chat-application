import 'package:chatapp/screen/login_signUp/login.dart';
import 'package:chatapp/screen/login_signUp/services/authentication..dart';
import 'package:chatapp/screen/login_signUp/widget/botton.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Congradulations\n You have successfully login',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
           
            MyButton(
                onTab: () async {
                  await AuthServices().signOUt();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                text: 'Sign Out',
                color: Colors.blue)
          ],
        ),
      ),
    );
  }
}
