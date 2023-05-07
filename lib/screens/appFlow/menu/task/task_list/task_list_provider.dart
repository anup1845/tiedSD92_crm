import 'package:flutter/foundation.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';
import 'dart:async';

class CrmTaskListProvider extends ChangeNotifier{

TaskListModel? crmTaskListResponse;
 Timer? timeHandle;
String search = "";
String? status;
String? priority;

 CrmTaskListProvider({String? statusId}) {
   status = statusId;
   getCrmTaskListData(status ?? '0', priorityId: priority);
  }

  changeTaskStatus(id){
   priority = id;
   getCrmTaskListData(status ?? '0', priorityId: priority);
   notifyListeners();
  }


  void getSearchValue(String searchCode){
   search = searchCode;
    if(timeHandle != null){
      timeHandle!.cancel();
    }

    timeHandle = Timer(const Duration(seconds: 1), (){
      getCrmTaskListData(status ?? '0', priorityId: priority);
      notifyListeners();
    }
    );
  }

  getCrmTaskListData(String status, {String? priorityId}) async {
    final response = await CrmTaskRepository.getCrmTaskListData(status, search, taskStatusId: priorityId ?? '');
    if(response.httpCode == 200){

    crmTaskListResponse = response.data;
    notifyListeners();
    }
    notifyListeners();
  }

}