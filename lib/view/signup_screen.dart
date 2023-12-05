import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_processesing/utils/constant.dart';
import 'package:order_processesing/view/login_screen.dart';

import '../model/signup_model.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   TextEditingController emailController = TextEditingController();

   TextEditingController passwordController = TextEditingController();

   TextEditingController usernameController = TextEditingController();

   User ? currentUser = FirebaseAuth.instance.currentUser;

   bool obsecuretxt  = false;

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
              SizedBox(height: 9),

              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      hintText: 'Username',
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      )
                  ),
                ),
              ),
              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(
                  controller: emailController,
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
              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: obsecuretxt,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      hintText: 'password',
                      labelText: 'password',

                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            obsecuretxt = !obsecuretxt;
                          });
                        },
                          child: 
                          
                         obsecuretxt ? Icon(Icons.visibility_off) : Icon(Icons.visibility)),
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
                  onPressed: ()async{
                    var userEmail = emailController.text.trim();
                    var userPassword = passwordController.text.trim();
                    var userName = usernameController.text.trim();
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: userEmail, password: userPassword).then((value) => {

                      userSignUp(
                            userName,
                            userEmail,
                            userPassword,

                          )
                    });


                    Get.to(()=>LoginScreen());
                  },
                  child: Text('SignUp'),
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
