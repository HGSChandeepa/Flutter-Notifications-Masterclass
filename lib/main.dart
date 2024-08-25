import 'package:f_notification/firebase_options.dart';
import 'package:f_notification/notification/local_notification.dart';
import 'package:f_notification/notification/push_notifications.dart';
import 'package:f_notification/screens/home_page.dart';
import 'package:f_notification/screens/message_opener.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

//navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  //initialize the app
  WidgetsFlutterBinding.ensureInitialized();
  //initialize the notification service (LocalNotificationService)
  await LocalNotificationService.init();
  tz.initializeTimeZones();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //initialize the push notification service (PushNotificationsService)
  await PushNotificationsService.init();

  //listen for incoming messages in background
  FirebaseMessaging.onBackgroundMessage(
      PushNotificationsService.onBackgroundMessage);

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    if (message.notification != null) {
      print("Background Notification Tapped");
      await PushNotificationsService.onBackgroundNotificationTapped(
        message,
        navigatorKey,
      );
    }
  });

  // on foreground notification tapped
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await PushNotificationsService.onForeroundNotificationTapped(
      message,
      navigatorKey,
    );
  });

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }

  //run the app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Notification App',
      routes: {
        '/': (context) => const HomePage(),
        '/message': (context) => const MessageOpener(),
      },
    );
  }
}
