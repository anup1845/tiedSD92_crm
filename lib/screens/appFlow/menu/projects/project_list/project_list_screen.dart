import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/create_project/create_project_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/project_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_list/project_list_provider.dart';
import 'package:hrm_app/screens/custom_widgets/custom_list_shimer.dart';
import 'package:hrm_app/screens/custom_widgets/custom_tap_bar_button.dart';
import 'package:hrm_app/screens/custom_widgets/custom_title_appbar.dart';
import 'package:hrm_app/screens/custom_widgets/project_status_card.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import '../../../../../api_service/connectivity/no_internet_screen.dart';
import '../../../../custom_widgets/progress_indecator_with_persentage.dart';

class ProjectListScreen extends StatelessWidget {
  const ProjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => CrmProjectListProvider(),
        child:
            Consumer<CrmProjectListProvider>(builder: (context, provider, _) {
              
          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(56.h),
              child: const CustomTitleAppBar(
                title: "Project List ",
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 13.5.w),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.r)),
                            child: TextFormField(
                              onChanged: ((value) {
                                provider.getSearchValue(value);
                              }),
                              maxLines: 1,
                              cursorColor: const Color(0xff5B58FF),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                  ),
                                  hintStyle: TextStyle(
                                      color: const Color(0xffCED1DA),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp),
                                  hintText: "Search...."),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateProjectScreen()));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 13.h, horizontal: 15.w),
                            decoration: BoxDecoration(
                                color: const Color(0xff5B58FF),
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Icon(
                              Icons.add,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    ///project list

                    provider.crmProjectListResponse?.data?.data?.projects !=
                            null
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.crmProjectListResponse?.data
                                    ?.data?.projects?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              final data = provider.crmProjectListResponse?.data
                                  ?.data?.projects?[index];
                              List<Widget> users = [];

                              for (int i = 0;
                              i < data!.members!.length;
                              i++) {
                                users.add(Positioned(
                                  left: i * 15,
                                  top: 0.0,
                                  bottom: 0.0,
                                  child: InkWell(
                                    onTap: (){
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                          title:  Text("Name : ${data.members!.elementAt(i).name ?? ""}"),
                                          content: Text("Designation : ${data.members!.elementAt(i).designation}\nDepartment : ${data.members!.elementAt(i).department ?? ""}\nPhone : ${data.members!.elementAt(i).phone ?? ""}\nemail : ${data.members!.elementAt(i).email ?? ""}"),
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
                                                  '${data.members!.elementAt(i).avatar}'))),
                                      child: const SizedBox.shrink(),
                                    ),
                                  ),
                                ));
                              }
                              return ProjectStatusCard(
                               ontap: () {
                                  Project project = Project(
                                    id: data.id,
                                    name: data.title,
                                    status: data.status,
                                    color: data.color,

                                  );
                                  NavUtil.navigateScreen(
                                      context,
                                      ProjectDetailsScreen(
                                        project: project,
                                        projectId: project.id,

                                      ));
                                },
                                tapBarButton1: CustomTapBarButton(
                                  buttonColor: const Color(0xffF4EFFD),
                                  textColor: const Color(0xff5B58FF),
                                  buttonText: data.status,
                                  borderColor: const Color(0xffF4EFFD),
                                ),
                                tapBarButton2: CustomTapBarButton(
                                  buttonColor: const Color(0xffFDEFEF),
                                  textColor: const Color(0xffE96161),
                                  buttonText: data.priority,
                                  borderColor: const Color(0xffFDEFEF),
                                ),
                                startData: data.dateRange,
                                rightIconArrowColor: const Color(0xff00606F),
                                projectName: data.title,
                                usersImage: users,
                                userCount: data.userCount,
                                actualCount: data.actualCount,
                                // image1: "assets/projects/roundProfile.png",
                                // image2: "assets/projects/roundImage02.png",
                                // image3:
                                //     "assets/task/task_in_review_add_updsate.png",
                                progressBar: ProgressIndeccatorWithPersentage(
                                  persentageActiveColor:
                                      const Color(0xff00606F),
                                  persentageDisebleColor:
                                      const Color(0xffEAEAEA),
                                    activeContainerWidth: ((ScreenUtil.defaultSize.width - 80.0) * double.parse('${data.progress}'))/100,
                        deActivetContainerWidth: (ScreenUtil.defaultSize.width- 80.0) - ((ScreenUtil.defaultSize.width - 85.0) * double.parse('${data.progress}'))/100,
                        
                                  persentage: "${data.progress ?? 0}%",
                                ),
                              );
                            })
                        : const CustomListShimer(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      )),
                    ),

                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
