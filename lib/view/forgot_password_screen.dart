import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/constant.dart';
import 'login_screen.dart';
class ForgotPasswordScreen extends StatelessWidget {
   ForgotPasswordScreen({Key? key}) : super(key: key);
   TextEditingController forgotController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstant.appName),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: [

              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(
                  controller: forgotController,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      )
                  ),
                ),
              ),


              SizedBox(height: 9),
              FadeInUp(
                duration: Duration(microseconds: 2000),
                child: ElevatedButton(
                  onPressed: () async{


                    var forgotEmail = forgotController.text.trim();
                    try{
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail).then((value) => {
                        print("Email sent"),
                        Get.off(()=> LoginScreen()),
                      });

                    }on FirebaseAuthException catch(e){
                      print('Error $e');
                    }

                  },
                  child: Text('Forgot Password'),
                ),
              ),
              SizedBox(height: 9),



            ],
          ),
        ),
      ),


    );
  }
}
