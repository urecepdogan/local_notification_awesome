import 'package:awesome_notifications/awesome_notifications.dart';

class LocalNotificationService {
  static Future init() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(channelKey: 'channel_repeat2', channelName: 'Repeat Notifications', channelDescription: 'Test'),
    ], channelGroups: [
      NotificationChannelGroup(channelGroupKey: 'channel_repeat_group', channelGroupName: 'Repeat Notifications Group')
    ]);
    bool isAllowedNotification = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowedNotification) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  static bildirimGonder(int i) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 15,
        channelKey: 'channel_repeat2',
        title: '$i. Deneme',
        body: '$i. Deneme Bildirimi',
      ),
    );
  }
}
