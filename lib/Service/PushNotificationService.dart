
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {

  final FirebaseMessaging _fcm = FirebaseMessaging();
  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
    print("Enter");
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print(data);
      new PushNotfiy()._showNotificationWithDefaultSound(data['title'],data['Mess']);
      print("call");

    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print(notification);
    }

    // Or do other work.
  }

  Future initialise() async {
    print("Start Service");

    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("Enter");
        print("onMessage112: $message");
        new PushNotfiy()._showNotificationWithDefaultSound(message['data']['title'],message['data']['Mess']);

      },
      onBackgroundMessage:myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}
class  PushNotfiy{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static Future onSelectNot(String playload){
    print("play:"+playload);
  }
   Future _showNotificationWithDefaultSound(title,content) async {
    flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();
    var android=new AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios=new IOSInitializationSettings();
    var initSetting=new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSetting,onSelectNotification: onSelectNot);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      content,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

}

