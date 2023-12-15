import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static getFCMToken() async {
    log('hello...');
    try {
      String? token = await messaging.getToken();

      log('token-------------->> ${token}');
      return token;
    } catch (e) {
      log('eeee>> $e');
    }
  }

  static void showMsgHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android;
      log('NOtification Call :${notification?.apple}${notification!.body}${notification.title}${notification.bodyLocKey}${notification.bodyLocKey}');
      // FlutterRingtonePlayer.stop();

      if (message != null) {
        showMsg(notification);
      }
    });
  }

  /// handle notification when app in fore ground..///close app
  static void getInitialMsg() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      log('------RemoteMessage message------$message');
      if (message != null) {
        //  FlutterRingtonePlayer.stop();

        // _singleListingMainTrailController.setSlugName(
        //     slugName: '${message?.data['slug_name']}');
      }
    });
  }

  ///show notification msg
  static void showMsg(RemoteNotification notification) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        'hy',
        'notification.body',
        const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel', // id
              'High Importance Notifications', // title
              //'This channel is used for important notifications.',
              // description
              importance: Importance.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: DarwinNotificationDetails()));
  }

  ///background notification handler..
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    log('Handling a background message ${message.data}');
    RemoteNotification? notification = message.notification;

    // RemoteNotification notification = message.notification ion!;
  }

  ///call when click on notification back
  static void onMsgOpen() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
      log('listen->${message.data}');
      // FlutterRingtonePlayer.stop();

      if (message != null) {
        // print("action======1=== ${message?.data['action_click']}");

        //  FlutterRingtonePlayer.stop();

        // _barViewModel.selectedRoute('DashBoardScreen');
        // _barViewModel.selectedBottomIndex(0);

        // Get.offAll(SplashPage());
      }
    });
  }

  /// send notification device to device
  static Future<bool?> sendMessage({
    String? receiverFcmToken,
    String? msg,
    String? title,
  }) async {
    var serverKey =
        'AAAA-DFMRNU:APA91bEwuRwgJZ_G6qDBhOkMqr9H6fW2iXtDVc8b29YFxFDZeb5wmplaVOkMQ9vPfIty0NBpFou4Ap9isuU7SGHx0E2XPRPi4l9N93raGmh1KHz9XuMXOrt1wK5Pu8QPnf2gwG6AeqQi';
    try {
      // for (String token in receiverFcmToken) {
      log("RESPONSE TOKEN  $receiverFcmToken");

      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': msg ?? 'msg',
              'title': title ?? '',
              'bodyLocKey': 'true'
            },
            'priority': 'high',
            'to': receiverFcmToken,
          },
        ),
      );
      log("RESPONSE CODE ${response.statusCode}");

      log("RESPONSE BODY ${response.body}");
      // return true}
    } catch (e) {
      print("error push notification");
      // return false;
    }
    return null;
  }
}
