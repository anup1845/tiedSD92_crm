import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/model/menu/menu_model.dart';
import 'package:hrm_app/data/server/respository/menu_repository.dart';
import 'package:hrm_app/screens/appFlow/home/break_time/break_time_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/appointment/appointment_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/client_dashboard/client_dashboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/crm_new_account/crm_new_account_dashboard/crm_new_account_dashboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/daily_leave/daily_leave/daily_leave_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/employee/employee_dashboard/employee_dashboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/expense_new/expense_list/expense_list.dart';
import 'package:hrm_app/screens/appFlow/menu/income/income_dashboard/income_dashboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_summary/leave_summary.dart';
import 'package:hrm_app/screens/appFlow/menu/meeting/meeting_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/notice/notice_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/phonebook/phonebook_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_dashboard/project_dashboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/purchase/purchase_list.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sales_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/stock/stock_dsahboard/stock_dashboard.dart';
import 'package:hrm_app/screens/appFlow/menu/support/support_ticket/support_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/support_new/support_dashboard/support_dashboard.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_deshboard/task_deshboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/visit/visit_screen.dart';
import 'package:hrm_app/screens/auth/splash_screen/splash_screen.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/shared_preferences.dart';

import '../../../data/server/respository/repository.dart';
import '../home/attendeance/attendance.dart';
import 'approval/approval.dart';

class MenuProvider extends ChangeNotifier {
  String? userName;
  String? userPhone;
  MenuModel? menuModel;
  List<Datum>? menuList;
  String? profileImage;
  String? attendanceMethod;
  bool? isFaceRegistered;

  MenuProvider() {
    getUserData();
    getMenuList();
    getSettingBase();
  }

  void getUserData() async {
    userName = await SPUtill.getValue(SPUtill.keyName);
    print("...........${userName}");
    profileImage = await SPUtill.getValue(SPUtill.keyProfileImage);
    notifyListeners();
  }

  getMenuList() async {
    final response = await MenuRepository.getAllMenu();
    if (response.httpCode == 200) {
      menuList = response.data!.data!.data;
      // ignore: avoid_print
      menuList?.map((e) => print("icon data= ${e.icon}")).toList();
    }
    notifyListeners();
  }

  getRoutSlag(context, String? name, isFaceRegistered) {
    debugPrint('isFaceRegistered $isFaceRegistered');
    switch (name) {
      case 'Clients':
        return NavUtil.navigateScreen(context, const ClientDashboard());
      case 'Employees':
        return NavUtil.navigateScreen(context, const EmployeeDashboardScreen());
      case 'Income':
        return NavUtil.navigateScreen(context, const IncomeDashboardScreen());

      case 'Projects':
        return NavUtil.navigateScreen(context, const ProjectDashboardScreen());
      case 'Tasks':
        return NavUtil.navigateScreen(context, const TaskDashboardScreen());
      case 'Support':
        return NavUtil.navigateScreen(context, const SupportScreen());
      case 'Attendance':
        // return NavUtil.replaceScreen(
        //     context,
        //     const Attendance(
        //       navigationMenu: false,
        //     ));
        return getAttendanceMethod(context);
      // isFaceRegistered == true
      //   ? NavUtil.navigateScreen(context, const SignIn())
      //   : NavUtil.navigateScreen(context, const SignUp());
      case 'Notice':
        return NavUtil.navigateScreen(context, const NoticeScreen());
      case 'expense':
        // return NavUtil.navigateScreen(context, const ExpanseCategory());
        return NavUtil.navigateScreen(context, const ExpenseList());
      case 'Leave':
        return NavUtil.navigateScreen(context, const LeaveSummary());
      case 'approval':
        return NavUtil.navigateScreen(context, const ApprovalScreen());
      // return NavUtil.navigateScreen(context, const ExpanseCategory());
      case 'Phonebook':
        return NavUtil.navigateScreen(context, const PhonebookScreen());
      case 'Visit':
        return NavUtil.navigateScreen(context, const VisitScreen());
      case 'Sales':
        return NavUtil.navigateScreen(context, const SalesScreen());
      case 'Stock':
        return NavUtil.navigateScreen(context, const StockDashboardScreen());
      case 'Accounts':
        return NavUtil.navigateScreen(context, const CrmNewAccountDashboard());
      case 'Meeting':
        return NavUtil.navigateScreen(context, const MeetingScreen());
      case 'appointments':
        return NavUtil.navigateScreen(context, const AppointmentScreen());
      case 'break':
        return NavUtil.navigateScreen(
            context,
            NavUtil.navigateScreen(
                context,
                const BreakTime(
                  diffTimeHome: '',
                  hourHome: 0,
                  minutesHome: 0,
                  secondsHome: 0,
                )));
      case 'feedback':
        return Fluttertoast.showToast(msg: 'feedback');
      case 'Reports':
        return NavUtil.navigateScreen(context, const PurchaseList());
      case 'daily-leave':
        return NavUtil.navigateScreen(context, const DailyLeave());
      default:
        return debugPrint('default');
    }
  }

  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      ///check user register their face or not
      ///if not then go to face register page
      attendanceMethod = apiResponse.data?.data?.attendanceMethod;
      isFaceRegistered = apiResponse.data?.data?.isFaceRegistered;
      debugPrint('attendance method: $attendanceMethod');
      notifyListeners();
    }
  }

  /// FACE_RECOGNITION='FR';
  /// BARCODE='QR';
  /// NORMAL = 'N';
  void getAttendanceMethod(context) {
    switch (attendanceMethod) {
      case 'FR':
        //TODO: face
        // isFaceRegistered == true
        //     ? NavUtil.navigateScreen(context, const SignIn())
        //     : NavUtil.navigateScreen(context, const SignUp());
        break;
      case 'QR':
        //TODO: QR code
        // NavUtil.navigateScreen(context, const QRCodeScannerView());
        Fluttertoast.showToast(msg: 'QR attendance under premium policy');
        break;
      case 'N':
        NavUtil.navigateScreen(
            context,
            const Attendance(
              navigationMenu: false,
            ));
        break;
      default:
        NavUtil.navigateScreen(
            context,
            const Attendance(
              navigationMenu: false,
            ));
        break;
    }
  }

  logOutFunctionality(context) async {
    await SPUtill.deleteKey(SPUtill.keyAuthToken);
    await SPUtill.deleteKey(SPUtill.keyUserId);
    await SPUtill.deleteKey(SPUtill.keyProfileImage);
    await SPUtill.deleteKey(SPUtill.keyCheckInID);
    await SPUtill.deleteKey(SPUtill.keyName);
    await SPUtill.deleteKey(SPUtill.keyIsAdmin);
    await SPUtill.deleteKey(SPUtill.keyIsHr);
    NavUtil.pushAndRemoveUntil(context, const SplashScreen());
    notifyListeners();
  }
}
