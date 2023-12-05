import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:order_processesing/view/login_screen.dart';


userSignUp(

String userName,
String userPassword,
String userEmail,
)
async{
User ? userid = FirebaseAuth.instance.currentUser;
try {

  FirebaseFirestore.instance.collection("Order Processing").doc(userid!.uid).set({

  "User Name": userName,
"User Password" : userPassword,
 "User Email" : userEmail,
"User Id" : userid!.uid,

  }).then((value) => {
    FirebaseAuth.instance.signOut(),
    Get.to(()=>LoginScreen())

  });
} on FirebaseAuthException catch(e) {
  print(" print $e");
}
}
