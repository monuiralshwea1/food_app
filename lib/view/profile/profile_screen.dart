import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth/sing_controller.dart';
import 'components/body.dart';

class ProfileScreen extends GetView<SignController> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الملف الشخصي"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => controller.fetchProfile(), // تحديث البيانات
          )
        ],
      ),
      body: Center(
        child: Obx(() {
          if (controller.isLoadingProfile.value) {
            return CircularProgressIndicator(); // عرض اللودينغ
          }
          if (controller.error.value.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "خطأ: ${controller.error.value}",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => controller.fetchProfile(),
                  child: Text("إعادة المحاولة"),
                )
              ],
            );
          }
          if (controller.profile.value == null) {
            return Text("لم يتم العثور على بيانات الملف الشخصي");
          }

          final profile = controller.profile.value!;
          return Card(
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Text(
                    profile.name??'',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    profile.email??'',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(profile.phone ?? "لا يوجد رقم هاتف"),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(profile.address ?? "لم يتم تحديد العنوان"),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}