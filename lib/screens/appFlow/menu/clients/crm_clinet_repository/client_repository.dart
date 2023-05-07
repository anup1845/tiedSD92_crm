import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_dashboard_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/deal_list_model.dart';
import '../../../../../api_service/api_response.dart';
import '../../../../../api_service/api_service.dart';
import '../model/project_details_model.dart';

class CrmClientRepository{
  ///clientdashboard
   static Future<ApiResponse<ClientDashboardModel>> getCrmClientHomeData() async {
    try {
      var response = await ApiService.getDio()!.get("/app/clients");
      if (response.statusCode == 200) {

          debugPrint("crm client data......${response.data}");

        if (kDebugMode) {
          debugPrint("crm client data......${response.data}");
        }
        var obj = clientDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = clientDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
       //EasyLoading.dismiss();
        var obj = clientDashboardModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        //EasyLoading.dismiss();
        if (kDebugMode) {
          debugPrint(e.message);
        }
        return ApiResponse(httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }


///addClient
  static Future addClient(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/clients/store', data: data);
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
      Fluttertoast.showToast(
          msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }

  ///clientList
   static Future<ApiResponse<ClientListModel>> getCrmClientList({String? reposearch}) async {
    try {
      //EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/clients/list?keyword=$reposearch");
      //EasyLoading.dismiss();
      if (response.statusCode == 200) { 
         if (kDebugMode) {
           print("crm client list data......${response.data}");
         }
        if (kDebugMode) {
          print("crm client list data......${response.data}");
        }
        var obj = clientListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = clientListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        //EasyLoading.dismiss();
        var obj = clientListModelFromJson(e.response.toString());
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


///updateClient
  static Future updateClient(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/clients/update', data: data);
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
      Fluttertoast.showToast(
          msg: e.response?.data['message'] ?? 'Something went wrong');
      return e.response?.data;
    }
  }


///client delete
///Task Delete method
  static Future clientDelete(
      int? clientId) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/clients/delete/$clientId");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {

        if (kDebugMode) {
          print("crm  task list from repo......${response.data}");
        }

        var obj = response.data;

        return obj;
      }

    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        EasyLoading.dismiss();
      }
      return e.response;
    }
  }



///clentDealList
static Future<ApiResponse<DealListModel>> getClientDealList({int? id, String? search}) async {
  //print("app/clients/projects-list/$id");
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/clients/projects-list/$id?keyword=$search");
      EasyLoading.dismiss();
      if (response.statusCode == 200) { 
         if (kDebugMode) {
           print("client deal list data......${response.data}");
         }
        var obj = dealListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = dealListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        //EasyLoading.dismiss();
        var obj = dealListModelFromJson(e.response.toString());
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


  ///clientDetails
  ///getCrmTaskDetailsData
   static Future<ApiResponse<ClientDetailsModel>> getCrmClientDetailLstData(int? id) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/clients/details?id=$id");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
         
        if (kDebugMode) {
          print("crm client details from repo......${response.data}");
        }
        var obj = clientDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = clientDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        EasyLoading.dismiss();
        var obj = clientDetailsModelFromJson(e.response.toString());
        return ApiResponse(
            httpCode: e.response!.statusCode,
            result: e.response!.data["result"],
            message: e.response!.data["message"],
            error: obj);
      } else {
        EasyLoading.dismiss();
        if (kDebugMode) {
          print(e.message);
        }
        return ApiResponse(
            httpCode: -1, message: "Connection error ${e.message}");
      }
    }
  }

   ///projectDetails
   ///getProjectDetailsData
   static Future<ApiResponse<ProjectDetailsModel>> getProjectDetailsData({required int? id}) async {
     try {
       EasyLoading.show(status: 'loading...');
       var response = await ApiService.getDio()!.get("/app/projects/details/$id");
       EasyLoading.dismiss();
       if (response.statusCode == 200) {
         if (kDebugMode) {
           debugPrint("crm client details from repo......${response.data}");
         }
         final obj = projectDetailsModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       } else {
         var obj = projectDetailsModelFromJson(response.toString());
         return ApiResponse(
             httpCode: response.statusCode,
             result: obj.result,
             message: obj.message,
             data: obj);
       }
     } on DioError catch (e) {
       if (e.type == DioErrorType.response) {
         EasyLoading.dismiss();
         var obj = projectDetailsModelFromJson(e.response.toString());
         return ApiResponse(
             httpCode: e.response!.statusCode,
             result: e.response!.data["result"],
             message: e.response!.data["message"],
             error: obj);
       } else {
         EasyLoading.dismiss();
         if (kDebugMode) {
           print(e.message);
         }
         return ApiResponse(
             httpCode: -1, message: "Connection error ${e.message}");
       }
     }
   }





}