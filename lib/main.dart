import 'dart:async';

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

  bildirimGonder(int i) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(id: 15, channelKey: 'channel_repeat2', title: '$i. Deneme', body: '$i. Deneme Bildirimi'),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer? timer;
    int i = 0;
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
                  DateTime now = DateTime.now();
                  i = 1;
                  if (now.minute % 2 == 0) {
                    bildirimGonder(i);
                    timer = Timer.periodic(
                      const Duration(minutes: 2),
                      (timer) {
                        bildirimGonder(i);
                        i++;
                      },
                    );
                  } else {
                    timer = Timer.periodic(
                      const Duration(seconds: 1),
                      (timer) {
                        if (now.minute % 2 == 0 && now.second == 1) {
                          bildirimGonder(i);
                          print("bildirim saati $now");
                          i++;
                        }
                      },
                    );
                  }
                },
                child: const Text("Bildirimleri Başlat"),
              ),
              ElevatedButton(
                onPressed: () {
                  timer?.cancel();
                  AwesomeNotifications().cancelAll();
                  i = 0;
                },
                child: const Text("Bildirimleri Durdur"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
