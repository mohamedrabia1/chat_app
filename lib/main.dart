import 'package:chat_app/ui/screens/auth/login/login_screen.dart';
import 'package:chat_app/ui/screens/auth/register/register_screen.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'ui/screens/chat/chat_screen.dart';
import 'utilits/app_theme.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) =>  RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        ChatScreen.routeName: (_) =>ChatScreen(),


      },
      initialRoute:LoginScreen.routeName,


    );
  }
}
