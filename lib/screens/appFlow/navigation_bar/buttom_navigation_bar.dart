import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/screens/appFlow/home/crm_home_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/client_dashboard/client_dashboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/menu.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_dashboard/project_dashboard_screen.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/bottom_nav_controller.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import '../menu/task/task_deshboard/task_deshboard_screen.dart';

class ButtomNavigationBar extends StatefulWidget {
  final int? bottomNavigationIndex;

  const ButtomNavigationBar({Key? key, this.bottomNavigationIndex})
      : super(key: key);

  @override
  State<ButtomNavigationBar> createState() => _ButtomNavigationBarState();
}

class _ButtomNavigationBarState extends State<ButtomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BottomNavController>();
    final PageController myPage =
        PageController(initialPage: widget.bottomNavigationIndex ?? 0);
    DateTime timeBackPressed = DateTime.now();

    return UpgradeAlert(
      upgrader: Upgrader(
        debugLogging: true,
        durationUntilAlertAgain: const Duration(hours: 1),
        countryCode: 'US',
        shouldPopScope: () => true,
      ),
      child: WillPopScope(
        onWillPop: () async {
          final differences = DateTime.now().difference(timeBackPressed);
          timeBackPressed = DateTime.now();
          if (differences >= const Duration(seconds: 2)) {
            String msg = tr("press_the_back_button_to_exit");
            Fluttertoast.showToast(
              msg: msg,
            );
            return false;
          } else {
            Fluttertoast.cancel();
            SystemNavigator.pop();
            return true;
          }
        },
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: Container(
            height: 80.h,
            color: Colors.transparent,
            child: BottomAppBar(
                elevation: 4,
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/home_icon/home.svg',
                        height: provider.currentScreenIndex == 0 ? 22 : 20,
                        color: provider.currentScreenIndex == 0
                            ? AppColors.primaryColor
                            : const Color(0xFF555555),
                      ),
                      onPressed: () {
                        setState(() {
                          myPage.jumpToPage(0);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/home_icon/project_nav_icon.svg',
                          height: provider.currentScreenIndex == 1 ? 22 : 20,
                          color: provider.currentScreenIndex == 1
                              ? AppColors.primaryColor
                              : const Color(0xFF555555),
                        ),
                        onPressed: () {
                          setState(() {
                            myPage.jumpToPage(1);
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: IconButton(
                        icon: SvgPicture.asset(
                          'assets/home_icon/task_navbar.svg',
                          height: provider.currentScreenIndex == 3 ? 22 : 20,
                          color: provider.currentScreenIndex == 3
                              ? AppColors.primaryColor
                              : const Color(0xFF555555),
                        ),
                        onPressed: () {
                          setState(() {
                            myPage.jumpToPage(3);
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/home_icon/clients_navbar.svg',
                        height: provider.currentScreenIndex == 4 ? 22 : 20,
                        color: provider.currentScreenIndex == 4
                            ? AppColors.primaryColor
                            : const Color(0xFF555555),
                      ),
                      onPressed: () {
                        setState(() {
                          myPage.jumpToPage(4);
                        });
                      },
                    ),
                  ],
                )),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.menu),
              onPressed: () {
                setState(() {
                  provider.expended = true;
                  myPage.jumpToPage(2);
                  provider.currentScreenIndex = 2;
                });
              }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: myPage,
            onPageChanged: (index) {
              provider.currentScreenIndex = index;
            },
            children: [
              //NewHomeScreen(),
              //
              //   LeaveSummary(),
              //   MenuScreen(),
              //   PhonebookScreen(),
              //   NotificationScreen(),
              CrmHomeScreen(),
              const ProjectDashboardScreen(),
              MenuScreen(),
              const TaskDashboardScreen(),
              const ClientDashboard()
            ],
          ),
        ),
      ),
    );
  }
}
