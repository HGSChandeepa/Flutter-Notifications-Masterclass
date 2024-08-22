import 'package:f_notification/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //initialize the notification service
  await NotificationService.init();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

//Here the MyApp must be a widget

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Notification App'),
        ),
        body: Center(
          child: Column(
            children: [
              // instant notification
              ElevatedButton(
                onPressed: () {
                  //call the showInstantNotification method
                  NotificationService.showInstantNotification(
                    title: 'Notification Title',
                    body: 'Notification Body',
                  );
                },
                child: const Text('Show Notification'),
              ),

              //sheduled notification

              ElevatedButton(
                onPressed: () {
                  //time
                  DateTime duration =
                      DateTime.now().add(const Duration(seconds: 5));

                  NotificationService.scheduleNotification(
                    title: "this is scheduled notification",
                    body: "hello from adomic arts ",
                    scheduledDate: duration,
                  );
                },
                child: const Text('Show Notification'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
