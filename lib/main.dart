import 'package:flutter/material.dart';
import 'package:video_chat/Screens/HomeScreen.dart';
import 'package:video_chat/Screens/login_screen.dart';
import 'package:video_chat/Utility/colors.dart';
import 'package:video_chat/resource/AuthMethods.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes:{
        '/login' : (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen()
      },
      home:StreamBuilder(
          stream: AuthMethods().authChanges,
          builder: (context,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if(snapshot.hasData){
              return const HomeScreen();
            }
            return const LoginScreen();
          })
    );
  }
}