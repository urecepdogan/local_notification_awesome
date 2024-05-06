// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:notifications_local/local_notification_service.dart';
import 'package:notifications_local/notifications_controller.dart';

void main() async {
  await LocalNotificationService.init();
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
    Timer? timer;
    int i = 1;
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
                  print(now);
                  if (now.minute % 2 == 0) {
                    LocalNotificationService.bildirimGonder(i);
                    timer = Timer.periodic(
                      const Duration(seconds: 1),
                      (timer) {
                        DateTime now = DateTime.now();
                        Text(now.toString());
                        print(now);
                        if (now.second == 0 && now.minute.isEven) {
                          i++;
                          LocalNotificationService.bildirimGonder(i);
                        }
                      },
                    );
                  } else {
                    timer = Timer.periodic(
                      const Duration(seconds: 1),
                      (timer) {
                        DateTime now = DateTime.now();

                        print(now);
                        if (now.second == 0 && now.minute.isEven) {
                          LocalNotificationService.bildirimGonder(i);
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
                  i = 1;
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
