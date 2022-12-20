import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/admin.dart';
import '../../Widgets/appbar.dart';
import '../../Widgets/loading.dart';
import '../../services/reception.dart';

class WaitingRoom extends StatelessWidget {
  const WaitingRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Waiting room"),
      body: Container(
        child: Center(
            child: adminCntr.admin != null
                ? GetX<AdminController>(
                init: Get.put<AdminController>(AdminController()),
                builder: (admin) {
                  if (admin.admin!.value.userType != null &&
                      !admin.admin!.value.userType!.pendingAdmin)
                    Reception().userReception();
                  return Text(admin.admin!.value.type == null
                      ? "No data"
                      : "${admin.admin!.value.type}");
                })
                : LoadingWidget()),
      ),
    );
  }
}
