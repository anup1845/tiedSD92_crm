// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:hrm_app/screens/appFlow/menu/clients/model/client_list_model.dart';
// import 'package:hrm_app/screens/appFlow/menu/projects/crm_project_repository/crm_project_repository.dart';
// import 'package:hrm_app/screens/appFlow/menu/projects/project_details/project_details_screen.dart';
// import 'package:hrm_app/screens/appFlow/menu/projects/project_list/project_list_screen.dart';
// import 'package:hrm_app/screens/appFlow/menu/task/model/task_details_model.dart';
// import 'package:hrm_app/screens/appFlow/menu/task/task_repository/task_repository.dart';
// import 'package:hrm_app/utils/res.dart';
//
// import '../../../../../utils/nav_utail.dart';
// import '../../clients/model/project_details_model.dart';
// import '../../task/task_details/task_details_screen.dart';
//
// class EditProjectProvider extends ChangeNotifier {
//   //CreateTaskModel? createTaskModel;
//
//   final projectNameController = TextEditingController();
//   final projectDescriptionController = TextEditingController();
//   final clientController = TextEditingController();
//   String? startDate;
//   String? endDate;
//   List<Client>clientList = [];
//   Client? client;
//   DateFormat? dateFormat = DateFormat("yyyy-MM-dd");
//
//   //DateTimeRange? dateRange =(start : DateTime(2022, 10, 10),  end: DateTime(2022, 10, 10));
//   DateTimeRange? dateRange;
//
//   ProjectDetailsModel? projectDetailsData;
//
//   EditProjectProvider(ProjectDetailsModel? projectDetails) {
//     if (projectDetails != null) {
//       projectDetailsData = projectDetails;
//       //setControllerData(projectDetails);
//       //getCrmCreateProjectData();
//     }
//   }
//
//   /// dropdownMenu for client type .....
//   selectClient(Client? clientValue) {
//     client = clientValue;
//     notifyListeners();
//   }
//
//
//
//   updateProjectData({required BuildContext context,required int projectId}) async {
//
//     final data = FormData.fromMap({
//       "id": projectDetailsData?.data?.id,
//       "client": client?.id,
//       "name": projectNameController.text,
//       "start_date": startDate,
//       "end_date": endDate,
//       "description": projectDescriptionController.text,
//       "members": projectDetailsData?.data?.assigns?.map((e) => e.id).join(',')
//     });
//
//     if (kDebugMode) {
//       print({
//         "id":projectDetailsData?.data?.id,
//         "client": client?.id,
//         "name": projectNameController.text,
//         "start_date": startDate,
//         "end_date": endDate,
//         "description": projectDescriptionController.text,
//         "members": projectDetailsData?.data?.assigns?.map((e) => e.id).join(',')
//       });
//     }
//
//     await CrmProjectRepository.updateProjectData(data).then((data) {
//
//       NavUtil.replaceScreen(context,const ProjectListScreen());
//     });
//   }
//
//   ///date time picker
//   Future pickDateRange(context, taskDetails) async {
//     DateTimeRange? newDateRange = await showDateRangePicker(
//         context: context,
//         initialDateRange: dateRange,
//         firstDate: DateTime(2021),
//         lastDate: DateTime(2025),
//         builder: (context, child) {
//           return Theme(
//             data: Theme.of(context).copyWith(
//                 dialogBackgroundColor:
//                 Theme.of(context).scaffoldBackgroundColor,
//                 appBarTheme: Theme.of(context).appBarTheme.copyWith(
//                     iconTheme: IconThemeData(
//                         color: Theme.of(context).primaryColorDark)),
//                 colorScheme: Theme.of(context).colorScheme.copyWith(
//                     onPrimary: Colors.black, primary: AppColors.colorPrimary)),
//             child: child!,
//           );
//         });
//
//     if (newDateRange == null) return;
//     dateRange = newDateRange;
//
//     notifyListeners();
//   }
//
//   setControllerData(ProjectDetailsModel projectDetailsData) {
//     DateFormat formatter = DateFormat('yyyy-mm-dd');
//     clientController.text = projectDetailsData.data!.assigns!.isNotEmpty
//         ? projectDetailsData.data?.assigns![0].name ?? ''
//         : '';
//     projectNameController.text =
//         projectDetailsData.data?.name ?? "";
//     projectDescriptionController.text =
//         projectDetailsData.data?.description ?? "";
//     startDate = projectDetailsData.data?.dbStartDate ?? "";
//     endDate = (taskDetailsData.data?.taskDetails?.dbEndDate ?? "");
//     dateRange = DateTimeRange(start: formatter.parse(startDate??''), end: formatter.parse(endDate??''));
//     notifyListeners();
//   }
// }



