import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mom_dance_admin/bottomSheet/banner/banner_bottom_sheet.dart';
import '../components/header.dart';
import '../constants.dart';
import '../helper/appIcon/app_icons.dart';
import '../helper/button_widget.dart';
import '../helper/custom_textfield.dart';
import '../helper/menu_card.dart';
import '../helper/text_widget.dart';
import 'countdown/count_down_screen.dart';

class BannerScreen extends StatefulWidget {
  BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  String? _token;
  Stream<String>? _tokenStream;

  int? length;



  @override
  Widget build(BuildContext context) {
    //  notificationFunctions();
    return SingleChildScrollView(
      primary: false,
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
         Header(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuCard(
                image: AppIcons.ic_calender,
                title: 'Comp Schedules',
                press: (){
                //  Get.toNamed(RoutesName.dancerScreen);
                  Get.bottomSheet(BannerBottomSheet(name: 'Comp Schedule', keyName: 'compSchedule',));
                },
              ),
              MenuCard(
                image: AppIcons.ic_travel,
                title: 'Travel Details',
                press: () {
                  Get.bottomSheet(BannerBottomSheet(name: 'Travel Details', keyName: 'travelDetails',));
                },
              ),
              MenuCard(
                image: AppIcons.ic_video,
                title: 'Music Library',
                press: () {
                  Get.bottomSheet(BannerBottomSheet(name: 'Music Library', keyName: 'musicLibrary',));
                },
              ),
            ],
          ),

          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuCard(
                image: AppIcons.ic_album,
                title: 'Dance Album',
                press: (){
                  //  Get.toNamed(RoutesName.dancerScreen);
                  Get.bottomSheet(BannerBottomSheet(name: 'Dance Album', keyName: 'danceAlbum',));
                },
              ),
              MenuCard(
                image: AppIcons.ic_calender,
                title: 'Comp Journal',
                press: () {
                  Get.bottomSheet(BannerBottomSheet(name: 'Comp Journal', keyName: 'compJournal',));
                },
              ),
              MenuCard(
                image: AppIcons.ic_video,
                title: 'Costume Checklist',
                press: () {
                  Get.bottomSheet(BannerBottomSheet(name: 'Costume Checklist', keyName: 'costumeChecklist',));
                },
              ),
            ],
          ),

          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuCard(
                image: AppIcons.ic_album,
                title: 'Skill Goals',
                press: (){
                  //  Get.toNamed(RoutesName.dancerScreen);
                  Get.bottomSheet(BannerBottomSheet(name: 'Skill Goals', keyName: 'skillGoals',));
                },
              ),
              MenuCard(
                image: AppIcons.ic_calender,
                title: 'Costume Measurements',
                press: () {
                  Get.bottomSheet(BannerBottomSheet(name: 'Costume Measurements', keyName: 'costumeMeasurements',));
                },
              ),
              MenuCard(
                image: AppIcons.ic_video,
                title: 'Dance Shoes',
                press: () {
                  Get.bottomSheet(BannerBottomSheet(name: 'Dance Shoes', keyName: 'danceShoes',));
                },
              ),
            ],
          ),

          SizedBox(height: 20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MenuCard(
                image: AppIcons.ic_album,
                title: 'Class Schedule',
                press: (){
                  //  Get.toNamed(RoutesName.dancerScreen);
                  Get.bottomSheet(BannerBottomSheet(name: 'Class Schedule', keyName: 'classSchedule',));
                },
              ),
              // MenuCard(
              //   image: AppIcons.ic_calender,
              //   title: 'Countdown',
              //   press: () {
              //    Get.to(SetCountdownScreen());
              //   },
              // ),
              // Container( padding: EdgeInsets.all(35.0),)
            ],
          ),
        ],
      ),
    );
  }

}

