import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostAPIDiseasesNameViewModel extends GetxController {
  var data;
  bool loading = false;
  var disNumber;
  var disName;
  Future postApiDate({
    temperature,
    rainfall,
    humidity,
  }) async {
    log("message  $temperature");
    log("message  $rainfall");
    log("message  $humidity");
    loading = true;
    update();
    var body = jsonEncode({
      "avg_temperature": temperature,
      "avg_rainfall": rainfall,
      "avg_humidity": humidity,
    });

    http.Response response = await http.post(
        Uri.parse(
            "http://ec2-51-20-130-33.eu-north-1.compute.amazonaws.com/predict"),
        body: body,
        headers: {'Content-Type': 'application/json'});

    // print('====response====>>>>$response');
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print("RESPONSE  ${response.body}");
      update();
      loading = false;
      update();

      var diseaseNumbers = data["prediction"];

      List valueData = diseaseNumbers!.split('-');
      disNumber = valueData[0];
      disName = valueData[1];

      // log("disNumber   ${disNumber}");
      // log("disName   ${disName}");
      update();
    } else {
      print("RESPONSE  ${response.statusCode}");
      loading = false;
      update();
    }
    return data;
  }
}
