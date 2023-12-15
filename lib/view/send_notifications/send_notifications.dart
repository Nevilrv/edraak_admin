import 'package:edraak_admin/utils/common_snackbar_widget.dart';
import 'package:edraak_admin/utils/notification_service.dart';
import 'package:edraak_admin/utils/sizebox_services.dart';
import 'package:edraak_admin/view_model/send_notification_view_model.dart';
import 'package:edraak_admin/view_model/user_data_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/color_picker.dart';
import '../../utils/common_button_widget.dart';
import '../../utils/common_textfield_widget.dart';
import '../../utils/textstyle_helper.dart';

class SendNotifications extends StatefulWidget {
  const SendNotifications({Key? key}) : super(key: key);

  @override
  State<SendNotifications> createState() => _SendNotificationsState();
}

class _SendNotificationsState extends State<SendNotifications> {
  SendNotificationViewModel sendNotificationViewModel =
      Get.put(SendNotificationViewModel());
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  UserDataViewModel userDataViewModel = Get.put(UserDataViewModel());

  String fcm = "";
  String? uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataViewModel.getUserData();
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
              'Send Notifications',
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
                child: GetBuilder<UserDataViewModel>(
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
                                  SizeBoxService.sH20,
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorPicker.kWhite,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownMenu(
                                      inputDecorationTheme:
                                          InputDecorationTheme(
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: ColorPicker.kPrimaryBlue,
                                              width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: ColorPicker.kPrimaryBlue,
                                              width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: ColorPicker.kPrimaryBlue,
                                              width: 1),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: ColorPicker.kRed,
                                              width: 1),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: ColorPicker.kPrimaryBlue,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      enableSearch: true,
                                      width: 320,
                                      hintText: "Select User",
                                      onSelected: (value) {
                                        List valueData = value!.split('+');
                                        fcm = valueData[0] ?? "";
                                        uid = valueData[1];
                                        // log("VALUE   ${fcm}");
                                        // log("VALUE   ${uid}");
                                      },
                                      dropdownMenuEntries: List.generate(
                                        controller.userDataList.length,
                                        (index) {
                                          return DropdownMenuEntry(
                                              value:
                                                  "${controller.userDataList[index]['fcmToken']}+${controller.userDataList[index]['uid']}",
                                              label:
                                                  "${controller.userDataList[index]['name']}");
                                        },
                                      ),
                                    ),
                                  ),
                                  SizeBoxService.sH05,
                                  CommonTextField().commonTextField(
                                    nameController,
                                    "title",
                                    keyboardType: TextInputType.text,
                                  ),
                                  CommonTextField().commonTextField(
                                    descriptionController,
                                    "description",
                                    maxLine: 5,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                  SizeBoxService.sH50,
                                  GetBuilder<SendNotificationViewModel>(
                                    builder: (controllers) {
                                      return CommonButton()
                                          .bSquareRoundBorderPrimaryBlueButton(
                                        context,
                                        title: controllers.isLoader == true
                                            ? const CircularProgressIndicator()
                                            : const Text('Send'),
                                        onTap: () async {
                                          if (fcm != '') {
                                            if (descriptionController
                                                .text.isNotEmpty) {
                                              NotificationService.sendMessage(
                                                  title: nameController.text,
                                                  msg: descriptionController
                                                      .text,
                                                  receiverFcmToken: fcm);

                                              controllers.sendNotificationData(
                                                nameController.text,
                                                descriptionController.text,
                                                DateTime.now().toUtc(),
                                                uid,
                                              );

                                              CommonSnackBarWidget
                                                  .commonSnackBar(
                                                      'Notification Sent');
                                            } else {
                                              CommonSnackBarWidget
                                                  .commonSnackBar(
                                                      'Please Add Description');
                                            }
                                          } else {
                                            CommonSnackBarWidget.commonSnackBar(
                                                'Please Select User');
                                          }
                                        },
                                      );
                                    },
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
