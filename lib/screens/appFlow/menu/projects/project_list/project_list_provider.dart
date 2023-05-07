import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/model/project_list_model.dart';

class CrmProjectListProvider extends ChangeNotifier {

  ProjectListModel? crmProjectListResponse;
  Timer? timeHnadle;
  String search = "";


  CrmProjectListProvider(){
    getCrmProjectListData(search);
 
  }


void getSearchValue(String searchCode){
  search = searchCode;
  if(timeHnadle != null){
    timeHnadle!.cancel();
  }

  timeHnadle = Timer(const Duration(seconds: 1), (){
    getCrmProjectListData(search);
  });
}


    ///get projectList Data
   getCrmProjectListData(String? search) async {
    final response = await CrmProjectRepository.getCrmProjectListData(search  );
    if (response.httpCode == 200) {
      crmProjectListResponse = response.data;
      notifyListeners();
    }
    notifyListeners();
  }

}