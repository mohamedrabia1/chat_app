
import 'package:chat_app/ui/screens/auth/register/register_screen.dart';
import 'package:chat_app/ui/screens/chat/chat_screen.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:chat_app/utilits/app_color.dart';
import 'package:chat_app/utilits/dialog_utilts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';




class LoginScreen extends StatefulWidget {
  static const routeName = "login";


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
      setState(() {});
    });


    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        elevation: 0,
      ),
      body: SizedBox(
        height: size.height,
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.primaryColor
          ),
          alignment: Alignment.center,
          child: Opacity(
            opacity: _opacity.value,
            child: Container(
              width: size.width * .9,
              height: size.width * 1.1,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 90,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(.7),
                    ),
                  ),
                  SizedBox(),
                  component(Icons.email_outlined, 'Email...',emailController),
                  component(Icons.lock_outline, 'Password...',passwordController),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(onPressed: (){
                          Login();
                        }, child: Text("Login"),
                          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.primaryColor) ),),
                      ],
                    ),
                  ),
                  TextButton(onPressed:(){
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  }
                      , child:Text(" Create a new Account",style: TextStyle(color: Colors.grey),))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget component(
      IconData icon, String hintText, TextEditingController controller) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(

        color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
          TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }

  void Login() async {
    try{
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance.
      signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
      hideLoading(context);
      Navigator.pushReplacementNamed(context,ChatScreen.routeName);
    }on FirebaseAuthException catch(e){
      hideLoading(context);
      if (e.code == 'user-not-found') {
        showErrorDialog(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showErrorDialog(context, 'Wrong password provided for that user.');
      }else{
        showErrorDialog(context, e.message
            ?? "Something went wrong. Please try again later!");
      }
    }
  }
}

