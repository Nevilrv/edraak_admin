import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/predication_model.dart';

class GetPredicationInfoViewModel extends GetxController {
  List<PredicationModel> dataList = [];
  bool isLoader = true;

  Future<void> getPredicationData() async {
    isLoader = true;
    update();
    if (dataList.isNotEmpty) {
      dataList.clear();
    }
    try {
      QuerySnapshot<Map<String, dynamic>> data =
          await FirebaseFirestore.instance.collection('Predication').get();

      for (var element in data.docs) {
        PredicationModel model = PredicationModel();
        model.averageHumidity = element.data()["Average Humidity (%)"];
        model.averageRainfall = element.data()["Average Rainfall (mm)"];
        model.averageTemperature = element.data()["Average Temperature (Â°C)"];
        model.cases = element.data()["cases"];
        model.date = element.data()["Date"];
        model.diseaseName = element.data()["Disease name"];

        dataList.add(model);
      }
    } catch (e) {
      print('===e=====>$e');
    }
    isLoader = false;
    update();
  }
}
