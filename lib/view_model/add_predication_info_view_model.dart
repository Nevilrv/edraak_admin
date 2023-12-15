import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddPredicationInfoViewModel extends GetxController {
  bool isLoader = false;

  Future<void> addPredicationData(
      date, temperature, rainfall, humidity, cases, diseaseName) async {
    isLoader = true;

    try {
      DocumentReference<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('Predication').add({
        "Average Humidity (%)": "$humidity",
        "Average Rainfall (mm)": "$rainfall",
        "Average Temperature (Â°C)": temperature,
        "cases": "$cases",
        "Date": "$date",
        "Disease name": "$diseaseName",
      });
      isLoader = false;
      update();

      log("DATA   ${data}");
    } catch (e) {
      isLoader = false;
      update();
      print('===e=====>$e');
    }
    isLoader = false;
    update();
  }
}
