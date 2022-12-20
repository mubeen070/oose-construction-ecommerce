import 'package:CMRS/Services/ItemServices.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'dart:io' as hp;
import '../../Controller/loading.dart';
import '../../Widgets/appbar.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/custom_text.dart';
import '../../Widgets/dropdowntile.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/snackbar.dart';
import '../../Widgets/text_field.dart';

class AddItemScreen extends StatefulWidget {
  AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
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
    return Stack(
      children: [
        Obx(() {
          return !loading()
              ?  SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: appBar(title: "Add Item",showLogout: false),
              body: Padding(
                padding: EdgeInsets.all(8.sp),
                child: ListView(
                  children: [
                    alignHeadingText("Add Item to CMRS"),
                    SizedBox(
                      height: 2.h,
                    ),
                    alignBodyText(
                        "Smart Renting App"),
                    SizedBox(
                      height: 2.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        _showPickUpOptionDialog(context);
                        String uniqueFileName = DateTime.now()
                            .millisecondsSinceEpoch
                            .toString();
                        Reference referenceRoot =
                        FirebaseStorage.instance.ref().child('images').child(uniqueFileName);

                        if (_pickedImage!.path != null) {
                          await referenceRoot
                              .putFile(hp.File(_pickedImage!.path));
                          imageUrl = await referenceRoot
                              .getDownloadURL();
                        }

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageUrl!=''?NetworkImage("${imageUrl}"):NetworkImage('https://addlogo.imageonline.co/image.jpg')),
                        ),
                        height: 200,
                        width: 200,
                      ),
                    ),
                    textField("Item Id", itemId,),
                    textField("Item Name", name),
                    textField("Description", description,),
                    textField("Quantity", quantity,),
                    textField("Category", category),
                    textField("Price", price,),
                    SizedBox(height: 6.h),
                    SizedBox(height: 1.h),
                    customButton("Register", (){
                      if (formValidation()) {
                        FocusScope.of(context).unfocus();
                        ItemServices().registerItem(name: name.text,itemId: itemId.text,description: description.text,quantity: quantity.text,category: category.text,price: int.parse(price.text),itemPic: imageUrl);
                      }
                    }),
                  ],
                ),
              ),
            ),
          )
              : LoadingWidget();
        }),
        LoadingWidget(),

      ],
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
      _cropImage(picked);
    }
    Get.back();
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

  bool formValidation() {
    if (name.text.isEmpty || quantity.text.isEmpty) {
      alertSnackbar("All fields are required");
      return false;
    } else if (!GetUtils.isNum(quantity.text)) {
      alertSnackbar("Please enter Quantity in numbers");
      return false;
    }  else if (imageUrl=='') {
      alertSnackbar("Please Provide an Image");
      return false;
    }  else
      return true;
  }
}
