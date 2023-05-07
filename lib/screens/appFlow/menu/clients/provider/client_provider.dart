import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_dashboard_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
import 'dart:async';
import '../crm_clinet_repository/client_repository.dart';

class CrmClientProvider extends ChangeNotifier {
// CrmClientRepository? getCrmClientList = CrmClientRepository();

  ClientDashboardModel? crmClientDashboardResponse;
  ClientListModel? crmClientListREsponse;
  Timer? timeHandle;
  String search = "";
  bool? isAdmian;

  CrmClientProvider(BuildContext context) {
    getCrmClientDashboardData();
    getCrmClientListData(search);
    getSettingBase();
  }

  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      ///check user register their face or not
      ///if not then go to face register page
      isAdmian = apiResponse.data?.data?.isAdmin;

      notifyListeners();
    }
  }

  ///get client dashboard data
  getCrmClientDashboardData() async {
    final response = await CrmClientRepository.getCrmClientHomeData();
    if (response.httpCode == 200) {
      if (kDebugMode) {
        print(
            "Crm Client provider responde data from provider.................................................... ${response.data}");
      }

      crmClientDashboardResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }

  void getSearchValue(String searchCode) {
    search = searchCode;
    if (timeHandle != null) {
      timeHandle!.cancel();
    }

    timeHandle = Timer(const Duration(seconds: 1), () {
      getCrmClientListData(search);
      notifyListeners();
    });

    //print("controller page $searchCode");
  }

  getCrmClientListData(String? search) async {
    final response =
        await CrmClientRepository.getCrmClientList(reposearch: search);
    if (response.httpCode == 200) {
      if (kDebugMode) {
        print(
            "Crm Clientlist provider responde data from provider.................................................... ${response.data}");
      }

      crmClientListREsponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }
}
