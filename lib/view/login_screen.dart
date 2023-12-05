import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:order_processesing/utils/constant.dart';
import 'package:order_processesing/view/forgot_password_screen.dart';
import 'package:order_processesing/view/home_screen.dart';
import 'package:order_processesing/view/signup_screen.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginemailContoller = TextEditingController();

  TextEditingController loginpasswordController = TextEditingController();



 // User ? currentUser = FirebaseAuth.instance.currentUser;

  bool obsecure = false;

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
                  controller: loginemailContoller,
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
                  controller: loginpasswordController,
                  obscureText: obsecure,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                      hintText: 'password',
                      labelText: 'password',

                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                          onTap: (){
                            setState(() {
                              obsecure = !obsecure;
                            });

                          },
                          child:
                          obsecure ? Icon(Icons.visibility_off) : Icon(Icons.visibility) ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      )
                  ),
                ),
              ),
              SizedBox(height: 9),
              GestureDetector(
                onTap:() {
    Get.to(() => ForgotPasswordScreen());
    },
                  child:
                  Container(
                      alignment: Alignment.topRight,
                      child: Text('Forgot Password', style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),)),

                ),
              SizedBox(height: 9),
              FadeInUp(
                duration: Duration(microseconds: 2000),
                child: ElevatedButton(
                    onPressed: () async{

                      var loginEmail = loginemailContoller.text.trim();
                      var loginPassword = loginpasswordController.text.trim();
                      EasyLoading.show();

                      try{
                        final User? firebaseUser = (await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: loginEmail, password: loginPassword)).user;
                      if(firebaseUser != null){
                        Get.to(() =>HomeScreen());
                        EasyLoading.dismiss();
                      }else{

                        print("password is not match");
                        EasyLoading.dismiss();
                      }

                      }on FirebaseAuthException catch(e){
                        print('error $e');
                        EasyLoading.dismiss();
                      }

                    },
                    child: Text('Login'),
                ),
              ),
              SizedBox(height: 9),


                GestureDetector(
                  onTap: (){
                  Get.to(()=>SignUpScreen());
                  },
                  child: Padding(
                      padding: EdgeInsets.all(9.0),
                      child: Text('Dont have account? SignUP',style: TextStyle(fontWeight: FontWeight.bold),)),
                ),


        ],
          ),
        ),
      ),


    );
  }
}
