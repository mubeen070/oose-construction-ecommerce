import 'package:CMRS/Controller/item.dart';
import 'package:CMRS/Controller/loading.dart';
import 'package:CMRS/Models/ItemsModel.dart';
import 'package:CMRS/Services/ItemServices.dart';
import 'package:CMRS/Widgets/appbar.dart';
import 'package:CMRS/Widgets/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controller/admin.dart';
import '../../Widgets/customBottomSheet!.dart';
import '../../Widgets/customBottomSheet.dart';
import '../../Widgets/snackbar.dart';
import 'dart:io' as h;

import '../../Widgets/warning.dart';
class ItemUpdateScreen extends StatefulWidget {
  ItemUpdateScreen({Key? key,
    required this.index
  }) : super(key: key);
int index;

  @override
  State<ItemUpdateScreen> createState() => _ItemUpdateScreenState();
}

class _ItemUpdateScreenState extends State<ItemUpdateScreen> {
  final TextEditingController quantity = TextEditingController();

  final TextEditingController name = TextEditingController();

  final TextEditingController itemId = TextEditingController();

  final TextEditingController description = TextEditingController();

  final TextEditingController category = TextEditingController();

  final TextEditingController price = TextEditingController();

  CroppedFile? _pickedImage;

  late String imageUrl='';

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.small(
          backgroundColor: Colors.red,
          onPressed: (){
            WarningDialog(
                context: context,
                title:
                "Do You Want To change value this ${itemsCntr.allItems![widget.index].name}",
                onYes: () async {
                  ItemServices().delete(itemsCntr.allItems![widget.index]);
                  Get.back();
                });

          },child: Icon(Icons.delete_forever,color: Colors.white,),),
        
        appBar: appBar(title: "Update Item",showLogout: false),
        body: Stack(
          children: [
            Obx(() {
              return !loading()
                  ?  Column(
                children: [
                  // SizedBox(height: 100.0,),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      imageUrl ='';
                      _showPickUpOptionDialog(
                          context);
                      update();
                    },
                    child: Column(
                      children: [
                        Text("Product Image",style: TextStyle(fontSize: 20.0),),
                        SizedBox(height: 10.0,),
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(2.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '${itemsCntr.allItems![widget.index].profileImageUrl ?? ''}')),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white54,
                    shadowColor: Colors.blue,
                    child: ListTile(
                      title: Text('${itemsCntr.allItems![widget.index].name}'),
                      leading: Text("Product Name:"),
                      onTap: (){
                        buildBottomSheet2(context,name,'name',itemsCntr.allItems![widget.index],itemsCntr.allItems![widget.index].name.toString());
                      },
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white54,
                    shadowColor: Colors.blue,
                    child: ListTile(
                      title: Text('${itemsCntr.allItems![widget.index].description}'),
                      leading: Text("Product Description:"),
                      onTap: (){
                        buildBottomSheet2(context,description,'description',itemsCntr.allItems![widget.index],itemsCntr.allItems![widget.index].description.toString());
                      },
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white54,
                    shadowColor: Colors.blue,
                    child: ListTile(
                      title: Text('${itemsCntr.allItems![widget.index].price}'),
                      leading: Text("Product Price:"),
                      onTap: (){
                        buildBottomSheet(context,price,'price',itemsCntr.allItems![widget.index],itemsCntr.allItems![widget.index].price.toString());
                      },
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white54,
                    shadowColor: Colors.blue,
                    child: ListTile(
                      title: Text('${itemsCntr.allItems![widget.index].quantity}'),
                      leading: Text("Product Quantity:"),
                      onTap: (){
                        buildBottomSheet2(context,quantity,'quantity',itemsCntr.allItems![widget.index],itemsCntr.allItems![widget.index].quantity.toString());
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: Colors.black,
                        onPressed: (){
                          Get.back();
                        },child: Text('Done',style: TextStyle(color: Colors.white),),),
                    ],
                  ),
                  Divider(color: Colors.black,thickness: 1.0,),
                ],
              )
                  : LoadingWidget();
            }),
            LoadingWidget(),
          ],
        ),
      );

  }
  void _showPickUpOptionDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Pick Image from Gallery"),
                onTap: () {
                  _loadPicker(ImageSource.gallery);
                },
              ),
              ListTile(
                title: Text('Take a picture'),
                onTap: () {
                  _loadPicker(ImageSource.camera);
                },
              )
            ],
          ),
        ));
  }

  _loadPicker(ImageSource source) async {
    XFile? picked = await ImagePicker().pickImage(source: source);

    if (picked != null) {
      setState((){
        _cropImage(picked);
      });
      Get.back();
    }
  }

  void _cropImage(XFile picked) async {
    CroppedFile? cropped = (await ImageCropper().cropImage(
        sourcePath: picked.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        aspectRatioPresets: [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio16x9,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.square
        ]));
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
      });

    }
  }
  Future<void> update() async {

    try {
      String uniqueFileName =
      DateTime.now()
          .millisecondsSinceEpoch
          .toString();
      Reference referenceRoot =
      FirebaseStorage.instance
          .ref();
      Reference referenceDirImages =
      referenceRoot
          .child('images');

      Reference
      referenceImageToUpload =
      referenceDirImages
          .child(uniqueFileName);
      if (_pickedImage!.path !=
          null) {
        await referenceImageToUpload
            .putFile(h.File(
            _pickedImage!
                .path));
        imageUrl =
            await referenceImageToUpload
            .getDownloadURL();
        ItemServices()
            .update(
            itemsCntr.allItems![widget.index],
            'profileImageUrl',
            imageUrl)
            .then(()
        {snackbar("Done!", "Successfully Uploaded Profile Picture");loading(false);}).onError((error)
        {alertSnackbar("Error $error");loading(false);});
      }
    } catch (error) {
      LoadingWidget();
    }
  }
}
