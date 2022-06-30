import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/featuers/notification/model/notification_model.dart';
import 'package:pmpconstractions/core/featuers/notification/services/notification_db_service.dart';
import 'package:pmpconstractions/features/project/project_details_screen.dart';
import 'package:pmpconstractions/features/tasks/screens/task_details_screen.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = '/notification';
  const NotificationScreen({Key? key}) : super(key: key);

  updateNotification() async {
    await NotificationDbService().makeNotificationAsReaded();
  }

  @override
  Widget build(BuildContext context) {
    updateNotification();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: StreamBuilder<List<NotificationModle>>(
        stream: NotificationDbService().getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<NotificationModle> notifications = snapshot.data!;
            return ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  var notification = notifications[index];
                  return InkWell(
                    onTap: () {
                      if (notification.category == 'task') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TaskDetailsScreen(
                                  taskId: notification.taskId,
                                  projectId: notification.projectId,
                                )));
                        return;
                      }
                      if (notification.category == 'project') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProjectDetailsScreen(
                                  projectId: notification.projectId,
                                )));
                        return;
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: orange),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(notification.imageUrl),
                        ),
                        title: Text(notification.title,
                            style: Theme.of(context).textTheme.headlineMedium),
                        subtitle: Text(
                          notification.body,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        trailing: const AvatarGlow(
                            endRadius: 60.0,
                            glowColor: beg,
                            child: CircleAvatar(
                              radius: 5,
                              backgroundColor: beg,
                            )),
                      ),
                    ),
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }
}
