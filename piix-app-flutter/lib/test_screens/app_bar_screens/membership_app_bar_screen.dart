import 'package:flutter/material.dart';
import 'package:piix_mobile/widgets/app_bar/notifications_app_bar.dart';

class NotificationsAppBarScreen extends StatelessWidget {
  static const routeName = '/notifications_app_bar_screen';

  const NotificationsAppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NotificationsAppBar(
          appBarTitle: 'Notifications Count',
          notificationsCount: 4,
          onTap: () {
            ///TODO: Add callback
          }),
      drawer: const Drawer(),
      body: const SingleChildScrollView(),
    );
  }
}
