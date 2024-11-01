import 'package:flutter/material.dart';
import 'package:video_chat/resource/AuthMethods.dart';
import 'package:video_chat/widgets/custom_button.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'start or join a meeting',
            style:TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38),
            child: Image.asset('assets/images/onboarding.jpg'),
          ),
          CustomButton(text: 'Google Sign In', onPressed: () async {
            bool res = await _authMethods.signInWithGoogle(context);
            if(!res){
              
            }
          },)
        ],
      )
    );
  }
}
