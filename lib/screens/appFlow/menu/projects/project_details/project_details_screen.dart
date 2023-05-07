import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_dashboard/project_dashboard_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/project_details_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/screens/custom_widgets/progress_indecator_with_persentage.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/api_response.dart';
import '../../../../../utils/nav_utail.dart';
import '../../../../../utils/res.dart';
import '../../clients/crm_clinet_repository/client_repository.dart';
import '../../clients/model/project_details_model.dart';
import '../../employee/add_employee/add_employee_screen.dart';
import '../create_project/create_project_provider.dart';
import '../update_project/update_project_screen.dart';
import 'content/attachment_tabview.dart';
import 'content/feedback_tabview.dart';
import 'content/task_view/task_tabview.dart';

class ProjectDetailsScreen extends StatelessWidget {
  ProjectDetailsScreen({super.key, this.project, required this.projectId});

  final Project? project;
  final int? projectId;

  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Tasks'),
    //const Tab(text: 'Feedback'),
    const Tab(text: 'Attachment'),
  ];

  PopupMenuItem _buildPopupMenuItem(String title) {
    return PopupMenuItem(
      value: title,
      child: Text(
        title,
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => ProjectDetailsProvider(projectId),
      child: Consumer<ProjectDetailsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              elevation: 0,
              actions: [
                // Visibility(
                //   visible: provider.isAdmin ?? false,
                //   child: InkWell(
                //     onTap: () {
                //       NavUtil.navigateScreen(
                //           context,
                //           UpdateProjectScreen(
                //             details: provider.crmClientDetailsResponse,
                //             // taskDetails: provider.crmTaskDetailsResponse,
                //           ));
                //     },
                //     child: Container(
                //       margin: const EdgeInsets.only(right: 16),
                //       padding: const EdgeInsets.all(8),
                //       decoration: const BoxDecoration(
                //           shape: BoxShape.circle, color: AppColors.colorPrimary),
                //       child: Icon(
                //         size: 14.0.r,
                //         Icons.edit,
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                // ),
                Visibility(
                  visible: provider.isAdmin ?? false,
                  child: InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print(projectId);
                      }
                      provider.projectDelete(projectId, context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.colorPrimary),
                      child: Icon(
                        size: 14.0.r,
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )

              ],
              title: Text(
                "Project Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
              ),
            ),
            body: FutureBuilder<ApiResponse<ProjectDetailsModel>>(
              future:
                  CrmClientRepository.getProjectDetailsData(id: project?.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Widget> assigns = [];
                  final data = snapshot.data?.data?.data;

                  for (int i = 0; i < data!.projectDetailsMembers!.length; i++) {
                    assigns.add(Positioned(
                      left: i * 15,
                      top: 0.0,
                      bottom: 0.0,
                      child: InkWell(
                        onTap: (){
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title:  Text("Name : ${data.projectDetailsMembers!.elementAt(i).name ?? ""}"),
                              //content: Text("Designation : ${data.assigns!.elementAt(i).designation}\nDepartment : ${data.assigns!.elementAt(i).department ?? ""}"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          width: 30.0.w,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${data.projectDetailsMembers!.elementAt(i).avatar}'))),
                          child: const SizedBox.shrink(),
                        ),
                      ),
                    ));
                  }

                  return SingleChildScrollView(
                    primary: true,
                    child: Padding(
                      padding: EdgeInsets.only(top: 36.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  '${data.name}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                )),
                                Visibility(
                                  child: Visibility(
                                    visible: provider.isAdmin ?? false,
                                    child: PopupMenuButton(
                                      onSelected: (value) {
                                        provider.menuItemRoute(value, context, data);
                                      },
                                      itemBuilder: (BuildContext context) => [
                                         _buildPopupMenuItem('Update'),
                                        _buildPopupMenuItem('Delete'),
                                      ],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          "assets/task/task_menu_dot.png",
                                          height: 6.h,
                                          width: 18.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              '${data.description}',
                              textAlign: TextAlign.justify,
                              maxLines: 5,
                              style: TextStyle(
                                  color: const Color(0xff8A8A8A),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Text(
                                  "Assigned : ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                data.projectDetailsMembers != null ?
                                  SizedBox(
                                    width: 25.0 * data.projectDetailsMembers!.length,
                                    height: 40.0.h,
                                    child: Stack(children: assigns),
                                  ) : const SizedBox(),
                                // Text(
                                //   '${data.assigns?.length}+',
                                //   textAlign: TextAlign.justify,
                                //   style: TextStyle(
                                //       color: const Color(0xff8A8A8A),
                                //       fontSize: 14.sp,
                                //       fontWeight: FontWeight.w400),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Text(
                                  "Project Owner : ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                InkWell(
                                    onTap: (){
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title:  Text("Name :  '${data.projectOwner?.name}'"),
                                          //content: Text("Designation : ${data.owner!.elementAt(i).}\nDepartment : ${data.users!.elementAt(i).department ?? ""}"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(context, 'OK'),
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Image.network(
                                      '${data.projectOwner?.avatar}',
                                      height: 30.h,
                                      width: 30.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Text(
                                  "Project Client : ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                InkWell(
                                  onTap: (){
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title:  Text("Name :  '${data.client?.name}'"),
                                        //content: Text("Designation : ${data.owner!.elementAt(i).}\nDepartment : ${data.users!.elementAt(i).department ?? ""}"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Image.network(
                                      '${data.projectOwner?.avatar}',
                                      height: 30.h,
                                      width: 30.w,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Text(
                                  "Project Status : ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Text(
                                  '${data.status}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: const Color(0xff8A8A8A),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Text(
                                  "Star Date : ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Image.asset(
                                  "assets/projects/calender_black.png",
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),

                                Text(
                                  '${data.startDate}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: const Color(0xff8A8A8A),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Text(
                                  "End Date : ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Image.asset(
                                  "assets/projects/calender_black.png",
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  '${data.endDate}',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: const Color(0xff8A8A8A),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              "Project Progress",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp),
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: ProgressIndeccatorWithPersentage(
                              persentageActiveColor: const Color(0xff615FFF),
                              persentageDisebleColor: const Color(0xffC9C9C9),
                              activeContainerWidth:
                                  ((ScreenUtil.defaultSize.width - 80.0) *
                                          double.parse('${data.progress}')) /
                                      100,
                              deActivetContainerWidth: (ScreenUtil
                                          .defaultSize.width -
                                      80.0) -
                                  ((ScreenUtil.defaultSize.width - 85.0) *
                                          double.parse('${data.progress}')) /
                                      100,
                              containerHeight: 12.h,
                              persentage: "${data.progress}%",
                              persentageTextHeight: 16.h,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            padding: EdgeInsets.only(
                                top: 31.h, left: 17.w, right: 17.w),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            child: DefaultTabController(
                              length: myTabs.length,
                              child: Scaffold(
                                appBar: PreferredSize(
                                  preferredSize: Size.fromHeight(56.h),
                                  child: AppBar(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    automaticallyImplyLeading: false,
                                    bottom: TabBar(
                                      indicatorColor: const Color(0xff615FFF),
                                      tabs: myTabs,
                                      labelColor: const Color(0xff615FFF),
                                      unselectedLabelColor: Colors.black,
                                    ),
                                  ),
                                ),
                                body: Container(
                                  color: Colors.white,
                                  child: TabBarView(children: [
                                    ///Tasks
                                    TaskTabView(project: data),


                                    ///Feedback
                                    //FeedbackTabView(project: data),


                                    ///Attachment
                                    AttachmentTabView(project: data),
                                  ]),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return const Center(
                  child: Text('Loading...'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
