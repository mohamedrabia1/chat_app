import 'package:chat_app/ui/screens/auth/login/login_screen.dart';
import 'package:chat_app/utilits/app_color.dart';
import 'package:chat_app/utilits/dialog_utilts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';


class RegisterScreen extends StatefulWidget {
  static const routeName = "register";


  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userController = TextEditingController();


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
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
          ),
          child: Opacity(
            opacity: _opacity.value,
            child: Container(
              decoration: BoxDecoration(

              ),
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
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(.7),
                      ),
                    ),
                    SizedBox(),
                    // component1(Icons.account_circle_outlined, 'User name...',userController),
                    component1(Icons.email_outlined, 'Email...',emailController),
                    component1(Icons.lock_outline, 'Password...',passwordController),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(onPressed: (){
                            RegisterToFireBase();
                          }, child: Text(" Create Account")
                              ,style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.primaryColor) )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget component1(IconData icon, String hintText,TextEditingController controller) {
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

  void RegisterToFireBase() async {
    try{
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
      hideLoading(context);
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    }on FirebaseAuthException catch(e){
      hideLoading(context);
      if (e.code == 'weak-password') {
        showErrorDialog(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showErrorDialog(context, "The account already exists for that email.");
    }else{
        showErrorDialog(context, e.message
            ?? "Something went wrong. Please try again later!");
      }
    }
  }
}