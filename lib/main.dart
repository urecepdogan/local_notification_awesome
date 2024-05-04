import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:notifications_local/notifications_controller.dart';

void main() async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(channelKey: 'channel_repeat2', channelName: 'Repeat Notifications', channelDescription: 'Test'),
  ], channelGroups: [
    NotificationChannelGroup(channelGroupKey: 'channel_repeat_group', channelGroupName: 'Repeat Notifications Group')
  ]);
  bool isAllowedNotification = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowedNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      AwesomeNotifications().createNotification(
                          content: NotificationContent(id: 15, channelKey: 'channel_repeat2', title: 'Deneme', body: 'Deneme Bildirimi'),
                          schedule: NotificationInterval(interval: 60, repeats: true));
                    },
                    child: const Text("Bildirimleri Başlat"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AwesomeNotifications().cancelAll();
                    },
                    child: const Text("Bildirimleri Durdur"),
                  ),
                ],
              ),
            )));
  }
}
