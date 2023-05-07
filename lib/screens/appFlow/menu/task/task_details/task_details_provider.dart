import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hrm_app/data/server/respository/repository.dart';
import 'package:hrm_app/screens/appFlow/menu/task/model/task_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_deshboard/task_deshboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';
import '../../../../../utils/nav_utail.dart';

class CrmTaskDetailsProvider extends ChangeNotifier {
  TaskDetailsModel? crmTaskDetailsResponse;
  final commentController = TextEditingController();
  int? taskId;
  bool? isAdmin;

  /// when comment need to update
  int? commentId;
  var updataData;
  String? changedText;

  CrmTaskDetailsProvider(int id) {
    taskId = id;
    getCrmTaskDetails(id);
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

  getCrmTaskDetails(int? id) async {
    final response = await CrmTaskRepository.getCrmTaskDetailstdata(id);
    if (response.httpCode == 200) {
      crmTaskDetailsResponse = response.data;
      notifyListeners();
    }
  }

  Future feedbackComment(context) async {
    print('companyId $commentId');
    if (commentId == null) {
      final data = FormData.fromMap(
          {"task_id": taskId, "comment": commentController.text});
      final response = await CrmTaskRepository.feedbackComment(data);
      if (response['result'] = true) {
        if (kDebugMode) {
          getCrmTaskDetails(taskId);
          commentController.clear();
          print("Successfully comment done");
        }
      }
      commentId = null;
      notifyListeners();
    } else {
      final response =
          await CrmTaskRepository.feedbackCommentUpdate(updataData);
      if (response['result'] = true) {
        if (kDebugMode) {
          getCrmTaskDetails(taskId);
          commentController.clear();
          print("Successfully comment done");
        }
      }
      commentId = null;
      notifyListeners();
    }

    // final data = FormData.fromMap({"task_id": taskId, "comment": commentController.text});
    // final response = await CrmTaskRepository.feedbackComment(data);
    // if (response['result'] = true) {
    //   if (kDebugMode) {
    //     getCrmTaskDetails(taskId);
    //     commentController.clear();
    //     print("Successfully comment done");
    //   }
    // }
  }

  editButton(Discussion? discussion) {
    commentController.text = discussion?.description ?? '';
    commentId = discussion?.id;
    updataData = FormData.fromMap({
      "comment_id": discussion!.id,
      "subject": discussion.subject,
      "comment": commentController.text
    });
    notifyListeners();
  }

  // Future feedbackCommentUpdate(context) async {
  //   final data = FormData.fromMap(
  //       {"comment_id": taskId, "comment": commentController.text});
  //   final response = await CrmTaskRepository.feedbackComment(data);
  //   if (response['result'] = true) {
  //     if (kDebugMode) {
  //       getCrmTaskDetails(taskId);
  //       commentController.clear();
  //       print("Successfully comment done");
  //     }
  //   }
  // }

  Future taskDelete(id, context) async {
    final response = await CrmTaskRepository.taskDelete(taskId: id);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: "Task Deleted Successfully");
      //getCrmTaskDetails(taskId);
      NavUtil.replaceScreen(context, const TaskDashboardScreen());
      notifyListeners();
    }
  }

  Future commentDelete(id) async {
    final response =
        await CrmTaskRepository.feedbackCommentDelete(commentId: id);
    if (response['result'] == true) {
      Fluttertoast.showToast(msg: response['message']);
      getCrmTaskDetails(taskId);
    }
    notifyListeners();
  }
}
