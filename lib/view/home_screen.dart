import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_processesing/utils/constant.dart';
import 'package:order_processesing/view/create_new_order_screen.dart';
import 'package:order_processesing/view/login_screen.dart';
class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);


  @override


  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User ? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstant.appName),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(()=>NewOrderScreen());
            },
            child: Container(
              margin: EdgeInsets.only(right: 9.0),
             child: CircleAvatar(
               radius: 20.0,
               child: Icon(Icons.add),

             ),


            ),
          )
        ],
      ),
      drawer: Drawer(

        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(child: Text('Qi'),),
                accountName: Text('Qazafi'),
                accountEmail: Text('qazafi792@gamil.com')),
            ListTile(
              trailing: Icon(Icons.arrow_circle_right),
              title: Text('Home'),
              leading: Icon(Icons.home),

            ),
            ListTile(
              trailing: Icon(Icons.arrow_circle_right),
              title: Text('Add new Order'),
              leading: Icon(Icons.add_business_outlined),

            ),
            ListTile(
              trailing: Icon(Icons.arrow_circle_right),
              title: Text('Info'),
              leading: Icon(Icons.info),

            ),
            Divider(height: 9.0,color: Colors.deepPurple,),
            ListTile(
              trailing: Icon(Icons.arrow_circle_right),
              title: Text('help'),
              leading: Icon(Icons.help),

            ),
            ListTile(
              trailing: Icon(Icons.logout),
              title: Text('Logout'),
              leading: Icon(Icons.add_business_outlined),
              onTap: ()async{
                await FirebaseAuth.instance.signOut();
                Get.offAll(()=> LoginScreen());
              },

            ),

          ],
        ),

      ),
      body:
      Container(
    child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').where('user Id', isEqualTo: user !.uid).snapshots(),

        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (snapshot == null) {
            return Center(child: Text('Error'),);
          }
          if (snapshot != null && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                String status =  snapshot.data!.docs[index]['product Name'];
                  return Card(
                    child: FadeInLeft(
                      child: ListTile(
                        title: Text(snapshot.data!.docs[index]['product Name']),
                        subtitle: status == "pending" ?
                        Text(snapshot.data!.docs[index]['product Name'],
                        style: TextStyle(color: Colors.green))
                        : Text(snapshot.data!.docs[index]['product Name'],
                      style: TextStyle(color: Colors.red)),
                        leading: CircleAvatar(
                          child: Text(
                              index.toString()
                          ),
                        ),
                        trailing: CircleAvatar(
                          child: Icon(Icons.edit),
                        ),
                      ),
                    ),
                  );
                }

            );
          }
          return Container();
        }
        ),

    ));
  }
}
