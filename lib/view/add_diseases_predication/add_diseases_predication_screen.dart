import 'dart:developer';
import 'package:edraak_admin/pref_manager/preference_manager.dart';
import 'package:edraak_admin/utils/common_snackbar_widget.dart';
import 'package:edraak_admin/utils/common_textfield_widget.dart';
import 'package:edraak_admin/utils/sizebox_services.dart';
import 'package:flutter/material.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:get/get.dart';
import '../../../utils/color_picker.dart';
import '../../../utils/common_button_widget.dart';
import '../../utils/notification_service.dart';
import '../../utils/textstyle_helper.dart';
import '../../view_model/add_predication_info_view_model.dart';
import '../../view_model/get_predication_info_view_model.dart';
import '../../view_model/post_api_diseasesname_view_model.dart';
import '../../view_model/send_notification_view_model.dart';
import '../../view_model/user_data_view_model.dart';

class AddDiseasesPredicationScreen extends StatefulWidget {
  const AddDiseasesPredicationScreen({Key? key}) : super(key: key);

  @override
  State<AddDiseasesPredicationScreen> createState() =>
      _AddDiseasesPredicationScreenState();
}

class _AddDiseasesPredicationScreenState
    extends State<AddDiseasesPredicationScreen> {
  GetPredicationInfoViewModel getPredicationInfoViewModel =
      Get.put(GetPredicationInfoViewModel());

  AddPredicationInfoViewModel addPredicationInfoViewModel =
      Get.put(AddPredicationInfoViewModel());

  SendNotificationViewModel sendNotificationViewModel =
      Get.put(SendNotificationViewModel());

  PostAPIDiseasesNameViewModel postAPIDiseasesNameViewModel =
      Get.put(PostAPIDiseasesNameViewModel());

  UserDataViewModel userDataViewModel = Get.put(UserDataViewModel());

  int? _selectedYear;
  int? selected;
  int? monthIndex;
  bool dataExist = false;
  List fcmTokenList = [];
  List uidList = [];

  TextEditingController temperatureController = TextEditingController();
  TextEditingController rainfallController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  TextEditingController casesController = TextEditingController();
  var diseaseName;

  int? diseSelect;
  @override
  void initState() {
    getPredicationInfoViewModel.getPredicationData();
    userDataViewModel.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edraak',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Text(
              'Add Diseases Prediction',
              style: TextStyleHelper.kBlue90025W500,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorPicker.kGrey200,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
                child: GetBuilder<GetPredicationInfoViewModel>(
                  builder: (controller) {
                    return controller.isLoader == true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const SizedBox(height: 10),
                                  Text("Year Select",
                                      style: TextStyleHelper.kBlack18W600),
                                  const SizedBox(height: 10),
                                  Center(
                                    child: Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: ColorPicker.kWhite,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: DropdownDatePicker(
                                        locale: "en",
                                        isDropdownHideUnderline: true,
                                        isFormValidator: true,
                                        startYear: 2018,
                                        endYear: DateTime.now().year,
                                        width: 10,
                                        selectedYear: _selectedYear,
                                        inputDecoration: const InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          border: InputBorder.none,
                                        ),
                                        onChangedYear: (value) {
                                          _selectedYear = int.parse(value!);
                                          selected = null;
                                          monthIndex = null;
                                          diseaseName = '';
                                          diseSelect = null;
                                          temperatureController.clear();
                                          rainfallController.clear();
                                          humidityController.clear();
                                          casesController.clear();
                                          setState(() {});
                                        },
                                        boxDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: ColorPicker.kPrimaryBlue,
                                              width: 1.0),
                                        ),
                                        showDay: false,
                                        showMonth: false,
                                        hintTextStyle:
                                            TextStyle(color: ColorPicker.kGrey),
                                      ),
                                    ),
                                  ),
                                  SizeBoxService.sH20,
                                  Text("Month Select",
                                      style: TextStyleHelper.kBlack18W600),
                                  SizeBoxService.sH10,
                                  Wrap(
                                    runSpacing: 10,
                                    verticalDirection: VerticalDirection.down,
                                    spacing: 12,
                                    children: List.generate(
                                      12,
                                      (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            selected = null;
                                            monthIndex = null;
                                            diseaseName = '';
                                            diseSelect = null;
                                            temperatureController.clear();
                                            rainfallController.clear();
                                            humidityController.clear();
                                            casesController.clear();

                                            setState(() {});
                                            selected = index;
                                            monthIndex = index + 1;

                                            if (_selectedYear != null) {
                                              for (var data
                                                  in getPredicationInfoViewModel
                                                      .dataList
                                                      .where((element) =>
                                                          element.date ==
                                                          "1-${index + 1}-$_selectedYear")) {
                                                diseaseName = PreferenceManager
                                                    .diseaseNameList
                                                    .elementAt(int.parse(
                                                            '${data.diseaseName}') -
                                                        1);
                                                diseSelect = int.parse(
                                                        '${data.diseaseName}') -
                                                    1;
                                                temperatureController =
                                                    TextEditingController(
                                                        text:
                                                            "${data.averageTemperature}");
                                                rainfallController =
                                                    TextEditingController(
                                                        text:
                                                            "${data.averageRainfall}");
                                                humidityController =
                                                    TextEditingController(
                                                        text:
                                                            "${data.averageHumidity}");
                                                casesController =
                                                    TextEditingController(
                                                        text: "${data.cases}");
                                              }
                                            } else {
                                              CommonSnackBarWidget
                                                  .commonSnackBar(
                                                      'Please Select Year');
                                            }

                                            if (diseSelect != null) {
                                              setState(() {
                                                dataExist = true;
                                              });
                                            } else {
                                              setState(() {
                                                dataExist = false;
                                              });
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: selected == index
                                                  ? ColorPicker.kPrimaryBlue
                                                  : ColorPicker.kWhite,
                                              border: Border.all(
                                                  color:
                                                      ColorPicker.kPrimaryBlue),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7,
                                                      horizontal: 9),
                                              child: Text(
                                                "${PreferenceManager.monthName[index]}",
                                                style: TextStyle(
                                                  color: selected == index
                                                      ? ColorPicker.kWhite
                                                      : ColorPicker.kBlack,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizeBoxService.sH30,
                                  Text("Fill All Field",
                                      style: TextStyleHelper.kBlack18W600),
                                  SizeBoxService.sH10,
                                  CommonTextField().commonTextField(
                                    temperatureController,
                                    "Average Temperature (Â°C)",
                                    keyboardType: TextInputType.number,
                                    readOnly: diseSelect == null ? false : true,
                                  ),
                                  CommonTextField().commonTextField(
                                    rainfallController,
                                    "Average Rainfall (mm)",
                                    keyboardType: TextInputType.number,
                                    readOnly: diseSelect == null ? false : true,
                                  ),
                                  CommonTextField().commonTextField(
                                    humidityController,
                                    "Average Humidity (%)",
                                    keyboardType: TextInputType.number,
                                    readOnly: diseSelect == null ? false : true,
                                  ),
                                  dataExist == false
                                      ? SizeBoxService.sH30
                                      : const SizedBox(),
                                  dataExist == false
                                      ? GetBuilder<AddPredicationInfoViewModel>(
                                          builder: (controllers) {
                                            return CommonButton()
                                                .bSquareRoundBorderPrimaryBlueButton(
                                              context,
                                              title: controllers.isLoader ==
                                                      true
                                                  ? const CircularProgressIndicator()
                                                  : const Text('Submit'),
                                              onTap: () {
                                                if (temperatureController
                                                        .text.isNotEmpty &&
                                                    rainfallController
                                                        .text.isNotEmpty &&
                                                    humidityController
                                                        .text.isNotEmpty) {
                                                  ///Post API

                                                  postAPIDiseasesNameViewModel
                                                      .postApiDate(
                                                    humidity: double.parse(
                                                        humidityController
                                                            .text),
                                                    rainfall: double.parse(
                                                        rainfallController
                                                            .text),
                                                    temperature: double.parse(
                                                        temperatureController
                                                            .text),
                                                  );

                                                  showDialog<void>(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return GetBuilder<
                                                          PostAPIDiseasesNameViewModel>(
                                                        builder:
                                                            (postController) {
                                                          return postAPIDiseasesNameViewModel
                                                                      .loading ==
                                                                  true
                                                              ? const Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                )
                                                              : AlertDialog(
                                                                  title: Text(
                                                                      "${postController.disName}"),
                                                                  content:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        ListBody(
                                                                      children: <Widget>[
                                                                        Text(
                                                                            "Incoming Disease Spread. A new outbreak of ${postController.disName} is expected in ${PreferenceManager.monthName.elementAt(int.parse('$monthIndex') - 1)}. Please take necessary precautions to stay safe."),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      child: const Text(
                                                                          'Add'),
                                                                      onPressed:
                                                                          () {
                                                                        log("1-$monthIndex-$_selectedYear");
                                                                        log("Average Temperature (Â°C)  ${temperatureController.text}");
                                                                        log("Average Rainfall (mm)   ${rainfallController.text}");
                                                                        log("Average Humidity (%)  ${humidityController.text}");
                                                                        log("cases   ${casesController.text}");
                                                                        log("Disease name  ${(int.parse(postController.disNumber))}");

                                                                        ///Send Notifications

                                                                        for (var element
                                                                            in userDataViewModel.userDataList) {
                                                                          uidList
                                                                              .add(element["uid"]);
                                                                          NotificationService.sendMessage(
                                                                              title: "${postController.disName}",
                                                                              msg: "Incoming Disease Spread. A new outbreak of ${postController.disName} is expected in ${PreferenceManager.monthName.elementAt(int.parse('$monthIndex') - 1)}. Please take necessary precautions to stay safe.",
                                                                              receiverFcmToken: element["fcmToken"]);
                                                                        }

                                                                        sendNotificationViewModel
                                                                            .sendNotificationData(
                                                                          "${postController.disName}",
                                                                          "Incoming Disease Spread. A new outbreak of ${postController.disName} is expected in ${PreferenceManager.monthName.elementAt(int.parse('$monthIndex') - 1)}. Please take necessary precautions to stay safe.",
                                                                          DateTime.now()
                                                                              .toUtc(),
                                                                          uidList,
                                                                        );

                                                                        CommonSnackBarWidget.commonSnackBar(
                                                                            'Notification Sent');

                                                                        ///add predication data in firebase
                                                                        controllers
                                                                            .addPredicationData(
                                                                          "1-$monthIndex-$_selectedYear",
                                                                          temperatureController
                                                                              .text,
                                                                          rainfallController
                                                                              .text,
                                                                          humidityController
                                                                              .text,
                                                                          casesController
                                                                              .text,
                                                                          "${(int.parse(postController.disNumber))}",
                                                                        );
                                                                        CommonSnackBarWidget.commonSnackBar(
                                                                            'Data Added');

                                                                        selected =
                                                                            null;
                                                                        monthIndex =
                                                                            null;
                                                                        diseaseName =
                                                                            '';
                                                                        diseSelect =
                                                                            null;
                                                                        temperatureController
                                                                            .clear();
                                                                        rainfallController
                                                                            .clear();
                                                                        humidityController
                                                                            .clear();
                                                                        casesController
                                                                            .clear();

                                                                        setState(
                                                                            () {});

                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                        },
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  CommonSnackBarWidget
                                                      .commonSnackBar(
                                                          'Please Fill All Field');
                                                }
                                              },
                                            );
                                          },
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizeBoxService.sH10,
                                            Text("Select Diseases Name",
                                                style: TextStyleHelper
                                                    .kBlack18W600),
                                            SizeBoxService.sH10,
                                            Wrap(
                                              runSpacing: 12,
                                              verticalDirection:
                                                  VerticalDirection.down,
                                              spacing: 12,
                                              children: List.generate(
                                                3,
                                                (index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {});
                                                      // diseSelect = index;
                                                      diseaseName = index + 1;
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: diseSelect ==
                                                                index
                                                            ? ColorPicker
                                                                .kPrimaryBlue
                                                            : ColorPicker
                                                                .kWhite,
                                                        border: Border.all(
                                                            color: ColorPicker
                                                                .kPrimaryBlue),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 7,
                                                          horizontal: 9,
                                                        ),
                                                        child: Text(
                                                          PreferenceManager
                                                                  .diseaseNameList[
                                                              index],
                                                          style: TextStyle(
                                                            color: diseSelect ==
                                                                    index
                                                                ? ColorPicker
                                                                    .kWhite
                                                                : ColorPicker
                                                                    .kBlack,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                  SizeBoxService.sH30,
                                ],
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
