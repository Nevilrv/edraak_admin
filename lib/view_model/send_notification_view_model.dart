import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SendNotificationViewModel extends GetxController {
  bool isLoader = false;

  Future<void> sendNotificationData(name, description, dateTime, uid) async {
    isLoader = true;
    update();
    try {
      DocumentReference<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('notification').add({
        "name": "$name",
        "description": "$description",
        "dateTime": dateTime,
        "userList": uid,
      });
      isLoader = false;
      update();

      log("DATA   ${data}");
    } catch (e) {
      isLoader = false;
      update();
      print('===e=====>${e}');
    }
    isLoader = false;
    update();
  }
}
