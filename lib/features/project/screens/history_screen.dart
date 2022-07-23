import 'package:flutter/material.dart';
import 'package:pmpconstractions/core/config/theme/theme.dart';
import 'package:pmpconstractions/core/extensions/firebase.dart';
import 'package:pmpconstractions/features/home_screen/screens/widgets/cached_image.dart';
import 'package:pmpconstractions/features/project/models/history.dart';
import 'package:pmpconstractions/features/project/providers/selected_project_provider.dart';
import 'package:pmpconstractions/features/project/screens/back_to_home_screen.dart';
import 'package:pmpconstractions/features/project/services/history_db_service.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  static const String routeName = '/history';
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedProjectProvider>(builder: (context, value, child) {
      return ((value.project!.isOpen &&
                  value.project!.memberIn(context.userUid!)) ||
              value.project!.companyId == context.userUid!)
          ? Scaffold(
              appBar: AppBar(
                title: const Text('History'),
                centerTitle: true,
                elevation: 0.0,
              ),
              body: FutureBuilder<List<History>>(
                future:
                    HistoryDbServices().getHistory(value.project!.projectId!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var histories = snapshot.data!;
                    return ListView.builder(
                        itemCount: histories.length,
                        itemBuilder: (context, i) {
                          var history = histories[i];
                          // print("${history.imageUrl} $i");
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                history.contant,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              leading: CashedImage(
                                imageUrl: history.imageUrl,
                                size: 40,
                                radius: 40,
                              ),
                              trailing: Column(
                                children: [
                                  Text(
                                    history.getDate(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    history.getTime(),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: orange));
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          : const BackToHomeScreen();
    });
  }
}
