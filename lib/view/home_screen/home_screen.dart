import 'package:edraak_admin/utils/sizebox_services.dart';
import 'package:edraak_admin/view/send_notifications/send_notifications.dart';
import 'package:flutter/material.dart';
import '../../utils/common_button_widget.dart';
import '../add_diseases_predication/add_diseases_predication_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edraak',
        ),

        /// notifications
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //     },
        //     icon: const Icon(
        //       Icons.notification_important,
        //     ),
        //   ),
        // ],
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CommonButton().bSquareRoundBorderPrimaryBlueButton(
                  context,
                  title: const Text('Predict Disease'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const AddDiseasesPredicationScreen(),
                      ),
                    );
                  },
                ),
                SizeBoxService.sH20,
                CommonButton().bSquareRoundBorderPrimaryBlueButton(
                  context,
                  title: const Text('Notification'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SendNotifications(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
