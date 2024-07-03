import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../helper/button_widget.dart';
import '../../helper/custom_textfield.dart';
import '../../helper/text_widget.dart';
import '../../main_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image.asset("assets/images/logo.png",width: 300.0,height: 300.0,fit: BoxFit.cover,),

            TextWidget(text: "Username", color: primaryColor, size: 16.0, isBold: true),
            const SizedBox(height: 10.0,),
            Container(
              width: 300.0,
              child: CustomTextField(
                hintText: 'Username', controller: usernameController,
              ),
            ),
            const SizedBox(height: 10.0,),
            TextWidget(text: "Password", color: primaryColor, size: 16.0, isBold: true),
            const SizedBox(height: 10.0,),
            SizedBox(
              width: 300.0,
              child: CustomTextField(
                hintText: 'Password', controller: passwordController,
              ),
            ),


            const SizedBox(height: 20.0,),
            ButtonWidget(text: "Login", onClicked: (){
              login(context);
            }, width: 300.0, height: 50.0),

          ],
        ),
      ),
    );
  }

  void login(BuildContext context) {
    FirebaseFirestore.instance.collection("admin").doc("login")
        .get().then((value){
          if(value.exists){
            if(usernameController.text == value.data()!['username']
                && passwordController.text == value.data()!['password']){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
            }else{
              Get.snackbar("Login Failed","you enter invalid details");
            }
          }
    });
  }
}
