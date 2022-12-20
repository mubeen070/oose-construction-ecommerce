import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'dart:io' as hp;
import '../../../Services/OrderServices.dart';
import '../../../Widgets/appbar.dart';
import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_text.dart';
import '../../../Widgets/dropdowntile.dart';
import '../../../Widgets/loading.dart';
import '../../../Widgets/snackbar.dart';
import '../../../Widgets/text_field.dart';

class Order extends StatefulWidget {
  Order({Key? key,this.from,this.to,this.price,this.days,this.totalItems}) : super(key: key);

  String? from,to;
  int? price,days,totalItems;

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final TextEditingController transcationId = TextEditingController();

  final TextEditingController address = TextEditingController();

  final TextEditingController cnic = TextEditingController();

  final TextEditingController contactNo = TextEditingController();

  CroppedFile? _pickedImage;

  late String imageUrl='';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(title: "Order",showLogout: false),
            body: Padding(
              padding: EdgeInsets.all(8.sp),
              child: ListView(
                children: [
                  alignHeadingText("Please sent money to easypaisa or jazz cash on 03420191001 and give the transaction id below"),
                  SizedBox(
                    height: 2.h,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  textField("Address", address),
                  textField("CNIC", cnic,
                      textInputType: TextInputType.phone),
                  textField("Contact Number", contactNo,
                      textInputType: TextInputType.phone),
                  textField("Enter Transaction Id", transcationId,
                      textInputType: TextInputType.phone),
                  SizedBox(height: 6.h),
                  MaterialButton(
                    color: Colors.black,
                    onPressed: () async {
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
                    child: Text('Give your Cnic picture',style: TextStyle(color: Colors.white),),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 3.5.w),
                      child:
                      alignBodyText(".", boxAlignment: Alignment.centerLeft)),
                  SizedBox(height: 1.h),
                  customButton("Submit", (){
                    if (formValidation()) {
                      FocusScope.of(context).unfocus();
                      OrderServices().registerItem(transactionId: transcationId.text,cnic: cnic.text,itemPic: imageUrl,address: address.text,contactno: contactNo.text,from: widget.from,to: widget.to,totalItems: widget.totalItems,price: widget.price,days: widget.days);
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
        LoadingWidget()
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
    if (address.text.isEmpty || contactNo.text.isEmpty) {
      alertSnackbar("All fields are required");
      return false;
    }else if (address.text.isEmpty) {
      alertSnackbar("Address must be provided");
      return false;
    }
      else if (transcationId.text.isEmpty) {
        alertSnackbar("Transaction id required");
        return false;
    } else if (imageUrl=='') {
      alertSnackbar("Cnic Image is required");
      return false;
    } else
      return true;
  }
}
