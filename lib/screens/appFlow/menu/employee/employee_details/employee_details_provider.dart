import 'package:flutter/cupertino.dart';
import 'package:hrm_app/data/server/respository/repository.dart';

class EmployeeDetailsProvider extends ChangeNotifier {
  bool? isAdmin;

  EmployeeDetailsProvider() {
    getSettingBase();
  }

  getSettingBase() async {
    var apiResponse = await Repository.baseSettingApi();
    if (apiResponse.result == true) {
      ///check user register their face or not
      ///if not then go to face register page
      isAdmin = apiResponse.data?.data?.isAdmin;

      notifyListeners();
    }
  }
}
