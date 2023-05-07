import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrm_app/screens/appFlow/home/components/earning_widget.dart';
import 'package:hrm_app/screens/appFlow/home/home_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/model/client_details_model.dart';
import 'package:hrm_app/screens/appFlow/menu/componets/menu_drawer.dart';
import 'package:hrm_app/screens/appFlow/menu/menu_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/my_account.dart';
import 'package:hrm_app/screens/appFlow/menu/projects/project_details/project_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/task/task_details/task_details_screen.dart';
import 'package:hrm_app/screens/appFlow/natification/notification_screen.dart';
import 'package:hrm_app/screens/custom_widgets/custom_tap_bar_button.dart';
import 'package:hrm_app/utils/nav_utail.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../api_service/connectivity/no_internet_screen.dart';
import '../../../live_traking/location_provider.dart';
import '../../custom_widgets/progress_indecator_with_persentage.dart';
import '../../custom_widgets/project_status_card.dart';
import '../menu/projects/project_list/project_list_screen.dart';
import '../menu/task/task_list/task_list_screen.dart';
import '../menu/task/widgets/task_assign_card_with_date.dart';

class CrmHomeScreen extends StatefulWidget {
  CrmHomeScreen({super.key});

  @override
  State<CrmHomeScreen> createState() => _CrmHomeScreenState();
}

class _CrmHomeScreenState extends State<CrmHomeScreen> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  late CustomTimerController controllerBreakTimer;
  @override
  Widget build(BuildContext context) {
    var providerMenu = context.watch<MenuProvider>();
    controllerBreakTimer = CustomTimerController(
      vsync: this,
      begin: const Duration(hours: 0, minutes: 0, seconds: 0),
      end: const Duration(hours: 0, minutes: 0, seconds: 0),
    );
    return ChangeNotifierProvider(
        create: (context) => LocationProvider(),
        child: Consumer<LocationProvider>(builder: (context, locationProvider, _) {
          return NoInternetScreen(
            child: ChangeNotifierProvider(
              create: (context) => HomeProvider(context, locationProvider,controllerBreakTimer ),
              child: Consumer<HomeProvider>(builder: (context, provider, _) {
                var projectSummary =  provider.crmResponseData?.data?.projectSummary?.data;
                return Scaffold(
                  backgroundColor: AppColors.backgroundColor,
                  key: scaffoldKey,
                  drawer: MenuDrawer(provider: providerMenu),
                  extendBody: true,
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(70),
                    child: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: InkWell(
                          onTap: () {
                            if (scaffoldKey.currentState!.isDrawerOpen) {
                              scaffoldKey.currentState?.openDrawer();
                            } else {
                              scaffoldKey.currentState?.openDrawer();
                            }
                          },
                          child: Image.asset(
                            "assets/task/menu_bar.png",
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          "Home Screen",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, right: 16),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  NavUtil.navigateScreen(
                                      context, const NotificationScreen());
                                },
                                child: Image.asset(
                                  "assets/task/notification_vector.png",
                                  height: 50.h,
                                  width: 45.w,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const MyAccount()));
                                },
                                child:  ClipOval(
                                  child: CachedNetworkImage(
                                    height: 50.h,
                                    width: 40.w,
                                    fit: BoxFit.cover,
                                    imageUrl: "${provider.profileImage}",
                                    placeholder: (context, url) => Center(
                                      child:
                                      Image.asset("assets/images/placeholder_image.png"),
                                    ),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 24.h, horizontal: 16.w),
                        child: Column(
                          children: [
                            ///project Summery horizontal list
                            SizedBox(
                              height: 260.h,
                              child: projectSummary?.isNotEmpty == true
                                  ? ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: projectSummary?.length ?? 0,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        final data = projectSummary?[index];
                                        return HomeProjectCard(
                                          cardImage:
                                              "assets/crm_home/running_project.png",
                                          title: data?.name ?? "",
                                          quantity: data?.number.toString(),
                                          quantityColor: AppColors.lightSky,
                                          description: data?.text,
                                          // descriptionNextLine: "",
                                          seeMore: data?.buttonText,
                                        );
                                      })
                                  : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        return Shimmer.fromColors(
                                          baseColor: const Color(0xFFE8E8E8),
                                          highlightColor: Colors.white,
                                          child: Container(
                                            margin: const EdgeInsets.all(16.0),
                                            height: 120.h,
                                            width: 200.w,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFE8E8E8),
                                              borderRadius: BorderRadius.circular(
                                                  10), // radius of 10// green as background color
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            ),

                            /// Statistics chart
                             EarningWidget(chartData: provider.crmResponseData?.data?.staticstics?.data),
                            // Image.asset("assets/crm_home/chart.png"),
                            SizedBox(
                              height: 24.h,
                            ),

                            ///Teak in progress
                            //   /// task in Progress title
                            SeeAllTitle(
                              titile: "Task in Progress",
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TaskListScreen()));
                              },

                            ),
                            SizedBox(
                              height: 2.h,
                            ),

                            ///Tasklist
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.crmResponseData?.data?.tasks
                                        ?.data?.length ??
                                    0,
                                itemBuilder: (BuildContext context, index) {
                                  final data = provider.crmResponseData?.data
                                      ?.tasks?.data?[index];
                                  return TaskAssignCardWithDate(
                                    onTap: () {
                                      NavUtil.navigateScreen(
                                        context,
                                        TaskDetailsScreen(taskId: data!.id!),
                                      );
                                    },
                                    taskName: data?.title,
                                    userCount: data?.usersCount,
                                    tapButtonColor: const Color(0xff5B58FF),
                                    taskStartDate: data?.endDate,
                                    userData: data,
                                    //taskEndDate: "20 Aug",
                                  );
                                }),

                            ///Projects
                            ///projct title
                            SeeAllTitle(
                              titile: "My Projects",
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProjectListScreen()));
                              },
                            ),
                            SizedBox(
                              height: 02.h,
                            ),

                            ///project list
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: provider.crmResponseData?.data
                                        ?.projects?.length ??
                                    0,
                                itemBuilder: (BuildContext context, index) {
                                  final data = provider
                                      .crmResponseData?.data?.projects?[index];
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
                                              content: Text("Designation : ${data.members!.elementAt(i).designation ?? ""}\nDepartment : ${data.members!.elementAt(i).department ?? ""}\nPhone : ${data.members!.elementAt(i).phone ?? ""}\nEmail : ${data.members!.elementAt(i).email ?? ""}"),
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
                                    tapBarButton1:  CustomTapBarButton(
                                      buttonColor: const Color(0xffF4EFFD),
                                      textColor: const Color(0xff5B58FF),
                                      buttonText: data.status,
                                      borderColor: const Color(0xffF4EFFD),
                                    ),
                                    tapBarButton2:  CustomTapBarButton(
                                      buttonColor: const Color(0xffFDEFEF),
                                      textColor: const Color(0xffE96161),
                                      buttonText: data.priority,
                                      borderColor: const Color(0xffFDEFEF),
                                    ),
                                    //startData: data?.dateRange,
                                    rightIconArrowColor:
                                        const Color(0xff00606F),
                                    projectName: data.title,
                                    usersImage: users,
                                    userCount: data.userCount,
                                    startData: data.dateRange,
                                    endDate: "",

                                    progressBar:
                                    ProgressIndeccatorWithPersentage(
                                      persentageActiveColor:
                                      const Color(0xff00606F),
                                      persentageDisebleColor:
                                      const Color(0xffEAEAEA),
                                      activeContainerWidth: ((ScreenUtil
                                          .defaultSize.width -
                                          80.0) *
                                          double.parse(
                                              '${data.progress}')) /
                                          100,
                                      deActivetContainerWidth: (ScreenUtil
                                          .defaultSize.width -
                                          80.0) -
                                          ((ScreenUtil.defaultSize.width -
                                              85.0) *
                                              double.parse(
                                                  '${data.progress}')) /
                                              100,
                                      persentage:
                                      "${data.progress ?? 0}%",
                                    ),
                                  );
                                }),

                            ///Notice
                            ///Notice title
                            // SeeAllTitle(
                            //   titile: "Notice",
                            //   ontap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const NoticeListScreen()));
                            //   },
                            // ),
                            SizedBox(
                              height: 02.h,
                            ),

                            ///Notice list
                            // ListView.builder(
                            //     shrinkWrap: true,
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     itemCount: provider.crmResponseData?.data
                            //             ?.notices?.data?.length ??
                            //         0,
                            //     itemBuilder: (BuildContext context, index) {
                            //       final data = provider.crmResponseData?.data
                            //           ?.notices?.data?[index];
                            //       return NoticeCard(
                            //         image:
                            //             "assets/crm_home/new_project_update.png",
                            //         title: data?.title,
                            //         notice: "Logo Design Project",
                            //         name: "Md. Rashed",
                            //         time: data?.name,
                            //       );
                            //     }),

                            ///Support
                            ///Support titile
                            // SeeAllTitle(
                            //   titile: "Support",
                            //   ontap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const SupportListScreen()));
                            //   },
                            // ),
                            SizedBox(
                              height: 2.h,
                            ),

                            ///support List
                            // ListView.builder(
                            //     shrinkWrap: true,
                            //     physics: const NeverScrollableScrollPhysics(),
                            //     itemCount: provider.crmResponseData?.data
                            //             ?.supports?.data?.length ??
                            //         0,
                            //     itemBuilder: (BuildContext context, index) {
                            //       final data = provider.crmResponseData?.data
                            //           ?.supports?.data?[index];
                            //       return
                            //             Container(child: Row(
                            //             children: [
                            //               Expanded(
                            //                 child: Row(
                            //                   children: [
                            //                     Icon(Icons.check_box_outline_blank),

                            //                     Expanded(child: Column(
                            //                       children: [
                            //                         Text('as;dfjlasdfasdfasdfasdfasfafasfsf;sjf  fgsdfg sdfg ', maxLines: 1,),
                            //                         Text('as;dfjlasdfasdfasdfasdfasfafasfsf;sjf sdfg ', maxLines: 1,),
                            //                       ],
                            //                     ))
                            //                   ],
                            //                 ),
                            //               ),
                            //               Text('hello')

                            //             ],
                            //           ),);
                            //           SupportCard(
                            //         overdueWidget: Container(
                            //           padding: EdgeInsets.symmetric(
                            //               vertical: 1.h, horizontal: 5.w),
                            //           decoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(2.r),
                            //               color: const Color(0xffFFECF0),
                            //               border: Border.all(
                            //                   color: const Color(0xffFED5DB))),
                            //           child: Text(
                            //             data?.alert ?? "",
                            //             style: TextStyle(
                            //                 color: const Color(0xffC82024),
                            //                 fontSize: 10.sp,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //         ),
                            //         clientAlart: data?.category,
                            //         titile: data?.title,
                            //         code: data?.code,
                            //         note: data?.note,
                            //         category: data?.category,
                            //       );

                            //     }),

                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.white),
                              child: TableCalendar(
                                firstDay: DateTime.utc(2010, 10, 16),
                                lastDay: DateTime.utc(2030, 3, 14),
                                focusedDay: DateTime.now(),
                              ),
                            ),
                            SizedBox(
                              height: 100.h,
                            )
                          ],
                        )),
                  ),
                );
              }),
            ),
          );
        }));
  }
}

class SeeAllTitle extends StatelessWidget {
  const SeeAllTitle({Key? key, this.titile, this.ontap}) : super(key: key);

  final String? titile;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titile ?? "",
            //"Task in Progress",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp),
          ),
          InkWell(
            onTap: ontap,
            // onTap: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //               const TaskListScreen()));
            // },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 8.w),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff5B58FF)),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                "See All",
                style:
                    TextStyle(color: const Color(0xff5B58FF), fontSize: 14.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  const NoticeCard(
      {Key? key, this.image, this.name, this.notice, this.time, this.title})
      : super(key: key);

  final String? image, title, time, notice, name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                image!,
                //"assets/crm_home/new_project_update.png",
                height: 48.h,
                width: 48.w,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title ?? "",
                      //"New project updated",
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "You have ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff80868D),
                              fontSize: 14.sp),
                        ),
                        Text(
                          notice ?? "",
                          //"#Logo design project"
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              fontSize: 14.sp),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "has been created by ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff80868D),
                              fontSize: 14.sp),
                        ),
                        Text(
                          name ?? "",
                          //"Md Rashed",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff5B58FF),
                              fontSize: 14.sp),
                        )
                      ],
                    )
                  ],
                ),
                Text(
                  time ?? "",
                  style: TextStyle(
                    color: const Color(0xff80868D),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeProjectCard extends StatelessWidget {
  const HomeProjectCard(
      {Key? key,
      this.description,
      this.quantity,
      this.seeMore,
      this.title,
      this.cardImage,
      this.descriptionNextLine,
      this.quantityColor})
      : super(key: key);

  final String? title,
      quantity,
      description,
      seeMore,
      cardImage,
      descriptionNextLine;
  final Color? quantityColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          cardImage!,
          //"assets/crm_home/queue_project.png",
          height: 250.h,
        ),
        Positioned(
          top: 12.h,
          // top: 35.h,
          bottom: 0.h,
          left: 20.w,
          right: 0.w,
          child: Text(
            title ?? "",
            //"Queue Projects"
            style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
        Positioned(
          top: 135.h,
          // top: 35.h,
          bottom: 0.h,
          left: 16.w,
          right: 16.w,
          child: Text(
            //"Lorem ipsum dolor",

            description ?? "",
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 12.sp,
            ),
          ),
        ),
        // Positioned(
        //   top: 150.h,
        //   // top: 35.h,
        //   bottom: 0.h,
        //   left: 57.w,
        //   right: 0.w,
        //   child: Text(
        //     descriptionNextLine ?? "",
        //     //"sit amet",
        //     //textAlign: TextAlign.center,
        //     style: TextStyle(
        //       color: AppColors.black,
        //       fontSize: 12.sp,
        //     ),
        //   ),
        // ),
        Positioned(
          top: 48.h,
          // top: 35.h,
          bottom: 0.h,
          left: 70.w,
          right: 0.w,
          child: Text(
            //"06",
            quantity ?? "",
            //textAlign: TextAlign.center,
            style: TextStyle(
                color: quantityColor ?? AppColors.black,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(
          top: 194.h,
          //top: 35.h,
          bottom: 0.h,
          left: 48.w,
          right: 0.w,
          child: Text(
            seeMore ?? "",
            //"See More",
            style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
