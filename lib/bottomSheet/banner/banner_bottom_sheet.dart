import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mom_dance_admin/provider/image_provider.dart';
import 'package:mom_dance_admin/provider/pick_provider.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../helper/button_loading_widget.dart';
import '../../helper/button_widget.dart';
import '../../helper/text_widget.dart';
import '../../provider/value_provider.dart';
class BannerBottomSheet extends StatelessWidget {

  final String name,keyName;
  BannerBottomSheet({super.key, required this.name, required this.keyName,
   });


   @override
  Widget build(BuildContext context) {
     final imageProvider = Provider.of<PickerProvider>(context,listen: false);
     return Container(
      width: Get.width,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          gradient: gradientColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextWidget(text: "Add $name Banner", size: 16.0,color: Colors.white,),
            SizedBox(height: 20.0,),
            TextWidget(text: "upload Image here", size: 14.0,color: Colors.white,),
            SizedBox(height: 10.0,),
            Consumer<PickerProvider>(
              builder: (context,provider, child){
                return GestureDetector(
                  onTap: (){
                    provider.pickImage();
                  },
                  child: Container(
                    width: Get.width,
                    height: 200.0,
                    padding: EdgeInsets.all(provider.pickedImage !=null ? 5.0 : 30.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        width: 200.0,
                        height: 200.0,
                        color: Colors.grey,
                        child: provider.pickedImage != null ? Image.memory(provider.pickedImage!) :
                        null
                    ),
                  ),
                );
              },
            ),
            // Container(
            //   width: 200.0,
            //   height: 300.0,
            //   child: Consumer<PickerProvider>(
            //       builder: (context, provider, child){
            //         return Column(
            //           children: [
            //             Container(
            //                 width: 200.0,
            //                 height: 200.0,
            //                 color: Colors.grey,
            //                 child: provider.pickedImage != null ? Image.memory(provider.pickedImage!) :
            //                 null
            //             ),
            //             SizedBox(height: 20.0,),
            //             ButtonWidget(text: "Upload", onClicked: (){
            //               provider.pickImage();
            //             }, width: 100.0, height: 50.0,)
            //           ],
            //         );
            //       }
            //   ),
            // ),
            SizedBox(height: 20.0,),


            Consumer<ValueProvider>(
              builder: (context, provider, child){
                return provider.isLoading == false  ?
                ButtonWidget(
                  backgroundColor: Colors.black,
                    text: "Update" , onClicked: () async{
                  provider.setLoading(true);
                  final downloadUrl = await imageProvider.firebaseStorageImage(image: imageProvider.pickedImage!);

                  // await imageProvider.uploadImage();


                 await firestore.collection("banner").doc("banners").update({
                    keyName : downloadUrl.toString()
                  });

                  provider.setLoading(false);
                  Navigator.pop(context);
                 Get.snackbar("Banner Updated", "");
                }, width: Get.width, height: 50.0) :
                ButtonLoadingWidget(
                  backgroundColor: Colors.black,
                    loadingMesasge: "uploading",
                    width: Get.width,
                    height: 50.0
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
