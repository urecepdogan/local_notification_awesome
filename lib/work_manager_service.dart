import 'package:notifications_local/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';
// steps
//1.init work manager
//2.excute our task.
//3.register our task in work manager

class WorkManagerService {
  static void registerMyTask() async {
    //register my task
    await Workmanager().registerPeriodicTask(
      'id1',
      'show simple notification',
      frequency: const Duration(seconds: 5),
    );
  }

  //init work manager service
  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: true);
    registerMyTask();
  }

  void cancelTask(String id) {
    Workmanager().cancelAll();
  }
}

@pragma('vm-entry-point')
void actionTask() {
  //show notification
  Workmanager().executeTask((taskName, inputData) {
    LocalNotificationService.bildirimGonder(0);
    return Future.value(true);
  });
}
