import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance_admin/helper/button_widget.dart';
import 'package:mom_dance_admin/helper/custom_textfield.dart';
import 'package:mom_dance_admin/screen/countdown/count_down_screen.dart';
import '../constants.dart';
import '../helper/text_widget.dart';
import '../routes/routes.dart';
import 'drawer_list_tile.dart';

class SideMenu extends StatelessWidget {
    SideMenu({
    super.key,
  });

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: gradientColor
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const DrawerHeader(
                // child: Image.asset("assets/images/logo.png"),
                child: Center(
                    child: Text(
                  "Mom Dance",
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
              const Divider(
                thickness: 0.5,
                color: Colors.black,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: TextWidget(text: "Users",size: 14.0,color: Colors.black,isBold: true,)
              ),

              const DrawerListTile(
                index: 1,
                screenIndex: Routes.USERS,
                title: "Users",
                svgSrc: "assets/icons/menu_dashboard.svg",
              ),
              const SizedBox(
                height: defaultDrawerHeadHeight,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: defaultPadding),
                  child: TextWidget(text: "Update Banner",size: 14.0,color: Colors.black,isBold: true,)
              ),
              const SizedBox(
                height: defaultDrawerHeadHeight - 5,
              ),
              const DrawerListTile(
                index: 2,
                screenIndex: Routes.GARAGE,
                title: "Banner",
                svgSrc: "assets/icons/menu_dashboard.svg",
              ),

              //Sale LIST
              const Divider(
                thickness: 0.5,
                color: Colors.black,
              ),

              const SizedBox(
                height: defaultDrawerHeadHeight,
              ),
              InkWell(
                onTap: (){
                  Get.to(SetCountdownScreen());
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: TextWidget(text: "Set Count Down",size: 14.0,color: Colors.white,isBold: true,)
                ),
              ),
              const SizedBox(
                height: defaultDrawerHeadHeight - 5,
              ),

              const SizedBox(
                height: defaultDrawerHeadHeight,
              ),
              InkWell(
                onTap: (){
                  Get.bottomSheet(
                      Container(
                        width: Get.width,
                        color: Colors.white,
                        padding: EdgeInsets.all(10.0),
                   child: Column(
                     children: [
                       TextWidget(text: "Home Banner Text",size: 14.0,color: Colors.black,isBold: true,),
                       SizedBox(height: 30.0,),
                       CustomTextField(hintText: "Enter Text", controller: textController),
                       SizedBox(height: 40.0,),
                       ButtonWidget(text: "Update", onClicked: (){
                         firestore.collection("banner").doc("banners").update(
                             {
                               "text" : textController.text.toString().trim()
                             }).whenComplete((){
                           textController.text = "";
                           Get.snackbar("Updated", "");
                           Navigator.pop(context);
                         });
                       }, width: 300.0, height: 50.0),

                     ],
                   ),
                  ));
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    child: TextWidget(text: "Home Banner Text",size: 14.0,color: Colors.white,isBold: true,)
                ),
              ),
              const SizedBox(
                height: defaultDrawerHeadHeight - 5,
              ),

            ],
          ),
        ),
      ),

    );
  }
}
