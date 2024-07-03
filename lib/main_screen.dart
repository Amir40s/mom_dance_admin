import 'package:flutter/material.dart';
import 'package:mom_dance_admin/provider/MenuAppController.dart';
import 'package:mom_dance_admin/responsive.dart';
import 'package:mom_dance_admin/routes/routes.dart';
import 'package:mom_dance_admin/screen/countdown/count_down_screen.dart';
import 'package:mom_dance_admin/screen/garage_owner_screen.dart';
import 'package:mom_dance_admin/screen/user_screen.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';
import 'home_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menuAppController = Provider.of<MenuAppController>(context);
    Widget screen;
    switch (menuAppController.selectedIndex) {
      case Routes.USERS:
        screen = UserScreen();
        break;
      case Routes.GARAGE:
        screen = BannerScreen();
        break;

      case Routes.TIMER:
        screen = SetCountdownScreen();
        break;

      case Routes.USERS:
        screen = HomeScreen();
        break;


      default:
        screen = HomeScreen();
        break;
    }
    return Scaffold(
      extendBody: true,
      key: context.read<MenuAppController>().scaffoldKey,
      drawer:  SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
               Expanded(
                flex: 2,
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 8,
              child: screen,
            ),
          ],
        ),
      ),
    );
  }
}
