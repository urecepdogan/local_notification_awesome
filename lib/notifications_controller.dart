import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:async';
import 'dart:isolate';

class NotificationController {
  static ReceivePort? receivePort;
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {}

  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {}

  static Future<void> onActionReceivedImplementationMethod(ReceivedAction receivedAction) async {}
}
