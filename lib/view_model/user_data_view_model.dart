import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserDataViewModel extends GetxController {
  List<Map<String, dynamic>> userDataList = [];

  bool isLoader = true;

  Future<void> getUserData() async {
    isLoader = true;
    update();
    userDataList.clear();
    try {
      QuerySnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('Users').get();
      data.docs.forEach((element) {
        userDataList.add(element.data() as Map<String, dynamic>);
      });
    } catch (e) {
      print('===e=====>$e');
    }
    isLoader = false;

    update();
  }
}
