
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/model/project_dashboard_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/model/project_list_model.dart';

import '../../../../../api_service/api_response.dart';
import '../../../../../api_service/api_service.dart';

class CrmProjectRepository{

  ///projectDashboardResponse
  static Future<ApiResponse<ProjectDashboardModel>> getCrmProjectHomeData() async {
    try {
      //EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/projects");
      //EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("crm project data......${response.data}");
        }
        var obj = projectDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = projectDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        //EasyLoading.dismiss();
        var obj = projectDashboardModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        //EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }

 
///projectListResponse
 static Future<ApiResponse<ProjectListModel>> getCrmProjectListData(String? search) async {

  try{
    var response = await ApiService.getDio()!.get("/app/projects/list?keyword=$search");
    if(response.statusCode == 200){
     if (kDebugMode) {
       print("crm project list data........${response.data}");
     }
     var obj = projectListModelFromJson(response.toString());
     return ApiResponse(
      httpCode: response.statusCode,
      result: obj.result,
      message: obj.message,
      data:obj
     ); 
    } else {
        var obj = projectListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
    }

  }
 on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        //EasyLoading.dismiss();
        var obj = projectListModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        //EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
 }


///createProject
///create project post method
 static  Future addProject(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
      await ApiService.getDio()!.post('/app/projects/store', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print(response.data);
      }
      var obj = response.data;

      return obj;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }



  ///update task method

  ///getCrmTaskUpdateData
  static Future<bool> updateProjectData(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.post("/app/projects/update",data: data);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        EasyLoading.dismiss();
        return false;
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return false;
      }
    }
  }



  ///project delete
  ///Task Delete method
  static Future projectDelete({int? projectId}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response =
      await ApiService.getDio()!.get("/app/projects/delete/$projectId");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          Fluttertoast.showToast(
              msg: "Project deleted successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              fontSize: 16.0
          );

          print("crm  project delete......${response.data}");
        }
        // var obj = response.data;
        //
        // return obj;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        EasyLoading.dismiss();
      }
      return e.response;
    }
  }
}