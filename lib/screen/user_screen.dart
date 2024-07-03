import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/header.dart';
import '../constants.dart';
import '../helper/button_widget.dart';
import '../helper/custom_textfield.dart';
import '../helper/text_widget.dart';

class UserScreen extends StatefulWidget {
  UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
          StreamBuilder(
            stream: firestore
                .collection("users")
               // .where("code", isEqualTo: "1")
              //  .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? const Center(
                child: CircularProgressIndicator(
                  color: hoverColor,
                ),
              )
                  : snapshot.data!.docs.isEmpty
                  ? Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "No Requests Found",
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
              )
                  : Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)),
                child: PaginatedDataTable(
                    header: TextWidget(
                      text:
                      "Total Users: ${snapshot.data!.docs.length}",
                      size: 20,
                      color: Colors.black,
                      isBold: true,
                    ),
                    columnSpacing: 20.0,
                    arrowHeadColor: Colors.black,
                    rowsPerPage: snapshot.data!.docs.length > 10
                        ? 10
                        : snapshot.data!.docs.length,
                    columns:  [
                      DataColumn(
                        label: TextWidget(
                          text: "Date",
                          color: Colors.black,
                          size: 14.0,
                          isBold: true,
                        ),
                      ),
                      DataColumn(
                        label: TextWidget(
                          text: "Name",
                          color: Colors.black,
                          size: 14.0,
                          isBold: true,
                        ),
                      ),
                      DataColumn(
                        label: TextWidget(
                          text: "Email",
                          color: Colors.black,
                          size: 14.0,
                          isBold: true,
                        ),
                      ),
                      DataColumn(
                        label: TextWidget(
                          text: "Password",
                          color: Colors.black,
                          size: 14.0,
                          isBold: true,
                        ),
                      ),

                      DataColumn(
                        label: TextWidget(
                          text: "Action",
                          color: Colors.black,
                          size: 14.0,
                          isBold: true,
                        ),
                      ),
                    ],
                    source: DataTableSourceImpl(
                        category: snapshot.data!.docs,
                        length: snapshot.data!.docs.length,
                        context: context)),
              );
            },
          ),
        ],
      ),
    );
  }

}

class DataTableSourceImpl extends DataTableSource {
  final category;
  final length;
  final context;

  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneCOntroller = TextEditingController();
  var typeController = TextEditingController();

  DataTableSourceImpl(
      {required this.category, required this.length, required this.context});

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          return Colors.white; // Default color
        },
      ),
      cells: [
        DataCell(Row(
          children: [
            Container(
              width: 30,
              height: 30,
              margin: EdgeInsets.only(left: 2, top: 5, bottom: 10),
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(3)),
              child: const Center(child: Icon(Icons.phone)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 5.0, bottom: 5.0, top: 5.0),
              child: TextWidget(
                text: category[index]["date"].toString(),
                color: Colors.black,
                size: 14.0,
                isBold: false,
              ),
            ),
          ],
        )),
        DataCell(
          TextWidget(
            text: category[index]["name"].toString(),
            color: Colors.black,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: category[index]["email"].toString(),
            color: Colors.black,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          TextWidget(
            text: category[index]["password"].toString(),
            color: Colors.black,
            size: 14.0,
            isBold: false,
          ),
        ),
        DataCell(
          Row(
            children: [
              GestureDetector(
                  onTap: (){
                    firestore.collection("users").doc(category[index]["userUID"]).delete();
                  },
                  child: Icon(Icons.delete,color: Colors.red,)),
              SizedBox(width: 10.0,),
              Visibility(
                visible: false,
                child: InkWell(
                    onTap: (){
                      Get.bottomSheet(Container(
                        width: Get.width,
                       padding: EdgeInsets.all(30.0),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.only(
                           topLeft: Radius.circular(20),
                           topRight: Radius.circular(20),
                         ),
                       ),
                        child: Column(
                          children: [
                            CustomTextField(hintText: nameController.text = category[index]["name"], controller: nameController),
                            SizedBox(height: 20.0,),
                            CustomTextField(hintText: emailController.text = category[index]["email"], controller: emailController),
                            SizedBox(height: 20.0,),
                            CustomTextField(hintText: phoneCOntroller.text = category[index]["password"], controller: phoneCOntroller),
                            SizedBox(height: 20.0,),

                            ButtonWidget(text: "Update", onClicked: (){
                              firestore.collection("users").doc(category[index]["userUID"]).update({
                                "name": nameController.text,
                                "email": emailController.text,
                                "password": phoneCOntroller.text,
                              });
                              Get.back();
                            }, width: Get.width, height: 50.0)
                          ],
                        ),
                      ));
                    },
                    child: Icon(Icons.edit,color: Colors.red,)),
              ),
            ],
          )
        ),
      ],
    );
  }

  @override
  int get rowCount => length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
