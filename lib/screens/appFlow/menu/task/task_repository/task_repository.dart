import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/create_task_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_dashboard_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_list_model.dart';
import '../../../../../api_service/api_response.dart';
import '../../../../../api_service/api_service.dart';

class CrmTaskRepository {
  ///GetCrmTaskHomeData
  static Future<ApiResponse<TaskDashboardModel>> getCrmTaskHomeData() async {
    try {
      //EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/tasks");
      //EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("crm task data......${response.data}");
        }
        var obj = taskDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskDashboardModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        EasyLoading.dismiss();
        var obj = taskDashboardModelFromJson(e.response.toString());
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

  ///getCrmTaskDetailsData
  static Future<ApiResponse<TaskDetailsModel>> getCrmTaskDetailstdata(
      int? id) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/tasks/$id");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("crm task details from repo......${response.data}");
        }
        var obj = taskDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskDetailsModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        EasyLoading.dismiss();
        var obj = taskDetailsModelFromJson(e.response.toString());
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

  ///getCrmTaskCreateData
  static Future<ApiResponse<CreateTaskModel>> getCrmCreateTaskData() async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get("/app/tasks/create");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("crm create task  from repo......${response.data}");
        }
        var obj = createTaskModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = createTaskModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        EasyLoading.dismiss();
        var obj = createTaskModelFromJson(e.response.toString());
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

  ///getCrmTaskUpdateData
  static Future<bool> updateTaskData(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.post("/app/tasks/update",data: data);
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

  ///create task post method
  static Future addTask(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response =
          await ApiService.getDio()!.post('/app/tasks/store', data: data);
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

////crmTaskList
  static Future<ApiResponse<TaskListModel>> getCrmTaskListData(
      String status, String search,
      {String? taskStatusId}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!.get(
          "/app/tasks/list?keyword=$search&status=$status&priority=$taskStatusId");
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("crm  task list from repo......${response.data}");
        }
        var obj = taskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      } else {
        var obj = taskListModelFromJson(response.toString());
        return ApiResponse(
            httpCode: response.statusCode,
            result: obj.result,
            message: obj.message,
            data: obj);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        EasyLoading.dismiss();
        var obj = taskListModelFromJson(e.response.toString());
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

  /// feedBack comment method
  static Future feedbackComment(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!
          .post('/app/tasks/store-comment', data: data);
      EasyLoading.dismiss();
      if (kDebugMode) {
        print("coment post from repo.........${response.data}");
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

  /// feedBack comment method
  static Future feedbackCommentUpdate(data) async {
    try {
      EasyLoading.show(status: 'loading...');
      final response = await ApiService.getDio()!
          .post('/app/tasks/update-comment', data: data);
      EasyLoading.dismiss();
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

  ///Task Delete method
  static Future taskDelete({int? taskId}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response =
          await ApiService.getDio()!.get("/app/tasks/delete?task_id=$taskId");
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

  /// feedBack comment delete method
  static Future feedbackCommentDelete({int? commentId}) async {
    try {
      EasyLoading.show(status: 'loading...');
      var response = await ApiService.getDio()!
          .get("/app/tasks/delete-comment/$commentId");
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
}
