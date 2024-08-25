import 'package:f_notification/notification/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                LocalNotificationService.showInstantNotification(
                  title: 'Instant Notification Title',
                  body: 'InstantNotification Body',
                );
              },
              child: const Text('Show instant notification'),
            ),

            //sheduled notification

            ElevatedButton(
              onPressed: () {
                //time
                DateTime duration =
                    DateTime.now().add(const Duration(seconds: 5));

                LocalNotificationService.scheduleNotification(
                  title: "this is scheduled notification",
                  body: "hello from adomic arts ",
                  scheduledDate: duration,
                );
              },
              child: const Text('Show sheduled notification'),
            ),

            // Recurring Notification

            ElevatedButton(
              onPressed: () {
                LocalNotificationService.showRecurringNotification(
                  title: "this is  Recurring notification",
                  body: "hello from adomic arts ",
                  day: Day.monday,
                  time: DateTime.now(),
                );
              },
              child: const Text('Show Recurring Notification'),
            ),

            //Big Picture Notification

            ElevatedButton(
              onPressed: () {
                LocalNotificationService.showBigPictureNotification(
                  title: "this is Big Picture Notification",
                  body: "hello from adomic arts ",
                  imageUrl: "@mipmap/ic_launcher",
                );
              },
              child: const Text('Show  Big Picture Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
