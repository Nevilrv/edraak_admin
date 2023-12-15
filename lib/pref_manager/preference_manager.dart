import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  ///MonthNameList
  static List monthName = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  static List<String> diseaseNameList = [
    "Pulmonary Tuberculosis",
    "Influenza",
    "Dengue fever",
  ];
}
