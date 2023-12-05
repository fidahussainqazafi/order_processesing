import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:order_processesing/utils/constant.dart';
import 'package:order_processesing/view/home_screen.dart';
class NewOrderScreen extends StatelessWidget {
   NewOrderScreen({Key? key}) : super(key: key);
   TextEditingController pnController = TextEditingController();
   TextEditingController cnController = TextEditingController();
   TextEditingController ccController = TextEditingController();
   TextEditingController caController = TextEditingController();
   TextEditingController bpController = TextEditingController();
   TextEditingController spController = TextEditingController();
   TextEditingController sdController = TextEditingController();
   User ? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(AppConstant.appName),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: [

              SizedBox(height: 20),
              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(
                  controller: pnController,
                  decoration: InputDecoration(
                      hintText: 'Product Name',
                      labelText: 'Product Name',



                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20),
              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(
                  controller: cnController,
                  decoration: InputDecoration(
                      hintText: 'Client Name',
                      labelText: 'Client Name',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20),
              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(
                  controller: ccController,
                  decoration: InputDecoration(
                      hintText: 'Client Contact',
                      labelText: 'Client Contact',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20),
              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(

                  controller: caController,
                  decoration: InputDecoration(
                      hintText: 'Client Address',
                      labelText: 'Client Address',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20),
              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(

                  controller: bpController,
                  decoration: InputDecoration(
                      hintText: 'Buy Price',
                      labelText: 'Buy Price',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20),
              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(
                  controller: spController,
                  decoration: InputDecoration(
                      hintText: 'Sale Price',
                      labelText: 'Sale Price',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20),
              FadeInLeft(
                duration: Duration(microseconds: 2000),
                child: TextFormField(
                  controller: sdController,
                  decoration: InputDecoration(
                      hintText: 'Sale Date',
                      labelText: 'Sale Date',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(9.0),
                      )
                  ),
                ),
              ),
              ElevatedButton(onPressed: ()async{
                EasyLoading.show();
                var profit = int.parse(spController.text)-int.parse(bpController.text);

                Map<String, dynamic> userOrderMap = {
                  "user Id" : user?.uid,
                  "product Name" : pnController.text.trim(),
                  "client name" : cnController.text.trim(),
                  "client contact": ccController.text.trim(),
                      "client address": caController.text.trim(),
                "Buy price" : bpController.text.trim(),
                    "sale price": spController.text.trim(),
                    "sale date": sdController.text.trim(),
                  "profit" : profit,
                  "status": "pending",
                };

                await FirebaseFirestore.instance.collection("Orders").doc().set(userOrderMap);

                Get.off(()=>HomeScreen());
                EasyLoading.dismiss();
              },
                  child: Text('Create Order')),
            ],
          ),
        ),
      ),
    );

  }
}
